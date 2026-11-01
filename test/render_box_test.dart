import 'package:flutter/rendering.dart'
    hide RenderFittedBox, RenderFractionallySizedOverflowBox;
import 'package:flutter_test/flutter_test.dart';
import 'package:pixel_snap_fork/src/forked/render_fitted_box.dart';
import 'package:pixel_snap_fork/src/forked/render_fractionally_sized_box.dart';
import 'package:pixel_snap_fork/src/pixel_snap.dart';
import 'package:pixel_snap_fork/src/pixel_snap_ext.dart';
import 'package:pixel_snap_fork/src/widgets/pixel_snap_size.dart';

import 'test_rendering.dart';

void main() {
  TestRenderingFlutterBinding.ensureInitialized();

  test('RenderFractionallySizedBox constraints', () {
    final pixelSnap = PixelSnap.custom(devicePixelRatio: 1.0);

    RenderBox root, leaf, test;
    root = RenderPositionedBox(
      child: RenderConstrainedBox(
        additionalConstraints: BoxConstraints.tight(const Size(199.0, 175.0)),
        child: test = RenderFractionallySizedOverflowBox(
          alignment: Alignment.center,
          widthFactor: 1.5,
          heightFactor: 0.5,
          child: leaf = RenderConstrainedBox(
            additionalConstraints: const BoxConstraints.expand(),
          ),
          pixelSnap: pixelSnap,
        ),
      ),
    );
    layout(root);
    expect(root.size.width, equals(800.0));
    expect(root.size.height, equals(600.0));
    expect(test.size.width, equals(199.0));
    expect(test.size.height, equals(175.0));
    expect(leaf.size.width, equals(298.0));
    expect(leaf.size.height, equals(87.0));
  });

  test('RenderPixelSnapSize', () {
    final pixelSnap = PixelSnap.custom(devicePixelRatio: 1.0);

    RenderBox snapSize;
    final root = RenderPositionedBox(
      child: snapSize = RenderPixelSnapSize(
        RenderConstrainedBox(
          additionalConstraints: const BoxConstraints.tightFor(
            width: 99.2,
            height: 99.8,
          ),
        ),
        pixelSnap,
        PixelSnapMode.snap,
      ),
    );
    layout(root);

    expect(snapSize.size.width, 99.0);
    expect(snapSize.size.height, 100.0);
  });

  test('RenderPixelSnapSize dry layout leaves the child alone', () {
    final pixelSnap = PixelSnap.custom(devicePixelRatio: 1.0);
    final child = RenderConstrainedBox(
      additionalConstraints: const BoxConstraints.tightFor(
        width: 99.2,
        height: 99.8,
      ),
    );
    final snapSize = RenderPixelSnapSize(child, pixelSnap, PixelSnapMode.snap);
    RenderPositionedBox(child: snapSize);

    final dry = snapSize.getDryLayout(
      BoxConstraints.loose(const Size(800, 600)),
    );

    expect(dry, const Size(99, 100));
    expect(child.hasSize, isFalse);
  });

  test('RenderPixelSnapSize lays out again when the mode changes', () {
    final pixelSnap = PixelSnap.custom(devicePixelRatio: 1.0);
    final snapSize = RenderPixelSnapSize(
      RenderConstrainedBox(
        additionalConstraints: const BoxConstraints.tightFor(
          width: 99.2,
          height: 99.8,
        ),
      ),
      pixelSnap,
      PixelSnapMode.snap,
    );
    layout(RenderPositionedBox(child: snapSize));
    expect(snapSize.size, const Size(99, 100));

    snapSize.pixelSnapMode = PixelSnapMode.ceil;
    pumpFrame();

    expect(snapSize.size, const Size(100, 100));
  });

  test('RenderFittedBox takes a new PixelSnap', () {
    final ratio1 = PixelSnap.custom(devicePixelRatio: 1.0);
    final ratio2 = PixelSnap.custom(devicePixelRatio: 2.0);
    final fittedBox = RenderFittedBox(
      alignment: Alignment.center,
      pixelSnap: ratio1,
    );

    fittedBox.pixelSnap = ratio2;

    expect(fittedBox.pixelSnap, ratio2);
    expect(fittedBox.alignment, Alignment.center.pixelSnap(ratio2));
  });

  test('Alignment centers on pixel boundary', () {
    final pixelSnap = PixelSnap.custom(devicePixelRatio: 1.0);

    RenderBox box;
    final root = RenderPositionedBox(
      alignment: Alignment.center.pixelSnap(pixelSnap),
      child: box = RenderConstrainedBox(
        additionalConstraints: const BoxConstraints.tightFor(
          width: 11,
          height: 13,
        ),
      ),
    );
    layout(root);

    expect((box.parentData as BoxParentData).offset.dx, equals(394));
    expect((box.parentData as BoxParentData).offset.dy, equals(293));
  });
}
