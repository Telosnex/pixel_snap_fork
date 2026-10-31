import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:pixel_snap_generator/parser.dart';

class GeneratorException implements Exception {
  GeneratorException(this.message);

  final String message;

  @override
  String toString() => 'GeneratorException: $message';
}

class Generator {
  Generator(this.contents);

  final List<String> _ourCustomClasses = [
    'RawImage',
    'ScrollController',
  ];

  String generateWidgets() {
    _buffer.clear();
    _buffer.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND');
    _buffer.writeln('// Update: cd generator && dart run bin/generate.dart');
    // The copied Flutter source has asserts, deprecated members and imports
    // of Flutter internals.
    _buffer.writeln(
      '// ignore_for_file: unnecessary_null_comparison, deprecated_member_use, '
      'deprecated_member_use_from_same_package, implementation_imports',
    );

    final widgetsHides = contents.widgetsHides.isEmpty
        ? ''
        : ' hide ${contents.widgetsHides.join(', ')}';
    _buffer.writeln("import 'package:flutter/widgets.dart'$widgetsHides;");
    _buffer.writeln("import 'package:flutter/widgets.dart' as widgets;");
    for (final import in contents.imports) {
      _buffer.writeln(import.directive);
    }
    _buffer.writeln("import '../pixel_snap.dart';");
    _buffer.writeln("import '../pixel_snap_ext.dart';");
    _buffer.writeln("import '../widgets/pixel_snap_size.dart';");
    for (final local in contents.localImports) {
      _buffer.writeln("import '$local';");
    }
    _buffer.writeln(
      "export 'package:flutter/widgets.dart' hide ${_ourCustomClasses.join(', ')};",
    );

    for (final c in contents.classes) {
      _buffer.writeln();
      _writeClass(c);
    }

    for (final c in contents.forkedClasses) {
      _writeForkedClass(c.contents);
    }

    for (final helper in contents.helpers) {
      _writeForkedClass(helper);
    }

    return _buffer.toString();
  }

  String generatePackage(String name) {
    _buffer.clear();
    _buffer.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND');
    final classes = [
      ..._ourCustomClasses,
      ...contents.forkedClasses.map((e) => e.className),
      ...contents.classes.map((e) => e.className)
    ].join(', ');

    _buffer.writeln(
        'export \'package:${name}_ui/${name}_ui.dart\' hide $classes;');
    _buffer.writeln('export \'widgets.dart\';');

    return _buffer.toString();
  }

  /// Writes copied Flutter source. Render objects get the [PixelSnap] of the
  /// context.
  void _writeForkedClass(String source) {
    var contents = source;
    contents = contents.replaceAllMapped(
      RegExp('return Render(.*)\\('),
      (match) {
        final name = match.group(1);
        return 'return Render$name(pixelSnap: PixelSnap.of(context),';
      },
    );
    contents = contents.replaceAllMapped(
      RegExp('renderObject\\n(\\s+)\\.\\.'),
      (match) {
        return 'renderObject\n..pixelSnap = PixelSnap.of(context)\n..';
      },
    );
    _buffer.writeln(contents);
  }

  void _writeClass(Class c) {
    if (c.docString != null) {
      _buffer.writeln(c.docString);
    }
    _buffer.writeln('class ${c.className} extends StatelessWidget {');

    for (final constructor in c.constructors) {
      if (constructor.docString != null) {
        _buffer.writeln(constructor.docString);
      }
      var code = constructor.code.replaceAll('super.child', 'this.child');
      for (final f in c.fields) {
        if (f.fromSuperClass) {
          final defaultCode =
              f.defaultValue != null ? ' = ${f.defaultValue!}' : '';
          code =
              code.replaceAll('super.${f.name}', 'this.${f.name} $defaultCode');
        }
      }
      if (c.className == 'AnimatedCrossFade') {
        code = code.replaceAll('defaultLayoutBuilder',
            'widgets.AnimatedCrossFade.defaultLayoutBuilder');
      }
      _buffer.writeln(code);
    }

    if (c.fields.any((element) => element.name == 'child') == false) {
      if (c.childType != ChildType.none) {
        _buffer.writeln();
        _buffer.writeln('/// {@macro flutter.widgets.ProxyWidget.child}');
        final suffix = c.childType == ChildType.nullable ? '?' : '';
        _buffer.writeln('final Widget$suffix child;');
      }
    }

    for (final field in c.fields) {
      if (field.docString != null) {
        _buffer.writeln(field.docString);
      }
      _buffer.writeln(
          'final ${field.type}${field.nullable ? '?' : ''} ${field.name};');
    }

    _buffer.writeln();
    _buffer.writeln('@override');
    _buffer.writeln('Widget build(BuildContext context) {');

    const pixelSnapWhitelist = [
      'double',
      'EdgeInsetsGeometry',
      'Size',
      'Decoration',
      'BoxConstraints',
      'AlignmentGeometry',
      'BorderRadius',
    ];
    const pixelSnapBlackList = [
      'widthFactor',
      'heightFactor',
      'fill',
      'weight',
      'grade',
      'opticalSize',
    ];

    bool shouldPixelSnap(Field field) =>
        pixelSnapWhitelist.contains(field.type) &&
        !pixelSnapBlackList.contains(field.name);

    if (c.fields.any(shouldPixelSnap)) {
      _buffer.writeln('final ps = PixelSnap.of(context);');
    }

    _buffer.writeln('Widget res = widgets.${c.className}(');

    for (final field in c.fields) {
      if (field.name == 'child') {
        continue;
      }

      var pixelSnapSuffix = '';
      if (shouldPixelSnap(field)) {
        pixelSnapSuffix = '.pixelSnap(ps)';
      }
      if (pixelSnapSuffix.isNotEmpty && field.nullable) {
        pixelSnapSuffix = '?$pixelSnapSuffix';
      }
      if (field.named) {
        _buffer.write('${field.name}: ');
      }
      _buffer.writeln('${field.name}$pixelSnapSuffix,');
    }
    if (c.childType != ChildType.none) {
      _buffer.writeln('child: child,');
    }
    _buffer.writeln(');');

    if (c.className == 'ImageIcon') {
      _buffer.writeln('if (size == null) { res = PixelSnapSize(child:res); }');
    }
    _buffer.writeln('return res;');
    _buffer.writeln('}');

    _buffer.writeln('}');
  }

  final _buffer = StringBuffer();
  final Contents contents;
}

/// The names that this package defines in place of Flutter's, and the files
/// that define them, relative to the generated files.
const localOverrides = {
  'RawImage': '../forked/raw_image.dart',
  'RenderFittedBox': '../forked/render_fitted_box.dart',
  'RenderFlex': '../forked/render_flex.dart',
  'RenderFractionallySizedOverflowBox':
      '../forked/render_fractionally_sized_box.dart',
  'RenderParagraph': '../forked/render_paragraph.dart',
};

/// Generates `widgets.dart`, `material.dart` and `cupertino.dart` in
/// [outputPath] from [inputFile], and formats them with `dart format`.
Future<void> generate({
  required String inputFile,
  required String outputPath,
}) async {
  final parser = Parser(inputFile, localOverrides: localOverrides);
  final contents = await parser.parse();

  final files = {
    'widgets.dart': Generator(contents).generateWidgets(),
    'material.dart': Generator(contents).generatePackage('material'),
    'cupertino.dart': Generator(contents).generatePackage('cupertino'),
  };
  for (final MapEntry(key: name, value: source) in files.entries) {
    File(path.join(outputPath, name)).writeAsStringSync(source);
  }

  // dart format reads the language version and the page width of the package.
  final result = await Process.run('dart', [
    'format',
    for (final name in files.keys) path.join(outputPath, name),
  ]);
  if (result.exitCode != 0) {
    throw GeneratorException('dart format failed:\n${result.stderr}');
  }
}
