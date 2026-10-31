// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as path;

/// Keeps the files that pixel_snap_fork copies from Flutter current.
///
/// For each fork, `upstream/` keeps the Flutter file that the fork started
/// from (the base), formatted like the package. With a new Flutter:
///
///  * `check` fails if the Flutter file changed since the base.
///  * `update` merges the changes into the fork (`git merge-file`) and moves
///    the base to the new Flutter. Conflicts stay in the fork as conflict
///    markers.
///
/// Run it in generator/, after `flutter pub get` in the package root: the
/// Flutter SDK is the one that the package resolves to.
Future<void> main(List<String> args) async {
  final command = args.singleOrNull;
  if (command != 'check' && command != 'update') {
    print('Usage: dart run bin/forks.dart check|update');
    exit(64);
  }

  final packageRoot = path.normalize(path.absolute('..'));
  final flutterPackage = _flutterPackage(packageRoot);
  final flutterVersion = _flutterVersion(flutterPackage);
  final versionFile = File('upstream/flutter_version.txt');
  final baseVersion = versionFile.existsSync()
      ? versionFile.readAsStringSync().trim()
      : 'unknown';

  var changed = 0;
  var conflicts = 0;
  for (final fork in forks) {
    final local = File(path.join(packageRoot, fork.local));
    final base = File(path.join('upstream', fork.base));
    final upstream = await _formatted(
      File(path.join(flutterPackage, fork.upstream)).readAsStringSync(),
      packageRoot,
    );
    if (base.readAsStringSync() == upstream) {
      print('${fork.local}: current with Flutter $flutterVersion');
      continue;
    }
    changed++;
    if (command == 'check') {
      print(
        '${fork.local}: Flutter changed ${fork.upstream} since $baseVersion '
        '(now $flutterVersion)',
      );
      continue;
    }

    final newBase = File(
      path.join(Directory.systemTemp.createTempSync('forks').path, fork.base),
    )..writeAsStringSync(upstream);
    final result = await Process.run('git', [
      'merge-file',
      '-L',
      'pixel_snap_fork',
      '-L',
      'Flutter $baseVersion',
      '-L',
      'Flutter $flutterVersion',
      local.path,
      base.path,
      newBase.path,
    ]);
    if (result.exitCode < 0 || result.exitCode > 127) {
      throw Exception('git merge-file failed: ${result.stderr}');
    }
    base.writeAsStringSync(upstream);
    conflicts += result.exitCode;
    print(
      '${fork.local}: merged Flutter $flutterVersion'
      '${result.exitCode == 0 ? '' : ', ${result.exitCode} conflicts'}',
    );
  }

  if (command == 'update' && changed > 0) {
    versionFile.writeAsStringSync('$flutterVersion\n');
  }
  if (command == 'check' && changed > 0) {
    print(
      '\nRun `dart run bin/forks.dart update` in generator/ to merge the '
      'changes, then run the tests.',
    );
    exit(1);
  }
  if (conflicts > 0) {
    print('\nResolve the conflicts, then run the tests.');
    exit(1);
  }
}

class Fork {
  const Fork({required this.upstream, required this.local, required this.base});

  /// The Flutter file, relative to the flutter package.
  final String upstream;

  /// The fork, relative to the package root.
  final String local;

  /// The base, relative to upstream/.
  final String base;
}

/// The Flutter files that pixel_snap_fork copies in full.
const forks = [
  Fork(
    upstream: 'lib/src/rendering/flex.dart',
    local: 'lib/src/forked/render_flex.dart',
    base: 'flex.dart',
  ),
];

/// The path of the flutter package that [packageRoot] resolves to.
String _flutterPackage(String packageRoot) {
  final configFile = File(
    path.join(packageRoot, '.dart_tool', 'package_config.json'),
  );
  if (!configFile.existsSync()) {
    print('Run flutter pub get in $packageRoot first.');
    exit(1);
  }
  final config = jsonDecode(configFile.readAsStringSync()) as Map;
  final flutter = (config['packages'] as List).cast<Map>().firstWhere(
    (p) => p['name'] == 'flutter',
  );
  return configFile.uri.resolve(flutter['rootUri'] as String).toFilePath();
}

/// The version of the Flutter SDK that [flutterPackage] belongs to.
String _flutterVersion(String flutterPackage) {
  final file = File(
    path.join(
      flutterPackage,
      '..',
      '..',
      'bin',
      'cache',
      'flutter.version.json',
    ),
  );
  if (!file.existsSync()) return 'unknown';
  final json = jsonDecode(file.readAsStringSync()) as Map;
  return json['frameworkVersion'] as String? ?? 'unknown';
}

/// [source] formatted like the files of the package at [packageRoot]: same
/// language version and page width.
Future<String> _formatted(String source, String packageRoot) async {
  final dir = Directory(path.join(packageRoot, '.dart_tool', 'forks'))
    ..createSync(recursive: true);
  final file = File(path.join(dir.path, 'upstream.dart'))
    ..writeAsStringSync(source);
  final result = await Process.run('dart', ['format', file.path]);
  if (result.exitCode != 0) {
    throw Exception('dart format failed: ${result.stderr}');
  }
  return file.readAsStringSync();
}
