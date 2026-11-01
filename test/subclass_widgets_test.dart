import 'dart:typed_data';

import 'package:flutter/rendering.dart' as rendering;
import 'package:flutter/widgets.dart' as fl;
import 'package:flutter_test/flutter_test.dart';
import 'package:pixel_snap_fork/src/forked/render_fitted_box.dart' as ps;
import 'package:pixel_snap_fork/src/forked/render_fractionally_sized_box.dart'
    as ps;
import 'package:pixel_snap_fork/src/forked/render_image.dart' as ps;
import 'package:pixel_snap_fork/widgets.dart';

Widget _app(Widget child, {double devicePixelRatio = 1.0}) => MediaQuery(
  data: MediaQueryData(devicePixelRatio: devicePixelRatio),
  child: Directionality(
    textDirection: TextDirection.ltr,
    child: Align(alignment: Alignment.topLeft, child: child),
  ),
);

/// A transparent PNG of 1 by 1 pixels.
final _png = Uint8List.fromList([
  137,
  80,
  78,
  71,
  13,
  10,
  26,
  10,
  0,
  0,
  0,
  13,
  73,
  72,
  68,
  82,
  0,
  0,
  0,
  1,
  0,
  0,
  0,
  1,
  8,
  6,
  0,
  0,
  0,
  31,
  21,
  196,
  137,
  0,
  0,
  0,
  11,
  73,
  68,
  65,
  84,
  120,
  156,
  99,
  96,
  0,
  2,
  0,
  0,
  5,
  0,
  1,
  122,
  94,
  171,
  63,
  0,
  0,
  0,
  0,
  73,
  69,
  78,
  68,
  174,
  66,
  96,
  130,
]);

final _provider = MemoryImage(_png);

void main() {
  group('Image', () {
    testWidgets('find.image finds it', (tester) async {
      await tester.pumpWidget(_app(Image(image: _provider)));

      expect(find.image(_provider), findsOneWidget);
      expect(tester.widget<fl.Image>(find.byType(Image)).image, _provider);
    });

    testWidgets('the named constructors make Flutter images', (tester) async {
      final bytes = _png;
      await tester.pumpWidget(_app(Image.memory(bytes, scale: 2.0)));

      final image = tester.widget<fl.Image>(find.byType(Image));
      expect(image, isA<fl.Image>());
      expect(
        image.image,
        isA<MemoryImage>()
            .having((m) => m.bytes, 'bytes', same(bytes))
            .having((m) => m.scale, 'scale', 2.0),
      );
      // Defaults come from Flutter's constructor.
      expect(image.filterQuality, FilterQuality.medium);
    });

    testWidgets('uses the pixel-snapping RawImage', (tester) async {
      await tester.pumpWidget(
        _app(Image(image: _provider, width: 10.3, height: 20.6)),
      );

      final render = tester.renderObject<rendering.RenderImage>(
        find.byType(RawImage),
      );
      expect(render, isA<ps.RenderImagePixelSnap>());
      expect(render.size, const Size(10, 21));
    });
  });

  testWidgets('FittedBox is a Flutter FittedBox', (tester) async {
    await tester.pumpWidget(
      _app(const FittedBox(fit: BoxFit.fill, child: SizedBox(width: 1))),
    );

    final box = tester.widget<fl.FittedBox>(find.byType(FittedBox));
    expect(box.fit, BoxFit.fill);
    expect(box.clipBehavior, Clip.none);
    expect(
      tester.renderObject(find.byType(FittedBox)),
      isA<ps.RenderFittedBox>(),
    );
  });

  testWidgets('FractionallySizedBox is a Flutter FractionallySizedBox', (
    tester,
  ) async {
    await tester.pumpWidget(
      _app(
        const SizedBox(
          width: 100.5,
          height: 100,
          child: FractionallySizedBox(widthFactor: 0.333),
        ),
      ),
    );

    final box = tester.widget<fl.FractionallySizedBox>(
      find.byType(FractionallySizedBox),
    );
    expect(box.widthFactor, 0.333);
    expect(box.alignment, Alignment.center);
    expect(
      tester.renderObject(find.byType(FractionallySizedBox)),
      isA<ps.RenderFractionallySizedOverflowBox>(),
    );
  });
}
