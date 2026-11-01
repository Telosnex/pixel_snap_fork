import 'package:flutter/rendering.dart' as rendering;
import 'package:flutter/rendering.dart' hide RenderFractionallySizedOverflowBox;

import '../pixel_snap.dart';
import '../pixel_snap_ext.dart';

/// Pixel-snap aware version of [rendering.RenderFractionallySizedOverflowBox].
///
/// Extends Flutter's implementation to add pixel snapping to constraints
/// and alignment.
class RenderFractionallySizedOverflowBox
    extends rendering.RenderFractionallySizedOverflowBox {
  RenderFractionallySizedOverflowBox({
    super.child,
    super.widthFactor,
    super.heightFactor,
    required AlignmentGeometry alignment,
    required PixelSnap pixelSnap,
    super.textDirection,
  }) : _pixelSnap = pixelSnap,
       _originalAlignment = alignment,
       super(alignment: alignment.pixelSnap(pixelSnap));

  PixelSnap _pixelSnap;
  AlignmentGeometry _originalAlignment;

  PixelSnap get pixelSnap => _pixelSnap;

  set pixelSnap(PixelSnap value) {
    if (_pixelSnap != value) {
      _pixelSnap = value;
      alignment = _originalAlignment;
      markNeedsLayout();
    }
  }

  @override
  set alignment(AlignmentGeometry value) {
    _originalAlignment = value;
    super.alignment = value.pixelSnap(_pixelSnap);
  }

  BoxConstraints _getInnerConstraintsPixelSnapped(BoxConstraints constraints) {
    double minWidth = constraints.minWidth;
    double maxWidth = constraints.maxWidth;
    if (widthFactor != null) {
      final double width = maxWidth * widthFactor!;
      minWidth = width;
      maxWidth = width;
    }
    double minHeight = constraints.minHeight;
    double maxHeight = constraints.maxHeight;
    if (heightFactor != null) {
      final double height = maxHeight * heightFactor!;
      minHeight = height;
      maxHeight = height;
    }
    return BoxConstraints(
      minWidth: minWidth.pixelSnap(pixelSnap),
      maxWidth: maxWidth.pixelSnap(pixelSnap),
      minHeight: minHeight.pixelSnap(pixelSnap),
      maxHeight: maxHeight.pixelSnap(pixelSnap),
    );
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    final double result;
    if (child == null) {
      result = super.computeMinIntrinsicWidth(height);
    } else {
      result = child!.getMinIntrinsicWidth(
        (height * (heightFactor ?? 1.0)).pixelSnap(pixelSnap),
      );
    }
    assert(result.isFinite);
    return (result / (widthFactor ?? 1.0)).pixelSnap(pixelSnap);
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    final double result;
    if (child == null) {
      result = super.computeMaxIntrinsicWidth(height);
    } else {
      result = child!.getMaxIntrinsicWidth(
        (height * (heightFactor ?? 1.0)).pixelSnap(pixelSnap),
      );
    }
    assert(result.isFinite);
    return (result / (widthFactor ?? 1.0)).pixelSnap(pixelSnap);
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    final double result;
    if (child == null) {
      result = super.computeMinIntrinsicHeight(width);
    } else {
      result = child!.getMinIntrinsicHeight(
        (width * (widthFactor ?? 1.0)).pixelSnap(pixelSnap),
      );
    }
    assert(result.isFinite);
    return (result / (heightFactor ?? 1.0)).pixelSnap(pixelSnap);
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    final double result;
    if (child == null) {
      result = super.computeMaxIntrinsicHeight(width);
    } else {
      result = child!.getMaxIntrinsicHeight(
        (width * (widthFactor ?? 1.0)).pixelSnap(pixelSnap),
      );
    }
    assert(result.isFinite);
    return (result / (heightFactor ?? 1.0)).pixelSnap(pixelSnap);
  }

  @override
  Size computeDryLayout(covariant BoxConstraints constraints) {
    if (child != null) {
      final Size childSize = child!.getDryLayout(
        _getInnerConstraintsPixelSnapped(constraints),
      );
      return constraints.constrain(childSize);
    }
    return constraints.constrain(
      _getInnerConstraintsPixelSnapped(constraints).constrain(Size.zero),
    );
  }

  @override
  void performLayout() {
    if (child != null) {
      child!.layout(
        _getInnerConstraintsPixelSnapped(constraints),
        parentUsesSize: true,
      );
      size = constraints.constrain(child!.size);
      alignChild();
    } else {
      size = constraints.constrain(
        _getInnerConstraintsPixelSnapped(constraints).constrain(Size.zero),
      );
    }
  }
}
