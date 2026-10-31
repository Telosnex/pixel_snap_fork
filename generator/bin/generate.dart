// ignore_for_file: avoid_print

import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart' as path;
import 'package:pixel_snap_generator/generator.dart';

/// Generates lib/src/generated/ of pixel_snap_fork. Run it in generator/.
Future<void> main(List<String> args) async {
  final parser = ArgParser()
    ..addOption(
      'input',
      abbr: 'i',
      help: 'Path to the input file',
      defaultsTo: '../lib/src/widgets_in.dart',
    )
    ..addOption(
      'output',
      abbr: 'o',
      help: 'Folder for the generated files',
      defaultsTo: '../lib/src/generated',
    )
    ..addFlag('help', abbr: 'h', negatable: false);
  final parsed = parser.parse(args);
  if (parsed.flag('help')) {
    print('Usage:\n${parser.usage}');
    return;
  }
  final inputFile = path.normalize(path.absolute(parsed.option('input')!));
  final outputPath = path.normalize(path.absolute(parsed.option('output')!));

  if (!File(inputFile).existsSync()) {
    print('Input file does not exist: $inputFile');
    exit(1);
  }
  if (!Directory(outputPath).existsSync()) {
    print('Output folder does not exist: $outputPath');
    exit(1);
  }

  print('Input: $inputFile');
  print('Output: $outputPath');
  await generate(inputFile: inputFile, outputPath: outputPath);
}
