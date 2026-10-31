import 'package:flutter/material.dart' as fl;
import 'package:flutter/rendering.dart' as rendering;
import 'package:flutter_test/flutter_test.dart';
import 'package:pixel_snap_fork/src/forked/render_paragraph.dart' as ps;
import 'package:pixel_snap_fork/widgets.dart';

Widget _app(Widget child, {double devicePixelRatio = 1.0}) => MediaQuery(
  data: MediaQueryData(devicePixelRatio: devicePixelRatio),
  child: Directionality(
    textDirection: TextDirection.ltr,
    child: Align(alignment: Alignment.topLeft, child: child),
  ),
);

void main() {
  testWidgets('the finders of flutter_test find Text once', (tester) async {
    await tester.pumpWidget(
      _app(
        const Column(
          children: [
            Text('hello'),
            Text.rich(TextSpan(text: 'rich')),
          ],
        ),
      ),
    );

    expect(find.text('hello'), findsOneWidget);
    expect(find.textContaining('ell'), findsOneWidget);
    expect(find.text('rich'), findsOneWidget);
    expect(find.widgetWithText(Column, 'hello'), findsOneWidget);
    expect(tester.widget<Text>(find.text('hello')).data, 'hello');
    expect(tester.widget<fl.Text>(find.text('hello')).data, 'hello');
    expect(find.byType(Text), findsNWidgets(2));
    // findRichText: true looks at the RichText instead of the Text.
    expect(find.text('hello', findRichText: true), findsOneWidget);
    expect(
      tester
          .widget<fl.RichText>(find.byType(RichText).first)
          .text
          .toPlainText(),
      'hello',
    );
  });

  testWidgets('Text uses the pixel-snapping RenderParagraph', (tester) async {
    await tester.pumpWidget(
      _app(
        const Text(
          'hello',
          style: TextStyle(fontSize: 13.3, letterSpacing: 0.37),
        ),
        devicePixelRatio: 2.0,
      ),
    );

    final paragraph = tester.renderObject<rendering.RenderParagraph>(
      find.byType(RichText),
    );
    expect(paragraph, isA<ps.RenderParagraph>());
    final size = paragraph.size * 2.0;
    expect(size.width, size.width.roundToDouble());
    expect(size.height, size.height.roundToDouble());
  });

  testWidgets('selectable Text uses the pixel-snapping RenderParagraph', (
    tester,
  ) async {
    await tester.pumpWidget(
      fl.MaterialApp(home: fl.SelectionArea(child: Text('hello'))),
    );

    expect(find.text('hello'), findsOneWidget);
    expect(
      tester.renderObject(find.byType(RichText)),
      isA<ps.RenderParagraph>(),
    );
  });

  testWidgets('RichText takes a new PixelSnap', (tester) async {
    Future<void> pump(double ratio) => tester.pumpWidget(
      _app(
        RichText(text: const TextSpan(text: 'hello')),
        devicePixelRatio: ratio,
      ),
    );
    await pump(1.0);
    final paragraph = tester.renderObject<ps.RenderParagraph>(
      find.byType(RichText),
    );
    expect(paragraph.pixelSnap.devicePixelRatio, 1.0);

    await pump(3.0);

    expect(paragraph.pixelSnap.devicePixelRatio, 3.0);
  });
}
