@TestOn('vm')
library;

import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:pixel_snap_generator/generator.dart';
import 'package:pixel_snap_generator/parser.dart';
import 'package:test/test.dart';

/// The package root, with `flutter pub get` done.
final _packageRoot = path.normalize(path.absolute('..'));
final _input = path.join(_packageRoot, 'lib', 'src', 'widgets_in.dart');

void main() {
  group('Generator', () {
    Contents contents(List<Class> classes) => Contents(
      classes: classes,
      forkedClasses: const [],
      helpers: const [],
      imports: const [],
      localImports: const [],
      widgetsHides: const [],
    );

    Field field(
      String name,
      String type, {
      bool nullable = false,
      bool named = true,
    }) => Field(
      type: type,
      name: name,
      docString: null,
      nullable: nullable,
      fromSuperClass: false,
      named: named,
    );

    test('a wrapper snaps the sizes and passes the rest as is', () {
      final source = Generator(
        contents([
          Class(
            constructors: [
              Constructor(
                docString: null,
                code:
                    'const Gap({super.key, this.width, this.factor, '
                    'required this.color, this.child});',
              ),
            ],
            fields: [
              field('width', 'double', nullable: true),
              field('factor', 'double'),
              field('widthFactor', 'double'),
              field('color', 'Color'),
              field('child', 'Widget', nullable: true),
            ],
            docString: '/// A gap.',
            className: 'Gap',
            childType: ChildType.nullable,
          ),
        ]),
      ).generateWidgets();

      expect(source, contains('class Gap extends StatelessWidget {'));
      expect(source, contains('final ps = PixelSnap.of(context);'));
      expect(source, contains('Widget res = widgets.Gap('));
      expect(source, contains('width: width?.pixelSnap(ps),'));
      expect(source, contains('factor: factor.pixelSnap(ps),'));
      // Factors are ratios, not sizes.
      expect(source, contains('widthFactor: widthFactor,'));
      expect(source, contains('color: color,'));
      expect(source, contains('child: child,'));
    });

    test('a forked render object gets the PixelSnap of the context', () {
      final source = Generator(
        Contents(
          classes: const [],
          forkedClasses: [
            ForkedClass(
              className: 'Box',
              contents: '''
class Box extends SingleChildRenderObjectWidget {
  @override
  RenderBox createRenderObject(BuildContext context) {
    return RenderBox(size: size);
  }

  @override
  void updateRenderObject(BuildContext context, RenderBox renderObject) {
    renderObject
      ..size = size;
  }
}
''',
            ),
          ],
          helpers: const [],
          imports: const [],
          localImports: const [],
          widgetsHides: const [],
        ),
      ).generateWidgets();

      expect(
        source,
        contains('return RenderBox(pixelSnap: PixelSnap.of(context),size'),
      );
      expect(
        source,
        contains('renderObject\n..pixelSnap = PixelSnap.of(context)\n..size'),
      );
    });

    test('the material library hides the replaced widgets', () {
      final source = Generator(
        contents([
          Class(
            constructors: const [],
            fields: const [],
            docString: null,
            className: 'Padding',
            childType: ChildType.nullable,
          ),
        ]),
      ).generatePackage('material');

      expect(
        source,
        contains(
          "export 'package:material_ui/material_ui.dart' "
          'hide RawImage, ScrollController, Padding;',
        ),
      );
      expect(source, contains("export 'widgets.dart';"));
    });
  });

  group('ImportSpec', () {
    test('writes configurations, prefix and sorted names', () {
      final spec = ImportSpec(
        uri: 'package:a/io.dart',
        prefix: 'a',
        configurations: ["if (dart.library.js_interop) 'package:a/web.dart'"],
        show: {'B', 'A'},
      );
      expect(
        spec.directive,
        "import 'package:a/io.dart' "
        "if (dart.library.js_interop) 'package:a/web.dart' as a show A, B;",
      );
    });
  });

  group('Parser on widgets_in.dart', () {
    late Contents contents;

    setUpAll(() async {
      contents = await Parser(_input, localOverrides: localOverrides).parse();
    });

    test('finds the private helpers of Text', () {
      expect(
        contents.helpers,
        contains(contains('class _OverridingTextStyleTextSpanUtils {')),
      );
      expect(
        contents.helpers,
        contains(contains('class _SelectableTextContainer extends')),
      );
    });

    test('keeps the conditional imports of Image', () {
      final web = contents.imports.where(
        (i) => i.uri.endsWith('_web_image_io.dart'),
      );
      expect(web, hasLength(1));
      expect(
        web.single.configurations.single,
        "if (dart.library.js_interop) "
        "'package:flutter/src/widgets/_web_image_web.dart'",
      );
    });

    test('makes Text and RichText subclasses of Flutter\'s', () {
      String source(String name) => contents.forkedClasses
          .singleWhere((c) => c.className == name)
          .contents;

      final text = source('Text');
      expect(text, contains('class Text extends widgets.Text {'));
      expect(text, contains('const Text(super.data, {super.key, '));
      expect(text, contains('}) : super.rich();'));
      expect(text, contains('Widget build(BuildContext context)'));
      // Flutter's Text has the fields and debugFillProperties.
      expect(text, isNot(contains('final String? data;')));
      expect(text, isNot(contains('debugFillProperties')));

      final richText = source('RichText');
      expect(richText, contains('class RichText extends widgets.RichText {'));
      expect(richText, contains('required super.text,'));
      expect(richText, contains('RenderParagraph createRenderObject('));
      expect(richText, contains('void updateRenderObject('));
      // Private, so not visible in Flutter's class: copied because the render
      // object methods use it.
      expect(richText, contains('double _getDevicePixelRatio('));
      // Used only by the constructor, which Flutter's class keeps.
      expect(richText, isNot(contains('_effectiveTextScalerFrom')));
    });

    test('makes Image a subclass of Flutter\'s', () {
      final image = contents.forkedClasses
          .singleWhere((c) => c.className == 'Image')
          .contents;
      expect(image, contains('class Image extends widgets.Image {'));
      // Named constructors take positional arguments as super parameters.
      expect(image, contains('Image.network(super.src, {'));
      expect(image, contains('}) : super.network();'));
      expect(image, contains('State<Image> createState() => _ImageState();'));
      // The state is private: it is copied as a helper.
      expect(
        contents.helpers,
        contains(contains('class _ImageState extends State<Image>')),
      );
    });

    test("uses this package's render objects", () {
      expect(contents.localImports, contains('../forked/render_flex.dart'));
      expect(
        contents.imports.expand((i) => i.show),
        isNot(contains('RenderFlex')),
      );
    });
  });

  test('lib/src/generated is current with the Flutter SDK', () async {
    // In the package, so that dart format formats it like the package.
    final output = Directory(
      path.join(_packageRoot, '.dart_tool', 'generator_test'),
    )..createSync(recursive: true);
    await generate(inputFile: _input, outputPath: output.path);

    for (final name in ['widgets.dart', 'material.dart', 'cupertino.dart']) {
      final checkedIn = File(
        path.join(_packageRoot, 'lib', 'src', 'generated', name),
      ).readAsStringSync();
      final generated = File(path.join(output.path, name)).readAsStringSync();
      expect(
        generated == checkedIn,
        isTrue,
        reason:
            'lib/src/generated/$name is out of date. Run '
            '`dart run bin/generate.dart` in generator/.',
      );
    }
  }, timeout: const Timeout(Duration(minutes: 3)));
}
