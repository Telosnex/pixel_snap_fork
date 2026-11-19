// GENERATED CODE - DO NOT MODIFY BY HAND
// Update: cd generator && dart run bin/generate.dart
// ignore_for_file: unnecessary_null_comparison, deprecated_member_use, deprecated_member_use_from_same_package, implementation_imports
import 'package:flutter/widgets.dart' hide RawImage;
import 'package:flutter/widgets.dart' as widgets;

import 'dart:math' show max, min;
import 'dart:ui' as ui show Hyphens, TextHeightBehavior;

import 'package:flutter/foundation.dart'
    show
        DiagnosticPropertiesBuilder,
        DiagnosticsProperty,
        DoubleProperty,
        EnumProperty,
        kDebugMode,
        precisionErrorTolerance;
import 'package:flutter/rendering.dart'
    show
        ClearSelectionEvent,
        OverflowBoxFit,
        SelectParagraphSelectionEvent,
        Selectable,
        SelectedContentRange,
        SelectionEdgeUpdateEvent,
        SelectionEvent,
        SelectionEventType,
        SelectionGeometry,
        SelectionRegistrar,
        SelectionResult,
        TextGranularity;
import 'package:flutter/scheduler.dart' show SchedulerBinding;
import 'package:flutter/semantics.dart' show SemanticsBinding;
import 'package:flutter/src/painting/_web_image_info_io.dart'
    if (dart.library.js_interop) 'package:flutter/src/painting/_web_image_info_web.dart'
    show WebImageInfo;
import 'package:flutter/src/widgets/_web_image_io.dart'
    if (dart.library.js_interop) 'package:flutter/src/widgets/_web_image_web.dart'
    show RawWebImage;

import '../pixel_snap.dart';
import '../pixel_snap_ext.dart';
import '../widgets/pixel_snap_size.dart';
import '../forked/raw_image.dart';
import '../forked/render_fitted_box.dart';
import '../forked/render_flex.dart';
import '../forked/render_fractionally_sized_box.dart';
import '../forked/render_paragraph.dart';

export 'package:flutter/widgets.dart' hide RawImage, ScrollController;

/// A widget that aligns its child within itself and optionally sizes itself
/// based on the child's size.
///
/// For example, to align a box at the bottom right, you would pass this box a
/// tight constraint that is bigger than the child's natural size,
/// with an alignment of [Alignment.bottomRight].
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=g2E7yl3MwMk}
///
/// This widget will be as big as possible if its dimensions are constrained and
/// [widthFactor] and [heightFactor] are null. If a dimension is unconstrained
/// and the corresponding size factor is null then the widget will match its
/// child's size in that dimension. If a size factor is non-null then the
/// corresponding dimension of this widget will be the product of the child's
/// dimension and the size factor. For example if widthFactor is 2.0 then
/// the width of this widget will always be twice its child's width.
///
/// {@tool snippet}
///
/// The [Align] widget in this example uses one of the defined constants from
/// [Alignment], [Alignment.topRight]. This places the [FlutterLogo] in the top
/// right corner of the parent blue [Container].
///
/// ![A blue square container with the Flutter logo in the top right corner.](https://flutter.github.io/assets-for-api-docs/assets/widgets/align_constant.png)
///
/// ```dart
/// Center(
///   child: Container(
///     height: 120.0,
///     width: 120.0,
///     color: Colors.blue[50],
///     child: const Align(
///       alignment: Alignment.topRight,
///       child: FlutterLogo(
///         size: 60,
///       ),
///     ),
///   ),
/// )
/// ```
/// {@end-tool}
///
/// ## How it works
///
/// The [alignment] property describes a point in the `child`'s coordinate system
/// and a different point in the coordinate system of this widget. The [Align]
/// widget positions the `child` such that both points are lined up on top of
/// each other.
///
/// {@tool snippet}
///
/// The [Alignment] used in the following example defines two points:
///
///   * (0.2 * width of [FlutterLogo]/2 + width of [FlutterLogo]/2, 0.6 * height
///     of [FlutterLogo]/2 + height of [FlutterLogo]/2) = (36.0, 48.0) in the
///     coordinate system of the [FlutterLogo].
///   * (0.2 * width of [Align]/2 + width of [Align]/2, 0.6 * height
///     of [Align]/2 + height of [Align]/2) = (72.0, 96.0) in the
///     coordinate system of the [Align] widget (blue area).
///
/// The [Align] widget positions the [FlutterLogo] such that the two points are on
/// top of each other. In this example, the top left of the [FlutterLogo] will
/// be placed at (72.0, 96.0) - (36.0, 48.0) = (36.0, 48.0) from the top left of
/// the [Align] widget.
///
/// ![A blue square container with the Flutter logo positioned according to the
/// Alignment specified above. A point is marked at the center of the container
/// for the origin of the Alignment coordinate system.](https://flutter.github.io/assets-for-api-docs/assets/widgets/align_alignment.png)
///
/// ```dart
/// Center(
///   child: Container(
///     height: 120.0,
///     width: 120.0,
///     color: Colors.blue[50],
///     child: const Align(
///       alignment: Alignment(0.2, 0.6),
///       child: FlutterLogo(
///         size: 60,
///       ),
///     ),
///   ),
/// )
/// ```
/// {@end-tool}
///
/// {@tool snippet}
///
/// The [FractionalOffset] used in the following example defines two points:
///
///   * (0.2 * width of [FlutterLogo], 0.6 * height of [FlutterLogo]) = (12.0, 36.0)
///     in the coordinate system of the [FlutterLogo].
///   * (0.2 * width of [Align], 0.6 * height of [Align]) = (24.0, 72.0) in the
///     coordinate system of the [Align] widget (blue area).
///
/// The [Align] widget positions the [FlutterLogo] such that the two points are on
/// top of each other. In this example, the top left of the [FlutterLogo] will
/// be placed at (24.0, 72.0) - (12.0, 36.0) = (12.0, 36.0) from the top left of
/// the [Align] widget.
///
/// The [FractionalOffset] class uses a coordinate system with an origin in the top-left
/// corner of the [Container] in difference to the center-oriented system used in
/// the example above with [Alignment].
///
/// ![A blue square container with the Flutter logo positioned according to the
/// FractionalOffset specified above. A point is marked at the top left corner
/// of the container for the origin of the FractionalOffset coordinate system.](https://flutter.github.io/assets-for-api-docs/assets/widgets/align_fractional_offset.png)
///
/// ```dart
/// Center(
///   child: Container(
///     height: 120.0,
///     width: 120.0,
///     color: Colors.blue[50],
///     child: const Align(
///       alignment: FractionalOffset(0.2, 0.6),
///       child: FlutterLogo(
///         size: 60,
///       ),
///     ),
///   ),
/// )
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [AnimatedAlign], which animates changes in [alignment] smoothly over a
///    given duration.
///  * [CustomSingleChildLayout], which uses a delegate to control the layout of
///    a single child.
///  * [Center], which is the same as [Align] but with the [alignment] always
///    set to [Alignment.center].
///  * [FractionallySizedBox], which sizes its child based on a fraction of its
///    own size and positions the child according to an [Alignment] value.
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
class Align extends StatelessWidget {
  /// Creates an alignment widget.
  ///
  /// The alignment defaults to [Alignment.center].
  const Align({
    super.key,
    this.alignment = Alignment.center,
    this.widthFactor,
    this.heightFactor,
    this.child,
  }) : assert(widthFactor == null || widthFactor >= 0.0),
       assert(heightFactor == null || heightFactor >= 0.0);

  /// How to align the child.
  ///
  /// The x and y values of the [Alignment] control the horizontal and vertical
  /// alignment, respectively. An x value of -1.0 means that the left edge of
  /// the child is aligned with the left edge of the parent whereas an x value
  /// of 1.0 means that the right edge of the child is aligned with the right
  /// edge of the parent. Other values interpolate (and extrapolate) linearly.
  /// For example, a value of 0.0 means that the center of the child is aligned
  /// with the center of the parent.
  ///
  /// See also:
  ///
  ///  * [Alignment], which has more details and some convenience constants for
  ///    common positions.
  ///  * [AlignmentDirectional], which has a horizontal coordinate orientation
  ///    that depends on the [TextDirection].
  final AlignmentGeometry alignment;

  /// If non-null, sets its width to the child's width multiplied by this factor.
  ///
  /// Can be both greater and less than 1.0 but must be non-negative.
  final double? widthFactor;

  /// If non-null, sets its height to the child's height multiplied by this factor.
  ///
  /// Can be both greater and less than 1.0 but must be non-negative.
  final double? heightFactor;

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final ps = PixelSnap.of(context);
    Widget res = widgets.Align(
      alignment: alignment.pixelSnap(ps),
      widthFactor: widthFactor,
      heightFactor: heightFactor,
      child: child,
    );
    return res;
  }
}

/// A widget that positions its child according to the child's baseline.
///
/// This widget shifts the child down such that the child's baseline (or the
/// bottom of the child, if the child has no baseline) is [baseline]
/// logical pixels below the top of this box, then sizes this box to
/// contain the child. If [baseline] is less than the distance from
/// the top of the child to the baseline of the child, then the child
/// is top-aligned instead.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=8ZaFk0yvNlI}
///
/// See also:
///
///  * [Align], a widget that aligns its child within itself and optionally
///    sizes itself based on the child's size.
///  * [Center], a widget that centers its child within itself.
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
class Baseline extends StatelessWidget {
  /// Creates a widget that positions its child according to the child's baseline.
  const Baseline({
    super.key,
    required this.baseline,
    required this.baselineType,
    this.child,
  });

  /// The number of logical pixels from the top of this box at which to position
  /// the child's baseline.
  final double baseline;

  /// The type of baseline to use for positioning the child.
  final TextBaseline baselineType;

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final ps = PixelSnap.of(context);
    Widget res = widgets.Baseline(
      baseline: baseline.pixelSnap(ps),
      baselineType: baselineType,
      child: child,
    );
    return res;
  }
}

/// A widget that imposes additional constraints on its child.
///
/// For example, if you wanted [child] to have a minimum height of 50.0 logical
/// pixels, you could use `const BoxConstraints(minHeight: 50.0)` as the
/// [constraints].
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=o2KveVr7adg}
///
/// {@tool snippet}
///
/// This snippet makes the child widget (a [Card] with some [Text]) fill the
/// parent, by applying [BoxConstraints.expand] constraints:
///
/// ```dart
/// ConstrainedBox(
///   constraints: const BoxConstraints.expand(),
///   child: const Card(child: Text('Hello World!')),
/// )
/// ```
/// {@end-tool}
///
/// The same behavior can be obtained using the [SizedBox.expand] widget.
///
/// See also:
///
///  * [BoxConstraints], the class that describes constraints.
///  * [UnconstrainedBox], a container that tries to let its child draw without
///    constraints.
///  * [SizedBox], which lets you specify tight constraints by explicitly
///    specifying the height or width.
///  * [FractionallySizedBox], which sizes its child based on a fraction of its
///    own size and positions the child according to an [Alignment] value.
///  * [AspectRatio], a widget that attempts to fit within the parent's
///    constraints while also sizing its child to match a given aspect ratio.
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
class ConstrainedBox extends StatelessWidget {
  /// Creates a widget that imposes additional constraints on its child.
  ConstrainedBox({super.key, required this.constraints, this.child})
    : assert(constraints.debugAssertIsValid());

  /// The additional constraints to impose on the child.
  final BoxConstraints constraints;

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final ps = PixelSnap.of(context);
    Widget res = widgets.ConstrainedBox(
      constraints: constraints.pixelSnap(ps),
      child: child,
    );
    return res;
  }
}

/// A widget that paints a [Decoration] either before or after its child paints.
///
/// [Container] insets its child by the widths of the borders; this widget does
/// not.
///
/// Commonly used with [BoxDecoration].
///
/// The [child] is not clipped. To clip a child to the shape of a particular
/// [ShapeDecoration], consider using a [ClipPath] widget.
///
/// {@tool snippet}
///
/// This sample shows a radial gradient that draws a moon on a night sky:
///
/// ```dart
/// const DecoratedBox(
///   decoration: BoxDecoration(
///     gradient: RadialGradient(
///       center: Alignment(-0.5, -0.6),
///       radius: 0.15,
///       colors: <Color>[
///         Color(0xFFEEEEEE),
///         Color(0xFF111133),
///       ],
///       stops: <double>[0.9, 1.0],
///     ),
///   ),
/// )
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [Ink], which paints a [Decoration] on a [Material], allowing
///    [InkResponse] and [InkWell] splashes to paint over them.
///  * [DecoratedBoxTransition], the version of this class that animates on the
///    [decoration] property.
///  * [Decoration], which you can extend to provide other effects with
///    [DecoratedBox].
///  * [CustomPaint], another way to draw custom effects from the widget layer.
///  * [DecoratedSliver], which applies a [Decoration] to a sliver.
class DecoratedBox extends StatelessWidget {
  /// Creates a widget that paints a [Decoration].
  ///
  /// By default the decoration paints behind the child.
  const DecoratedBox({
    super.key,
    required this.decoration,
    this.position = DecorationPosition.background,
    this.child,
  });

  /// What decoration to paint.
  ///
  /// Commonly a [BoxDecoration].
  final Decoration decoration;

  /// Whether to paint the box decoration behind or in front of the child.
  final DecorationPosition position;

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final ps = PixelSnap.of(context);
    Widget res = widgets.DecoratedBox(
      decoration: decoration.pixelSnap(ps),
      position: position,
      child: child,
    );
    return res;
  }
}

/// A convenience widget that combines common painting, positioning, and sizing
/// widgets.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=c1xLMaTUWCY}
///
/// A container first surrounds the child with [padding] (inflated by any
/// borders present in the [decoration]) and then applies additional
/// [constraints] to the padded extent (incorporating the `width` and `height`
/// as constraints, if either is non-null). The container is then surrounded by
/// additional empty space described from the [margin].
///
/// During painting, the container first applies the given [transform], then
/// paints the [decoration] to fill the padded extent, then it paints the child,
/// and finally paints the [foregroundDecoration], also filling the padded
/// extent.
///
/// Containers with no children try to be as big as possible unless the incoming
/// constraints are unbounded, in which case they try to be as small as
/// possible. Containers with children size themselves to their children. The
/// `width`, `height`, and [constraints] arguments to the constructor override
/// this.
///
/// By default, containers return false for all hit tests. If the [color]
/// property is specified, the hit testing is handled by [ColoredBox], which
/// always returns true. If the [decoration] or [foregroundDecoration] properties
/// are specified, hit testing is handled by [Decoration.hitTest].
///
/// ## Layout behavior
///
/// _See [BoxConstraints] for an introduction to box layout models._
///
/// Since [Container] combines a number of other widgets each with their own
/// layout behavior, [Container]'s layout behavior is somewhat complicated.
///
/// Summary: [Container] tries, in order: to honor [alignment], to size itself
/// to the [child], to honor the `width`, `height`, and [constraints], to expand
/// to fit the parent, to be as small as possible.
///
/// More specifically:
///
/// If the widget has no child, no `height`, no `width`, no [constraints],
/// and the parent provides unbounded constraints, then [Container] tries to
/// size as small as possible.
///
/// If the widget has no child and no [alignment], but a `height`, `width`, or
/// [constraints] are provided, then the [Container] tries to be as small as
/// possible given the combination of those constraints and the parent's
/// constraints.
///
/// If the widget has no child, no `height`, no `width`, no [constraints], and
/// no [alignment], but the parent provides bounded constraints, then
/// [Container] expands to fit the constraints provided by the parent.
///
/// If the widget has an [alignment], and the parent provides unbounded
/// constraints, then the [Container] tries to size itself around the child.
///
/// If the widget has an [alignment], and the parent provides bounded
/// constraints, then the [Container] tries to expand to fit the parent, and
/// then positions the child within itself as per the [alignment].
///
/// Otherwise, the widget has a [child] but no `height`, no `width`, no
/// [constraints], and no [alignment], and the [Container] passes the
/// constraints from the parent to the child and sizes itself to match the
/// child.
///
/// The [margin] and [padding] properties also affect the layout, as described
/// in the documentation for those properties. (Their effects merely augment the
/// rules described above.) The [decoration] can implicitly increase the
/// [padding] (e.g. borders in a [BoxDecoration] contribute to the [padding]);
/// see [Decoration.padding].
///
/// ## Example
///
/// {@tool snippet}
/// This example shows a 48x48 amber square (placed inside a [Center] widget in
/// case the parent widget has its own opinions regarding the size that the
/// [Container] should take), with a margin so that it stays away from
/// neighboring widgets:
///
/// ![An amber colored container with the dimensions of 48 square pixels.](https://flutter.github.io/assets-for-api-docs/assets/widgets/container_a.png)
///
/// ```dart
/// Center(
///   child: Container(
///     margin: const EdgeInsets.all(10.0),
///     color: Colors.amber[600],
///     width: 48.0,
///     height: 48.0,
///   ),
/// )
/// ```
/// {@end-tool}
///
/// {@tool snippet}
///
/// This example shows how to use many of the features of [Container] at once.
/// The [constraints] are set to fit the font size plus ample headroom
/// vertically, while expanding horizontally to fit the parent. The [padding] is
/// used to make sure there is space between the contents and the text. The
/// [color] makes the box blue. The [alignment] causes the [child] to be
/// centered in the box. Finally, the [transform] applies a slight rotation to the
/// entire contraption to complete the effect.
///
/// ![A blue rectangular container with 'Hello World' in the center, rotated
/// slightly in the z axis.](https://flutter.github.io/assets-for-api-docs/assets/widgets/container_b.png)
///
/// ```dart
/// Container(
///   constraints: BoxConstraints.expand(
///     height: Theme.of(context).textTheme.headlineMedium!.fontSize! * 1.1 + 200.0,
///   ),
///   padding: const EdgeInsets.all(8.0),
///   color: Colors.blue[600],
///   alignment: Alignment.center,
///   transform: Matrix4.rotationZ(0.1),
///   child: Text('Hello World',
///     style: Theme.of(context)
///         .textTheme
///         .headlineMedium!
///         .copyWith(color: Colors.white)),
/// )
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [AnimatedContainer], a variant that smoothly animates the properties when
///    they change.
///  * [Border], which has a sample which uses [Container] heavily.
///  * [Ink], which paints a [Decoration] on a [Material], allowing
///    [InkResponse] and [InkWell] splashes to paint over them.
///  * Cookbook: [Animate the properties of a container](https://docs.flutter.dev/cookbook/animation/animated-container)
///  * The [catalog of layout widgets](https://docs.flutter.dev/ui/widgets/layout).
class Container extends StatelessWidget {
  /// Creates a widget that combines common painting, positioning, and sizing widgets.
  ///
  /// The `height` and `width` values include the padding.
  ///
  /// The `color` and `decoration` arguments cannot both be supplied, since
  /// it would potentially result in the decoration drawing over the background
  /// color. To supply a decoration with a color, use `decoration:
  /// BoxDecoration(color: color)`.
  Container({
    super.key,
    this.alignment,
    this.padding,
    this.color,
    this.isAntiAlias = true,
    this.decoration,
    this.foregroundDecoration,
    double? width,
    double? height,
    BoxConstraints? constraints,
    this.margin,
    this.transform,
    this.transformAlignment,
    this.child,
    this.clipBehavior = Clip.none,
  }) : assert(margin == null || margin.isNonNegative),
       assert(padding == null || padding.isNonNegative),
       assert(decoration == null || decoration.debugAssertIsValid()),
       assert(constraints == null || constraints.debugAssertIsValid()),
       assert(decoration != null || clipBehavior == Clip.none),
       assert(
         color == null || decoration == null,
         'Cannot provide both a color and a decoration.\n'
         'The color argument is just a shorthand for "decoration: BoxDecoration(color: color)".\n'
         'To use both a color and other decoration properties, set the color in the BoxDecoration instead.',
       ),
       constraints = (width != null || height != null)
           ? constraints?.tighten(width: width, height: height) ??
                 BoxConstraints.tightFor(width: width, height: height)
           : constraints;

  /// The [child] contained by the container.
  ///
  /// If null, and if the [constraints] are unbounded or also null, the
  /// container will expand to fill all available space in its parent, unless
  /// the parent provides unbounded constraints, in which case the container
  /// will attempt to be as small as possible.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget? child;

  /// Align the [child] within the container.
  ///
  /// If non-null, the container will expand to fill its parent and position its
  /// child within itself according to the given value. If the incoming
  /// constraints are unbounded, then the child will be shrink-wrapped instead.
  ///
  /// Ignored if [child] is null.
  ///
  /// See also:
  ///
  ///  * [Alignment], a class with convenient constants typically used to
  ///    specify an [AlignmentGeometry].
  ///  * [AlignmentDirectional], like [Alignment] for specifying alignments
  ///    relative to text direction.
  final AlignmentGeometry? alignment;

  /// Empty space to inscribe inside the [decoration]. The [child], if any, is
  /// placed inside this padding.
  ///
  /// This padding is in addition to any padding inherent in the [decoration];
  /// see [Decoration.padding].
  final EdgeInsetsGeometry? padding;

  /// The color to paint behind the [child].
  ///
  /// This property should be preferred when the background is a simple color.
  /// For other cases, such as gradients or images, use the [decoration]
  /// property.
  ///
  /// If the [decoration] is used, this property must be null. A background
  /// color may still be painted by the [decoration] even if this property is
  /// null.
  final Color? color;

  /// {@macro flutter.widgets.ColoredBox.isAntiAlias}
  final bool isAntiAlias;

  /// The decoration to paint behind the [child].
  ///
  /// Use the [color] property to specify a simple solid color.
  ///
  /// The [child] is not clipped to the decoration. To clip a child to the shape
  /// of a particular [ShapeDecoration], consider using a [ClipPath] widget.
  final Decoration? decoration;

  /// The decoration to paint in front of the [child].
  final Decoration? foregroundDecoration;

  /// Additional constraints to apply to the child.
  ///
  /// The constructor `width` and `height` arguments are combined with the
  /// `constraints` argument to set this property.
  ///
  /// The [padding] goes inside the constraints.
  final BoxConstraints? constraints;

  /// Empty space to surround the [decoration] and [child].
  final EdgeInsetsGeometry? margin;

  /// The transformation matrix to apply before painting the container.
  final Matrix4? transform;

  /// The alignment of the origin, relative to the size of the container, if [transform] is specified.
  ///
  /// When [transform] is null, the value of this property is ignored.
  ///
  /// See also:
  ///
  ///  * [Transform.alignment], which is set by this property.
  final AlignmentGeometry? transformAlignment;

  /// The clip behavior when [Container.decoration] is not null.
  ///
  /// Defaults to [Clip.none]. Must be [Clip.none] if [decoration] is null.
  ///
  /// If a clip is to be applied, the [Decoration.getClipPath] method
  /// for the provided decoration must return a clip path. (This is not
  /// supported by all decorations; the default implementation of that
  /// method throws an [UnsupportedError].)
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    final ps = PixelSnap.of(context);
    Widget res = widgets.Container(
      alignment: alignment?.pixelSnap(ps),
      padding: padding?.pixelSnap(ps),
      color: color,
      isAntiAlias: isAntiAlias,
      decoration: decoration?.pixelSnap(ps),
      foregroundDecoration: foregroundDecoration?.pixelSnap(ps),
      constraints: constraints?.pixelSnap(ps),
      margin: margin?.pixelSnap(ps),
      transform: transform,
      transformAlignment: transformAlignment?.pixelSnap(ps),
      clipBehavior: clipBehavior,
      child: child,
    );
    return res;
  }
}

/// A widget that sizes its child to the child's maximum intrinsic width.
///
/// This class is useful, for example, when unlimited width is available and
/// you would like a child that would otherwise attempt to expand infinitely to
/// instead size itself to a more reasonable width. Additionally, putting a
/// [Column] inside an [IntrinsicWidth] will allow all [Column] children to be
/// as wide as the widest child.
///
/// The constraints that this widget passes to its child will adhere to the
/// parent's constraints, so if the constraints are not large enough to satisfy
/// the child's maximum intrinsic width, then the child will get less width
/// than it otherwise would. Likewise, if the minimum width constraint is
/// larger than the child's maximum intrinsic width, the child will be given
/// more width than it otherwise would.
///
/// If [stepWidth] is non-null, the child's width will be snapped to a multiple
/// of the [stepWidth]. Similarly, if [stepHeight] is non-null, the child's
/// height will be snapped to a multiple of the [stepHeight].
///
/// This class is relatively expensive, because it adds a speculative layout
/// pass before the final layout phase. Avoid using it where possible. In the
/// worst case, this widget can result in a layout that is O(N²) in the depth of
/// the tree.
///
/// See also:
///
///  * [Align], a widget that aligns its child within itself. This can be used
///    to loosen the constraints passed to the [RenderIntrinsicWidth],
///    allowing the [RenderIntrinsicWidth]'s child to be smaller than that of
///    its parent.
///  * [Row], which when used with [CrossAxisAlignment.stretch] can be used
///    to loosen just the width constraints that are passed to the
///    [RenderIntrinsicWidth], allowing the [RenderIntrinsicWidth]'s child's
///    width to be smaller than that of its parent.
///  * [The catalog of layout widgets](https://flutter.dev/widgets/layout/).
class IntrinsicWidth extends StatelessWidget {
  /// Creates a widget that sizes its child to the child's intrinsic width.
  ///
  /// This class is relatively expensive. Avoid using it where possible.
  const IntrinsicWidth({super.key, this.stepWidth, this.stepHeight, this.child})
    : assert(stepWidth == null || stepWidth >= 0.0),
      assert(stepHeight == null || stepHeight >= 0.0);

  /// If non-null, force the child's width to be a multiple of this value.
  ///
  /// If null or 0.0 the child's width will be the same as its maximum
  /// intrinsic width.
  ///
  /// This value must not be negative.
  ///
  /// See also:
  ///
  ///  * [RenderBox.getMaxIntrinsicWidth], which defines a widget's max
  ///    intrinsic width in general.
  final double? stepWidth;

  /// If non-null, force the child's height to be a multiple of this value.
  ///
  /// If null or 0.0 the child's height will not be constrained.
  ///
  /// This value must not be negative.
  final double? stepHeight;

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final ps = PixelSnap.of(context);
    Widget res = widgets.IntrinsicWidth(
      stepWidth: stepWidth?.pixelSnap(ps),
      stepHeight: stepHeight?.pixelSnap(ps),
      child: child,
    );
    return res;
  }
}

/// A box that limits its size only when it's unconstrained.
///
/// If this widget's maximum width is unconstrained then its child's width is
/// limited to [maxWidth]. Similarly, if this widget's maximum height is
/// unconstrained then its child's height is limited to [maxHeight].
///
/// This has the effect of giving the child a natural dimension in unbounded
/// environments. For example, by providing a [maxHeight] to a widget that
/// normally tries to be as big as possible, the widget will normally size
/// itself to fit its parent, but when placed in a vertical list, it will take
/// on the given height.
///
/// This is useful when composing widgets that normally try to match their
/// parents' size, so that they behave reasonably in lists (which are
/// unbounded).
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=uVki2CIzBTs}
///
/// See also:
///
///  * [ConstrainedBox], which applies its constraints in all cases, not just
///    when the incoming constraints are unbounded.
///  * [SizedBox], which lets you specify tight constraints by explicitly
///    specifying the height or width.
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
class LimitedBox extends StatelessWidget {
  /// Creates a box that limits its size only when it's unconstrained.
  ///
  /// The [maxWidth] and [maxHeight] arguments must not be negative.
  const LimitedBox({
    super.key,
    this.maxWidth = double.infinity,
    this.maxHeight = double.infinity,
    this.child,
  }) : assert(maxWidth >= 0.0),
       assert(maxHeight >= 0.0);

  /// The maximum width limit to apply in the absence of a
  /// [BoxConstraints.maxWidth] constraint.
  final double maxWidth;

  /// The maximum height limit to apply in the absence of a
  /// [BoxConstraints.maxHeight] constraint.
  final double maxHeight;

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final ps = PixelSnap.of(context);
    Widget res = widgets.LimitedBox(
      maxWidth: maxWidth.pixelSnap(ps),
      maxHeight: maxHeight.pixelSnap(ps),
      child: child,
    );
    return res;
  }
}

/// A widget that imposes different constraints on its child than it gets
/// from its parent, possibly allowing the child to overflow the parent.
///
/// {@tool dartpad}
/// This example shows how an [OverflowBox] is used, and what its effect is.
///
/// ** See code in examples/api/lib/widgets/basic/overflowbox.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [RenderConstrainedOverflowBox] for details about how [OverflowBox] is
///    rendered.
///  * [SizedOverflowBox], a widget that is a specific size but passes its
///    original constraints through to its child, which may then overflow.
///  * [ConstrainedBox], a widget that imposes additional constraints on its
///    child.
///  * [UnconstrainedBox], a container that tries to let its child draw without
///    constraints.
///  * [SizedBox], a box with a specified size.
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
class OverflowBox extends StatelessWidget {
  /// Creates a widget that lets its child overflow itself.
  const OverflowBox({
    super.key,
    this.alignment = Alignment.center,
    this.minWidth,
    this.maxWidth,
    this.minHeight,
    this.maxHeight,
    this.fit = OverflowBoxFit.max,
    this.child,
  });

  /// How to align the child.
  ///
  /// The x and y values of the alignment control the horizontal and vertical
  /// alignment, respectively. An x value of -1.0 means that the left edge of
  /// the child is aligned with the left edge of the parent whereas an x value
  /// of 1.0 means that the right edge of the child is aligned with the right
  /// edge of the parent. Other values interpolate (and extrapolate) linearly.
  /// For example, a value of 0.0 means that the center of the child is aligned
  /// with the center of the parent.
  ///
  /// Defaults to [Alignment.center].
  ///
  /// See also:
  ///
  ///  * [Alignment], a class with convenient constants typically used to
  ///    specify an [AlignmentGeometry].
  ///  * [AlignmentDirectional], like [Alignment] for specifying alignments
  ///    relative to text direction.
  final AlignmentGeometry alignment;

  /// The minimum width constraint to give the child. Set this to null (the
  /// default) to use the constraint from the parent instead.
  final double? minWidth;

  /// The maximum width constraint to give the child. Set this to null (the
  /// default) to use the constraint from the parent instead.
  final double? maxWidth;

  /// The minimum height constraint to give the child. Set this to null (the
  /// default) to use the constraint from the parent instead.
  final double? minHeight;

  /// The maximum height constraint to give the child. Set this to null (the
  /// default) to use the constraint from the parent instead.
  final double? maxHeight;

  /// The way to size the render object.
  ///
  /// This only affects scenario when the child does not indeed overflow.
  /// If set to [OverflowBoxFit.deferToChild], the render object will size itself to
  /// match the size of its child within the constraints of its parent or be
  /// as small as the parent allows if no child is set. If set to
  /// [OverflowBoxFit.max] (the default), the render object will size itself
  /// to be as large as the parent allows.
  final OverflowBoxFit fit;

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final ps = PixelSnap.of(context);
    Widget res = widgets.OverflowBox(
      alignment: alignment.pixelSnap(ps),
      minWidth: minWidth?.pixelSnap(ps),
      maxWidth: maxWidth?.pixelSnap(ps),
      minHeight: minHeight?.pixelSnap(ps),
      maxHeight: maxHeight?.pixelSnap(ps),
      fit: fit,
      child: child,
    );
    return res;
  }
}

/// A widget that insets its child by the given padding.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=oD5RtLhhubg}
///
/// When passing layout constraints to its child, padding shrinks the
/// constraints by the given padding, causing the child to layout at a smaller
/// size. Padding then sizes itself to its child's size, inflated by the
/// padding, effectively creating empty space around the child.
///
/// {@tool snippet}
///
/// This snippet creates "Hello World!" [Text] inside a [Card] that is indented
/// by sixteen pixels in each direction.
///
/// ![](https://flutter.github.io/assets-for-api-docs/assets/widgets/padding.png)
///
/// ```dart
/// const Card(
///   child: Padding(
///     padding: EdgeInsets.all(16.0),
///     child: Text('Hello World!'),
///   ),
/// )
/// ```
/// {@end-tool}
///
/// ## Design discussion
///
/// ### Why use a [Padding] widget rather than a [Container] with a [Container.padding] property?
///
/// There isn't really any difference between the two. If you supply a
/// [Container.padding] argument, [Container] builds a [Padding] widget
/// for you.
///
/// [Container] doesn't implement its properties directly. Instead, [Container]
/// combines a number of simpler widgets together into a convenient package. For
/// example, the [Container.padding] property causes the container to build a
/// [Padding] widget and the [Container.decoration] property causes the
/// container to build a [DecoratedBox] widget. If you find [Container]
/// convenient, feel free to use it. If not, feel free to build these simpler
/// widgets in whatever combination meets your needs.
///
/// In fact, the majority of widgets in Flutter are combinations of other
/// simpler widgets. Composition, rather than inheritance, is the primary
/// mechanism for building up widgets.
///
/// See also:
///
///  * [EdgeInsets], the class that is used to describe the padding dimensions.
///  * [AnimatedPadding], which animates changes in [padding] over a given
///    duration.
///  * [SliverPadding], the sliver equivalent of this widget.
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
class Padding extends StatelessWidget {
  /// Creates a widget that insets its child.
  const Padding({super.key, required this.padding, this.child});

  /// The amount of space by which to inset the child.
  final EdgeInsetsGeometry padding;

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final ps = PixelSnap.of(context);
    Widget res = widgets.Padding(padding: padding.pixelSnap(ps), child: child);
    return res;
  }
}

/// A box with a specified size.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=EHPu_DzRfqA}
///
/// If given a child, this widget will try to size its child as close to the
/// specified [height] and [width] as possible given the parent's constraints.
/// If either the width or height is null, this widget will try to size itself to
/// match the child's size in that dimension. If the child's size depends on the
/// size of its parent, the height and width must be provided.
///
/// If not given a child, [SizedBox] will try to size itself as close to the
/// specified height and width as possible given the parent's constraints. If
/// [height] or [width] is null or unspecified, it will be treated as zero.
///
/// The [SizedBox.expand] constructor can be used to make a [SizedBox] that
/// sizes itself to fit the parent. It is equivalent to setting [width] and
/// [height] to [double.infinity].
///
/// {@tool snippet}
///
/// This snippet makes the child widget (a [Card] with some [Text]) have the
/// exact size 200x300, parental constraints permitting:
///
/// ```dart
/// const SizedBox(
///   width: 200.0,
///   height: 300.0,
///   child: Card(child: Text('Hello World!')),
/// )
/// ```
/// {@end-tool}
///
/// ## Troubleshooting
///
/// ### Why is my [SizedBox] ignored?
///
/// In Flutter's layout protocol constraints go down, and sizes go up.
/// A widget must respect the constraints passed by its parent. This can cause a
/// [SizedBox]'s values to be ignored:
///
/// {@tool snippet}
///
/// This snippet makes the [ColoredBox] size 200x200. The 100x100 size is
/// ignored because it is incompatible with its parent constraints of exactly
/// 200x200:
///
/// ```dart
/// const SizedBox(
///   width: 200.0,
///   height: 200.0,
///   child: SizedBox( // Ignored!
///     width: 100.0,
///     height: 100.0,
///     child: ColoredBox(color: Colors.green),
///   ),
/// )
/// ```
/// {@end-tool}
///
/// This can be fixed by wrapping the child [SizedBox] in a widget that lets
/// it be any size up to the size of the parent, such as [Center] or [Align].
///
/// See also:
///
///  * [ConstrainedBox], a more generic version of this class that takes
///    arbitrary [BoxConstraints] instead of an explicit width and height.
///  * [UnconstrainedBox], a container that tries to let its child draw without
///    constraints.
///  * [FractionallySizedBox], a widget that sizes its child to a fraction of
///    the total available space.
///  * [AspectRatio], a widget that attempts to fit within the parent's
///    constraints while also sizing its child to match a given aspect ratio.
///  * [FittedBox], which sizes and positions its child widget to fit the parent
///    according to a given [BoxFit] discipline.
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
///  * [Understanding constraints](https://docs.flutter.dev/ui/layout/constraints),
///    an in-depth article about layout in Flutter.
class SizedBox extends StatelessWidget {
  /// Creates a fixed size box. The [width] and [height] parameters can be null
  /// to indicate that the size of the box should not be constrained in
  /// the corresponding dimension.
  const SizedBox({super.key, this.width, this.height, this.child});

  /// Creates a box that will become as large as its parent allows.
  const SizedBox.expand({super.key, this.child})
    : width = double.infinity,
      height = double.infinity;

  /// Creates a box that will become as small as its parent allows.
  const SizedBox.shrink({super.key, this.child}) : width = 0.0, height = 0.0;

  /// Creates a box with the specified size.
  SizedBox.fromSize({super.key, this.child, Size? size})
    : width = size?.width,
      height = size?.height;

  /// Creates a box whose [width] and [height] are equal.
  const SizedBox.square({super.key, this.child, double? dimension})
    : width = dimension,
      height = dimension;

  /// If non-null, requires the child to have exactly this width.
  final double? width;

  /// If non-null, requires the child to have exactly this height.
  final double? height;

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final ps = PixelSnap.of(context);
    Widget res = widgets.SizedBox(
      width: width?.pixelSnap(ps),
      height: height?.pixelSnap(ps),
      child: child,
    );
    return res;
  }
}

/// A widget that is a specific size but passes its original constraints
/// through to its child, which may then overflow.
///
/// See also:
///
///  * [OverflowBox], A widget that imposes different constraints on its child
///    than it gets from its parent, possibly allowing the child to overflow the
///    parent.
///  * [ConstrainedBox], a widget that imposes additional constraints on its
///    child.
///  * [UnconstrainedBox], a container that tries to let its child draw without
///    constraints.
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
class SizedOverflowBox extends StatelessWidget {
  /// Creates a widget of a given size that lets its child overflow.
  const SizedOverflowBox({
    super.key,
    required this.size,
    this.alignment = Alignment.center,
    this.child,
  });

  /// How to align the child.
  ///
  /// The x and y values of the alignment control the horizontal and vertical
  /// alignment, respectively. An x value of -1.0 means that the left edge of
  /// the child is aligned with the left edge of the parent whereas an x value
  /// of 1.0 means that the right edge of the child is aligned with the right
  /// edge of the parent. Other values interpolate (and extrapolate) linearly.
  /// For example, a value of 0.0 means that the center of the child is aligned
  /// with the center of the parent.
  ///
  /// Defaults to [Alignment.center].
  ///
  /// See also:
  ///
  ///  * [Alignment], a class with convenient constants typically used to
  ///    specify an [AlignmentGeometry].
  ///  * [AlignmentDirectional], like [Alignment] for specifying alignments
  ///    relative to text direction.
  final AlignmentGeometry alignment;

  /// The size this widget should attempt to be.
  final Size size;

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final ps = PixelSnap.of(context);
    Widget res = widgets.SizedOverflowBox(
      alignment: alignment.pixelSnap(ps),
      size: size.pixelSnap(ps),
      child: child,
    );
    return res;
  }
}

/// A widget that controls where a child of a [Stack] is positioned.
///
/// A [Positioned] widget must be a descendant of a [Stack], and the path from
/// the [Positioned] widget to its enclosing [Stack] must contain only
/// [StatelessWidget]s or [StatefulWidget]s (not other kinds of widgets, like
/// [RenderObjectWidget]s).
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=EgtPleVwxBQ}
///
/// If a widget is wrapped in a [Positioned], then it is a _positioned_ widget
/// in its [Stack]. If the [top] property is non-null, the top edge of this child
/// will be positioned [top] layout units from the top of the stack widget. The
/// [right], [bottom], and [left] properties work analogously.
///
/// If both the [top] and [bottom] properties are non-null, then the child will
/// be forced to have exactly the height required to satisfy both constraints.
/// Similarly, setting the [right] and [left] properties to non-null values will
/// force the child to have a particular width. Alternatively the [width] and
/// [height] properties can be used to give the dimensions, with one
/// corresponding position property (e.g. [top] and [height]).
///
/// If all three values on a particular axis are null, then the
/// [Stack.alignment] property is used to position the child.
///
/// If all six values are null, the child is a non-positioned child. The [Stack]
/// uses only the non-positioned children to size itself.
///
/// See also:
///
///  * [AnimatedPositioned], which automatically transitions the child's
///    position over a given duration whenever the given position changes.
///  * [PositionedTransition], which takes a provided [Animation] to transition
///    changes in the child's position over a given duration.
///  * [PositionedDirectional], which adapts to the ambient [Directionality].
class Positioned extends StatelessWidget {
  /// Creates a widget that controls where a child of a [Stack] is positioned.
  ///
  /// Only two out of the three horizontal values ([left], [right],
  /// [width]), and only two out of the three vertical values ([top],
  /// [bottom], [height]), can be set. In each case, at least one of
  /// the three must be null.
  ///
  /// See also:
  ///
  ///  * [Positioned.directional], which specifies the widget's horizontal
  ///    position using `start` and `end` rather than `left` and `right`.
  ///  * [PositionedDirectional], which is similar to [Positioned.directional]
  ///    but adapts to the ambient [Directionality].
  const Positioned({
    super.key,
    this.left,
    this.top,
    this.right,
    this.bottom,
    this.width,
    this.height,
    required this.child,
  }) : assert(left == null || right == null || width == null),
       assert(top == null || bottom == null || height == null);

  /// Creates a Positioned object with the values from the given [Rect].
  ///
  /// This sets the [left], [top], [width], and [height] properties
  /// from the given [Rect]. The [right] and [bottom] properties are
  /// set to null.
  Positioned.fromRect({super.key, required Rect rect, required this.child})
    : left = rect.left,
      top = rect.top,
      width = rect.width,
      height = rect.height,
      right = null,
      bottom = null;

  /// Creates a Positioned object with the values from the given [RelativeRect].
  ///
  /// This sets the [left], [top], [right], and [bottom] properties from the
  /// given [RelativeRect]. The [height] and [width] properties are set to null.
  Positioned.fromRelativeRect({
    super.key,
    required RelativeRect rect,
    required this.child,
  }) : left = rect.left,
       top = rect.top,
       right = rect.right,
       bottom = rect.bottom,
       width = null,
       height = null;

  /// Creates a Positioned object with [left], [top], [right], and [bottom] set
  /// to 0.0 unless a value for them is passed.
  const Positioned.fill({
    super.key,
    this.left = 0.0,
    this.top = 0.0,
    this.right = 0.0,
    this.bottom = 0.0,
    required this.child,
  }) : width = null,
       height = null;

  /// Creates a widget that controls where a child of a [Stack] is positioned.
  ///
  /// Only two out of the three horizontal values (`start`, `end`,
  /// [width]), and only two out of the three vertical values ([top],
  /// [bottom], [height]), can be set. In each case, at least one of
  /// the three must be null.
  ///
  /// If `textDirection` is [TextDirection.rtl], then the `start` argument is
  /// used for the [right] property and the `end` argument is used for the
  /// [left] property. Otherwise, if `textDirection` is [TextDirection.ltr],
  /// then the `start` argument is used for the [left] property and the `end`
  /// argument is used for the [right] property.
  ///
  /// See also:
  ///
  ///  * [PositionedDirectional], which adapts to the ambient [Directionality].
  factory Positioned.directional({
    Key? key,
    required TextDirection textDirection,
    double? start,
    double? top,
    double? end,
    double? bottom,
    double? width,
    double? height,
    required Widget child,
  }) {
    final (double? left, double? right) = switch (textDirection) {
      TextDirection.rtl => (end, start),
      TextDirection.ltr => (start, end),
    };
    return Positioned(
      key: key,
      left: left,
      top: top,
      right: right,
      bottom: bottom,
      width: width,
      height: height,
      child: child,
    );
  }

  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget child;

  /// The distance that the child's left edge is inset from the left of the stack.
  ///
  /// Only two out of the three horizontal values ([left], [right], [width]) can be
  /// set. The third must be null.
  ///
  /// If all three are null, the [Stack.alignment] is used to position the child
  /// horizontally.
  final double? left;

  /// The distance that the child's top edge is inset from the top of the stack.
  ///
  /// Only two out of the three vertical values ([top], [bottom], [height]) can be
  /// set. The third must be null.
  ///
  /// If all three are null, the [Stack.alignment] is used to position the child
  /// vertically.
  final double? top;

  /// The distance that the child's right edge is inset from the right of the stack.
  ///
  /// Only two out of the three horizontal values ([left], [right], [width]) can be
  /// set. The third must be null.
  ///
  /// If all three are null, the [Stack.alignment] is used to position the child
  /// horizontally.
  final double? right;

  /// The distance that the child's bottom edge is inset from the bottom of the stack.
  ///
  /// Only two out of the three vertical values ([top], [bottom], [height]) can be
  /// set. The third must be null.
  ///
  /// If all three are null, the [Stack.alignment] is used to position the child
  /// vertically.
  final double? bottom;

  /// The child's width.
  ///
  /// Only two out of the three horizontal values ([left], [right], [width]) can be
  /// set. The third must be null.
  ///
  /// If all three are null, the [Stack.alignment] is used to position the child
  /// horizontally.
  final double? width;

  /// The child's height.
  ///
  /// Only two out of the three vertical values ([top], [bottom], [height]) can be
  /// set. The third must be null.
  ///
  /// If all three are null, the [Stack.alignment] is used to position the child
  /// vertically.
  final double? height;

  @override
  Widget build(BuildContext context) {
    final ps = PixelSnap.of(context);
    Widget res = widgets.Positioned(
      left: left?.pixelSnap(ps),
      top: top?.pixelSnap(ps),
      right: right?.pixelSnap(ps),
      bottom: bottom?.pixelSnap(ps),
      width: width?.pixelSnap(ps),
      height: height?.pixelSnap(ps),
      child: child,
    );
    return res;
  }
}

/// A widget representing a physical layer that clips its children to a shape.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=XgUOSS30OQk}
///
/// Physical layers cast shadows based on an [elevation] which is nominally in
/// logical pixels, coming vertically out of the rendering surface.
///
/// For shapes that cannot be expressed as a rectangle with rounded corners use
/// [PhysicalShape].
///
/// See also:
///
///  * [AnimatedPhysicalModel], which animates property changes smoothly over
///    a given duration.
///  * [DecoratedBox], which can apply more arbitrary shadow effects.
///  * [ClipRect], which applies a clip to its child.
class PhysicalModel extends StatelessWidget {
  /// Creates a physical model with a rounded-rectangular clip.
  ///
  /// The [color] is required; physical things have a color.
  ///
  /// The [shape], [elevation], [color], [clipBehavior], and [shadowColor] must
  /// not be null. Additionally, the [elevation] must be non-negative.
  const PhysicalModel({
    super.key,
    this.shape = BoxShape.rectangle,
    this.clipBehavior = Clip.none,
    this.borderRadius,
    this.elevation = 0.0,
    required this.color,
    this.shadowColor = const Color(0xFF000000),
    this.child,
  }) : assert(elevation >= 0.0);

  /// The type of shape.
  final BoxShape shape;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.none].
  final Clip clipBehavior;

  /// The border radius of the rounded corners.
  ///
  /// Values are clamped so that horizontal and vertical radii sums do not
  /// exceed width/height.
  ///
  /// This is ignored if the [shape] is not [BoxShape.rectangle].
  final BorderRadius? borderRadius;

  /// The z-coordinate relative to the parent at which to place this physical
  /// object.
  ///
  /// The value is non-negative.
  final double elevation;

  /// The background color.
  final Color color;

  /// The shadow color.
  final Color shadowColor;

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final ps = PixelSnap.of(context);
    Widget res = widgets.PhysicalModel(
      shape: shape,
      clipBehavior: clipBehavior,
      borderRadius: borderRadius?.pixelSnap(ps),
      elevation: elevation.pixelSnap(ps),
      color: color,
      shadowColor: shadowColor,
      child: child,
    );
    return res;
  }
}

/// A widget that provides a canvas on which to draw during the paint phase.
///
/// When asked to paint, [CustomPaint] first asks its [painter] to paint on the
/// current canvas, then it paints its child, and then, after painting its
/// child, it asks its [foregroundPainter] to paint. The coordinate system of the
/// canvas matches the coordinate system of the [CustomPaint] object. The
/// painters are expected to paint within a rectangle starting at the origin and
/// encompassing a region of the given size. (If the painters paint outside
/// those bounds, there might be insufficient memory allocated to rasterize the
/// painting commands and the resulting behavior is undefined.) To enforce
/// painting within those bounds, consider wrapping this [CustomPaint] with a
/// [ClipRect] widget.
///
/// Painters are implemented by subclassing [CustomPainter].
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=kp14Y4uHpHs}
///
/// Because custom paint calls its painters during paint, you cannot call
/// `setState` or `markNeedsLayout` during the callback (the layout for this
/// frame has already happened).
///
/// Custom painters normally size themselves to their [child]. If they do not
/// have a child, they attempt to size themselves to the specified [size], which
/// defaults to [Size.zero]. The parent [may enforce constraints on this
/// size](https://docs.flutter.dev/ui/layout/constraints).
///
/// The [isComplex] and [willChange] properties are hints to the compositor's
/// raster cache.
///
/// {@tool snippet}
///
/// This example shows how the sample custom painter shown at [CustomPainter]
/// could be used in a [CustomPaint] widget to display a background to some
/// text.
///
/// ```dart
/// CustomPaint(
///   painter: Sky(),
///   child: const Center(
///     child: Text(
///       'Once upon a time...',
///       style: TextStyle(
///         fontSize: 40.0,
///         fontWeight: FontWeight.w900,
///         color: Color(0xFFFFFFFF),
///       ),
///     ),
///   ),
/// )
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [CustomPainter], the class to extend when creating custom painters.
///  * [Canvas], the class that a custom painter uses to paint.
class CustomPaint extends StatelessWidget {
  /// Creates a widget that delegates its painting.
  const CustomPaint({
    super.key,
    this.painter,
    this.foregroundPainter,
    this.size = Size.zero,
    this.isComplex = false,
    this.willChange = false,
    this.child,
  }) : assert(
         painter != null ||
             foregroundPainter != null ||
             (!isComplex && !willChange),
       );

  /// The painter that paints before the children.
  final CustomPainter? painter;

  /// The painter that paints after the children.
  final CustomPainter? foregroundPainter;

  /// The size that this [CustomPaint] should aim for, given the layout
  /// constraints, if there is no child.
  ///
  /// Defaults to [Size.zero].
  ///
  /// If there's a child, this is ignored, and the size of the child is used
  /// instead.
  final Size size;

  /// Whether the painting is complex enough to benefit from caching.
  ///
  /// The compositor contains a raster cache that holds bitmaps of layers in
  /// order to avoid the cost of repeatedly rendering those layers on each
  /// frame. If this flag is not set, then the compositor will apply its own
  /// heuristics to decide whether the layer containing this widget is complex
  /// enough to benefit from caching.
  ///
  /// This flag can't be set to true if both [painter] and [foregroundPainter]
  /// are null because this flag will be ignored in such case.
  final bool isComplex;

  /// Whether the raster cache should be told that this painting is likely
  /// to change in the next frame.
  ///
  /// This hint tells the compositor not to cache the layer containing this
  /// widget because the cache will not be used in the future. If this hint is
  /// not set, the compositor will apply its own heuristics to decide whether
  /// the layer is likely to be reused in the future.
  ///
  /// This flag can't be set to true if both [painter] and [foregroundPainter]
  /// are null because this flag will be ignored in such case.
  final bool willChange;

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final ps = PixelSnap.of(context);
    Widget res = widgets.CustomPaint(
      painter: painter,
      foregroundPainter: foregroundPainter,
      size: size.pixelSnap(ps),
      isComplex: isComplex,
      willChange: willChange,
      child: child,
    );
    return res;
  }
}

/// A graphical icon widget drawn with a glyph from a font described in
/// an [IconData] such as material's predefined [IconData]s in [Icons].
///
/// Icons are not interactive. For an interactive icon, consider material's
/// [IconButton].
///
/// There must be an ambient [Directionality] widget when using [Icon].
/// Typically this is introduced automatically by the [WidgetsApp] or
/// [MaterialApp].
///
/// This widget assumes that the rendered icon is squared. Non-squared icons may
/// render incorrectly.
///
/// {@tool snippet}
///
/// This example shows how to create a [Row] of [Icon]s in different colors and
/// sizes. The first [Icon] uses a [semanticLabel] to announce in accessibility
/// modes like TalkBack and VoiceOver.
///
/// ![The following code snippet would generate a row of icons consisting of a pink heart, a green musical note, and a blue umbrella, each progressively bigger than the last.](https://flutter.github.io/assets-for-api-docs/assets/widgets/icon.png)
///
/// ```dart
/// const Row(
///   mainAxisAlignment: MainAxisAlignment.spaceAround,
///   children: <Widget>[
///     Icon(
///       Icons.favorite,
///       color: Colors.pink,
///       size: 24.0,
///       semanticLabel: 'Text to announce in accessibility modes',
///     ),
///     Icon(
///       Icons.audiotrack,
///       color: Colors.green,
///       size: 30.0,
///     ),
///     Icon(
///       Icons.beach_access,
///       color: Colors.blue,
///       size: 36.0,
///     ),
///   ],
/// )
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [IconButton], for interactive icons.
///  * [Icons], for the list of available Material Icons for use with this class.
///  * [IconTheme], which provides ambient configuration for icons.
///  * [ImageIcon], for showing icons from [AssetImage]s or other [ImageProvider]s.
class Icon extends StatelessWidget {
  /// Creates an icon.
  const Icon(
    this.icon, {
    super.key,
    this.size,
    this.fill,
    this.weight,
    this.grade,
    this.opticalSize,
    this.color,
    this.shadows,
    this.semanticLabel,
    this.textDirection,
    this.applyTextScaling,
    this.blendMode,
    this.fontWeight,
  }) : assert(fill == null || (0.0 <= fill && fill <= 1.0)),
       assert(weight == null || (0.0 < weight)),
       assert(opticalSize == null || (0.0 < opticalSize));

  /// The icon to display. The available icons are described in [Icons].
  ///
  /// The icon can be null, in which case the widget will render as an empty
  /// space of the specified [size].
  final IconData? icon;

  /// The size of the icon in logical pixels.
  ///
  /// Icons occupy a square with width and height equal to size.
  ///
  /// Defaults to the nearest [IconTheme]'s [IconThemeData.size].
  ///
  /// If this [Icon] is being placed inside an [IconButton], then use
  /// [IconButton.iconSize] instead, so that the [IconButton] can make the splash
  /// area the appropriate size as well. The [IconButton] uses an [IconTheme] to
  /// pass down the size to the [Icon].
  final double? size;

  /// The fill for drawing the icon.
  ///
  /// Requires the underlying icon font to support the `FILL` [FontVariation]
  /// axis, otherwise has no effect. Variable font filenames often indicate
  /// the supported axes. Must be between 0.0 (unfilled) and 1.0 (filled),
  /// inclusive.
  ///
  /// Can be used to convey a state transition for animation or interaction.
  ///
  /// Defaults to nearest [IconTheme]'s [IconThemeData.fill].
  ///
  /// See also:
  ///  * [weight], for controlling stroke weight.
  ///  * [grade], for controlling stroke weight in a more granular way.
  ///  * [opticalSize], for controlling optical size.
  final double? fill;

  /// The stroke weight for drawing the icon.
  ///
  /// Requires the underlying icon font to support the `wght` [FontVariation]
  /// axis, otherwise has no effect. Variable font filenames often indicate
  /// the supported axes. Must be greater than 0.
  ///
  /// Defaults to nearest [IconTheme]'s [IconThemeData.weight].
  ///
  /// See also:
  ///  * [fill], for controlling fill.
  ///  * [grade], for controlling stroke weight in a more granular way.
  ///  * [opticalSize], for controlling optical size.
  ///  * https://fonts.google.com/knowledge/glossary/weight_axis
  final double? weight;

  /// The grade (granular stroke weight) for drawing the icon.
  ///
  /// Requires the underlying icon font to support the `GRAD` [FontVariation]
  /// axis, otherwise has no effect. Variable font filenames often indicate
  /// the supported axes. Can be negative.
  ///
  /// Grade and [weight] both affect a symbol's stroke weight (thickness), but
  /// grade has a smaller impact on the size of the symbol.
  ///
  /// Grade is also available in some text fonts. One can match grade levels
  /// between text and symbols for a harmonious visual effect. For example, if
  /// the text font has a -25 grade value, the symbols can match it with a
  /// suitable value, say -25.
  ///
  /// Defaults to nearest [IconTheme]'s [IconThemeData.grade].
  ///
  /// See also:
  ///  * [fill], for controlling fill.
  ///  * [weight], for controlling stroke weight in a less granular way.
  ///  * [opticalSize], for controlling optical size.
  ///  * https://fonts.google.com/knowledge/glossary/grade_axis
  final double? grade;

  /// The optical size for drawing the icon.
  ///
  /// Requires the underlying icon font to support the `opsz` [FontVariation]
  /// axis, otherwise has no effect. Variable font filenames often indicate
  /// the supported axes. Must be greater than 0.
  ///
  /// For an icon to look the same at different sizes, the stroke weight
  /// (thickness) must change as the icon size scales. Optical size offers a way
  /// to automatically adjust the stroke weight as icon size changes.
  ///
  /// Defaults to nearest [IconTheme]'s [IconThemeData.opticalSize].
  ///
  /// See also:
  ///  * [fill], for controlling fill.
  ///  * [weight], for controlling stroke weight.
  ///  * [grade], for controlling stroke weight in a more granular way.
  ///  * https://fonts.google.com/knowledge/glossary/optical_size_axis
  final double? opticalSize;

  /// The color to use when drawing the icon.
  ///
  /// Defaults to the nearest [IconTheme]'s [IconThemeData.color].
  ///
  /// The color (whether specified explicitly here or obtained from the
  /// [IconTheme]) will be further adjusted by the nearest [IconTheme]'s
  /// [IconThemeData.opacity].
  ///
  /// {@tool snippet}
  /// Typically, a Material Design color will be used, as follows:
  ///
  /// ```dart
  /// Icon(
  ///   Icons.widgets,
  ///   color: Colors.blue.shade400,
  /// )
  /// ```
  /// {@end-tool}
  final Color? color;

  /// A list of [Shadow]s that will be painted underneath the icon.
  ///
  /// Multiple shadows are supported to replicate lighting from multiple light
  /// sources.
  ///
  /// Shadows must be in the same order for [Icon] to be considered as
  /// equivalent as order produces differing transparency.
  ///
  /// Defaults to the nearest [IconTheme]'s [IconThemeData.shadows].
  final List<Shadow>? shadows;

  /// Semantic label for the icon.
  ///
  /// Announced by assistive technologies (e.g TalkBack/VoiceOver).
  /// This label does not show in the UI.
  ///
  ///  * [SemanticsProperties.label], which is set to [semanticLabel] in the
  ///    underlying	 [Semantics] widget.
  final String? semanticLabel;

  /// The text direction to use for rendering the icon.
  ///
  /// If this is null, the ambient [Directionality] is used instead.
  ///
  /// Some icons follow the reading direction. For example, "back" buttons point
  /// left in left-to-right environments and right in right-to-left
  /// environments. Such icons have their [IconData.matchTextDirection] field
  /// set to true, and the [Icon] widget uses the [textDirection] to determine
  /// the orientation in which to draw the icon.
  ///
  /// This property has no effect if the [icon]'s [IconData.matchTextDirection]
  /// field is false, but for consistency a text direction value must always be
  /// specified, either directly using this property or using [Directionality].
  final TextDirection? textDirection;

  /// Whether to scale the size of this widget using the ambient [MediaQuery]'s [TextScaler].
  ///
  /// This is specially useful when you have an icon associated with a text, as
  /// scaling the text without scaling the icon would result in a confusing
  /// interface.
  ///
  /// Defaults to the nearest [IconTheme]'s
  /// [IconThemeData.applyTextScaling].
  final bool? applyTextScaling;

  /// The [BlendMode] to apply to the foreground of the icon.
  ///
  /// Defaults to [BlendMode.srcOver]
  final BlendMode? blendMode;

  /// The typeface thickness to use when painting the text (e.g., bold).
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    final ps = PixelSnap.of(context);
    Widget res = widgets.Icon(
      icon,
      size: size?.pixelSnap(ps),
      fill: fill,
      weight: weight,
      grade: grade,
      opticalSize: opticalSize,
      color: color,
      shadows: shadows,
      semanticLabel: semanticLabel,
      textDirection: textDirection,
      applyTextScaling: applyTextScaling,
      blendMode: blendMode,
      fontWeight: fontWeight,
    );
    return res;
  }
}

/// An icon that comes from an [ImageProvider], e.g. an [AssetImage].
///
/// See also:
///
///  * [IconButton], for interactive icons.
///  * [IconTheme], which provides ambient configuration for icons.
///  * [Icon], for icons based on glyphs from fonts instead of images.
///  * [Icons], the library of Material Icons.
class ImageIcon extends StatelessWidget {
  /// Creates an image icon.
  ///
  /// The [size] and [color] default to the value given by the current [IconTheme].
  const ImageIcon(
    this.image, {
    super.key,
    this.size,
    this.color,
    this.semanticLabel,
    this.useOriginalColors = false,
  }) : assert(
         !(useOriginalColors && color != null),
         'Cannot provide a color while useOriginalColors is true. '
         'To use a specific color, set useOriginalColors to false or omit it.',
       );

  /// The image to display as the icon.
  ///
  /// The icon can be null, in which case the widget will render as an empty
  /// space of the specified [size].
  final ImageProvider<Object>? image;

  /// The size of the icon in logical pixels.
  ///
  /// Icons occupy a square with width and height equal to size.
  ///
  /// Defaults to the current [IconTheme] size, if any. If there is no
  /// [IconTheme], or it does not specify an explicit size, then it defaults to
  /// 24.0.
  final double? size;

  /// The color to use when drawing the icon.
  ///
  /// Defaults to the current [IconTheme] color, if any. If there is
  /// no [IconTheme], then it defaults to not recolorizing the image.
  ///
  /// The image will be additionally adjusted by the opacity of the current
  /// [IconTheme], if any.
  final Color? color;

  /// Semantic label for the icon.
  ///
  /// Announced by assistive technologies (e.g TalkBack/VoiceOver).
  /// This label does not show in the UI.
  ///
  ///  * [SemanticsProperties.label], which is set to [semanticLabel] in the
  ///    underlying	 [Semantics] widget.
  final String? semanticLabel;

  /// Whether to render the image using its original colors.
  ///
  /// If this is false (the default), the image is colorized by merging the
  /// [color] (or, if that is null, the [IconTheme] color) with the image
  /// using [BlendMode.srcIn]. This is the standard behavior for icons.
  ///
  /// If this is true, the color-blend filter is disabled, and the image is
  /// rendered with its original colors. This allows multi-colored images,
  /// such as brand logos, to be displayed accurately.
  ///
  /// If this is true, [color] must be null.
  ///
  /// Defaults to false.
  final bool useOriginalColors;

  @override
  Widget build(BuildContext context) {
    final ps = PixelSnap.of(context);
    Widget res = widgets.ImageIcon(
      image,
      size: size?.pixelSnap(ps),
      color: color,
      semanticLabel: semanticLabel,
      useOriginalColors: useOriginalColors,
    );
    if (size == null) {
      res = PixelSnapSize(child: res);
    }
    return res;
  }
}

/// Animated version of [Align] which automatically transitions the child's
/// position over a given duration whenever the given [alignment] changes.
///
/// Here's an illustration of what this can look like, using a [curve] of
/// [Curves.fastOutSlowIn].
/// {@animation 250 266 https://flutter.github.io/assets-for-api-docs/assets/widgets/animated_align.mp4}
///
/// For the animation, you can choose a [curve] as well as a [duration] and the
/// widget will automatically animate to the new target [alignment]. If you require
/// more control over the animation (e.g. if you want to stop it mid-animation),
/// consider using an [AlignTransition] instead, which takes a provided
/// [Animation] as argument. While that allows you to fine-tune the animation,
/// it also requires more development overhead as you have to manually manage
/// the lifecycle of the underlying [AnimationController].
///
/// {@tool dartpad}
/// The following code implements the [AnimatedAlign] widget, using a [curve] of
/// [Curves.fastOutSlowIn].
///
/// ** See code in examples/api/lib/widgets/implicit_animations/animated_align.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [AnimatedContainer], which can transition more values at once.
///  * [AnimatedPadding], which can animate the padding instead of the
///    alignment.
///  * [AnimatedSlide], which can animate the translation of child by a given offset relative to its size.
///  * [AnimatedPositioned], which, as a child of a [Stack], automatically
///    transitions its child's position over a given duration whenever the given
///    position changes.
class AnimatedAlign extends StatelessWidget {
  /// Creates a widget that positions its child by an alignment that animates
  /// implicitly.
  const AnimatedAlign({
    super.key,
    required this.alignment,
    this.child,
    this.heightFactor,
    this.widthFactor,
    this.curve = Curves.linear,
    required this.duration,
    this.onEnd,
  }) : assert(widthFactor == null || widthFactor >= 0.0),
       assert(heightFactor == null || heightFactor >= 0.0);

  /// How to align the child.
  ///
  /// The x and y values of the [Alignment] control the horizontal and vertical
  /// alignment, respectively. An x value of -1.0 means that the left edge of
  /// the child is aligned with the left edge of the parent whereas an x value
  /// of 1.0 means that the right edge of the child is aligned with the right
  /// edge of the parent. Other values interpolate (and extrapolate) linearly.
  /// For example, a value of 0.0 means that the center of the child is aligned
  /// with the center of the parent.
  ///
  /// See also:
  ///
  ///  * [Alignment], which has more details and some convenience constants for
  ///    common positions.
  ///  * [AlignmentDirectional], which has a horizontal coordinate orientation
  ///    that depends on the [TextDirection].
  final AlignmentGeometry alignment;

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget? child;

  /// If non-null, sets its height to the child's height multiplied by this factor.
  ///
  /// Must be greater than or equal to 0.0, defaults to null.
  final double? heightFactor;

  /// If non-null, sets its width to the child's width multiplied by this factor.
  ///
  /// Must be greater than or equal to 0.0, defaults to null.
  final double? widthFactor;

  /// The curve to apply when animating the parameters of this container.
  final Curve curve;

  /// The duration over which to animate the parameters of this container.
  final Duration duration;

  /// Called every time an animation completes.
  ///
  /// This can be useful to trigger additional actions (e.g. another animation)
  /// at the end of the current animation.
  final void Function()? onEnd;

  @override
  Widget build(BuildContext context) {
    final ps = PixelSnap.of(context);
    Widget res = widgets.AnimatedAlign(
      alignment: alignment.pixelSnap(ps),
      heightFactor: heightFactor,
      widthFactor: widthFactor,
      curve: curve,
      duration: duration,
      onEnd: onEnd,
      child: child,
    );
    return res;
  }
}

/// Animated version of [Container] that gradually changes its values over a period of time.
///
/// The [AnimatedContainer] will automatically animate between the old and
/// new values of properties when they change using the provided curve and
/// duration. Properties that are null are not animated. Its child and
/// descendants are not animated.
///
/// This class is useful for generating simple implicit transitions between
/// different parameters to [Container] with its internal [AnimationController].
/// For more complex animations, you'll likely want to use a subclass of
/// [AnimatedWidget] such as the [DecoratedBoxTransition] or use your own
/// [AnimationController].
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=yI-8QHpGIP4}
///
/// {@tool dartpad}
/// The following example (depicted above) transitions an AnimatedContainer
/// between two states. It adjusts the `height`, `width`, `color`, and
/// [alignment] properties when tapped.
///
/// ** See code in examples/api/lib/widgets/implicit_animations/animated_container.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [AnimatedPadding], which is a subset of this widget that only
///    supports animating the [padding].
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
///  * [AnimatedPositioned], which, as a child of a [Stack], automatically
///    transitions its child's position over a given duration whenever the given
///    position changes.
///  * [AnimatedAlign], which automatically transitions its child's
///    position over a given duration whenever the given [AnimatedAlign.alignment] changes.
///  * [AnimatedSwitcher], which switches out a child for a new one with a customizable transition.
///  * [AnimatedCrossFade], which fades between two children and interpolates their sizes.
class AnimatedContainer extends StatelessWidget {
  /// Creates a container that animates its parameters implicitly.
  AnimatedContainer({
    super.key,
    this.alignment,
    this.padding,
    Color? color,
    Decoration? decoration,
    this.foregroundDecoration,
    double? width,
    double? height,
    BoxConstraints? constraints,
    this.margin,
    this.transform,
    this.transformAlignment,
    this.child,
    this.clipBehavior = Clip.none,
    this.curve = Curves.linear,
    required this.duration,
    this.onEnd,
  }) : assert(margin == null || margin.isNonNegative),
       assert(padding == null || padding.isNonNegative),
       assert(decoration == null || decoration.debugAssertIsValid()),
       assert(constraints == null || constraints.debugAssertIsValid()),
       assert(
         color == null || decoration == null,
         'Cannot provide both a color and a decoration\n'
         'The color argument is just a shorthand for "decoration: BoxDecoration(color: color)".',
       ),
       decoration =
           decoration ?? (color != null ? BoxDecoration(color: color) : null),
       constraints = (width != null || height != null)
           ? constraints?.tighten(width: width, height: height) ??
                 BoxConstraints.tightFor(width: width, height: height)
           : constraints;

  /// The [child] contained by the container.
  ///
  /// If null, and if the [constraints] are unbounded or also null, the
  /// container will expand to fill all available space in its parent, unless
  /// the parent provides unbounded constraints, in which case the container
  /// will attempt to be as small as possible.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget? child;

  /// Align the [child] within the container.
  ///
  /// If non-null, the container will expand to fill its parent and position its
  /// child within itself according to the given value. If the incoming
  /// constraints are unbounded, then the child will be shrink-wrapped instead.
  ///
  /// Ignored if [child] is null.
  ///
  /// See also:
  ///
  ///  * [Alignment], a class with convenient constants typically used to
  ///    specify an [AlignmentGeometry].
  ///  * [AlignmentDirectional], like [Alignment] for specifying alignments
  ///    relative to text direction.
  final AlignmentGeometry? alignment;

  /// Empty space to inscribe inside the [decoration]. The [child], if any, is
  /// placed inside this padding.
  final EdgeInsetsGeometry? padding;

  /// The decoration to paint behind the [child].
  ///
  /// A shorthand for specifying just a solid color is available in the
  /// constructor: set the `color` argument instead of the `decoration`
  /// argument.
  final Decoration? decoration;

  /// The decoration to paint in front of the child.
  final Decoration? foregroundDecoration;

  /// Additional constraints to apply to the child.
  ///
  /// The constructor `width` and `height` arguments are combined with the
  /// `constraints` argument to set this property.
  ///
  /// The [padding] goes inside the constraints.
  final BoxConstraints? constraints;

  /// Empty space to surround the [decoration] and [child].
  final EdgeInsetsGeometry? margin;

  /// The transformation matrix to apply before painting the container.
  final Matrix4? transform;

  /// The alignment of the origin, relative to the size of the container, if [transform] is specified.
  ///
  /// When [transform] is null, the value of this property is ignored.
  ///
  /// See also:
  ///
  ///  * [Transform.alignment], which is set by this property.
  final AlignmentGeometry? transformAlignment;

  /// The clip behavior when [AnimatedContainer.decoration] is not null.
  ///
  /// Defaults to [Clip.none]. Must be [Clip.none] if [decoration] is null.
  ///
  /// Unlike other properties of [AnimatedContainer], changes to this property
  /// apply immediately and have no animation.
  ///
  /// If a clip is to be applied, the [Decoration.getClipPath] method
  /// for the provided decoration must return a clip path. (This is not
  /// supported by all decorations; the default implementation of that
  /// method throws an [UnsupportedError].)
  final Clip clipBehavior;

  /// The curve to apply when animating the parameters of this container.
  final Curve curve;

  /// The duration over which to animate the parameters of this container.
  final Duration duration;

  /// Called every time an animation completes.
  ///
  /// This can be useful to trigger additional actions (e.g. another animation)
  /// at the end of the current animation.
  final void Function()? onEnd;

  @override
  Widget build(BuildContext context) {
    final ps = PixelSnap.of(context);
    Widget res = widgets.AnimatedContainer(
      alignment: alignment?.pixelSnap(ps),
      padding: padding?.pixelSnap(ps),
      decoration: decoration?.pixelSnap(ps),
      foregroundDecoration: foregroundDecoration?.pixelSnap(ps),
      constraints: constraints?.pixelSnap(ps),
      margin: margin?.pixelSnap(ps),
      transform: transform,
      transformAlignment: transformAlignment?.pixelSnap(ps),
      clipBehavior: clipBehavior,
      curve: curve,
      duration: duration,
      onEnd: onEnd,
      child: child,
    );
    return res;
  }
}

/// A widget that cross-fades between two given children and animates itself
/// between their sizes.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=PGK2UUAyE54}
///
/// The animation is controlled through the [crossFadeState] parameter.
/// [firstCurve] and [secondCurve] represent the opacity curves of the two
/// children. The [firstCurve] is inverted, i.e. it fades out when providing a
/// growing curve like [Curves.linear]. The [sizeCurve] is the curve used to
/// animate between the size of the fading-out child and the size of the
/// fading-in child.
///
/// This widget is intended to be used to fade a pair of widgets with the same
/// width. In the case where the two children have different heights, the
/// animation crops overflowing children during the animation by aligning their
/// top edge, which means that the bottom will be clipped.
///
/// The animation is automatically triggered when an existing
/// [AnimatedCrossFade] is rebuilt with a different value for the
/// [crossFadeState] property.
///
/// {@tool snippet}
///
/// This code fades between two representations of the Flutter logo. It depends
/// on a boolean field `_first`; when `_first` is true, the first logo is shown,
/// otherwise the second logo is shown. When the field changes state, the
/// [AnimatedCrossFade] widget cross-fades between the two forms of the logo
/// over three seconds.
///
/// ```dart
/// AnimatedCrossFade(
///   duration: const Duration(seconds: 3),
///   firstChild: const FlutterLogo(style: FlutterLogoStyle.horizontal, size: 100.0),
///   secondChild: const FlutterLogo(style: FlutterLogoStyle.stacked, size: 100.0),
///   crossFadeState: _first ? CrossFadeState.showFirst : CrossFadeState.showSecond,
/// )
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [AnimatedOpacity], which fades between nothing and a single child.
///  * [AnimatedSwitcher], which switches out a child for a new one with a
///    customizable transition, supporting multiple cross-fades at once.
///  * [AnimatedSize], the lower-level widget which [AnimatedCrossFade] uses to
///    automatically change size.
class AnimatedCrossFade extends StatelessWidget {
  /// Creates a cross-fade animation widget.
  ///
  /// The [duration] of the animation is the same for all components (fade in,
  /// fade out, and size), and you can pass [Interval]s instead of [Curve]s in
  /// order to have finer control, e.g., creating an overlap between the fades.
  const AnimatedCrossFade({
    super.key,
    required this.firstChild,
    required this.secondChild,
    this.firstCurve = Curves.linear,
    this.secondCurve = Curves.linear,
    this.sizeCurve = Curves.linear,
    this.alignment = Alignment.topCenter,
    required this.crossFadeState,
    required this.duration,
    this.reverseDuration,
    this.layoutBuilder = widgets.AnimatedCrossFade.defaultLayoutBuilder,
    this.excludeBottomFocus = true,
    this.clipBehavior = Clip.hardEdge,
    this.onEnd,
  });

  /// The child that is visible when [crossFadeState] is
  /// [CrossFadeState.showFirst]. It fades out when transitioning
  /// [crossFadeState] from [CrossFadeState.showFirst] to
  /// [CrossFadeState.showSecond] and vice versa.
  final Widget firstChild;

  /// The child that is visible when [crossFadeState] is
  /// [CrossFadeState.showSecond]. It fades in when transitioning
  /// [crossFadeState] from [CrossFadeState.showFirst] to
  /// [CrossFadeState.showSecond] and vice versa.
  final Widget secondChild;

  /// The child that will be shown when the animation has completed.
  final CrossFadeState crossFadeState;

  /// The duration of the whole orchestrated animation.
  final Duration duration;

  /// The duration of the whole orchestrated animation when running in reverse.
  ///
  /// If not supplied, this defaults to [duration].
  final Duration? reverseDuration;

  /// The fade curve of the first child.
  ///
  /// Defaults to [Curves.linear].
  final Curve firstCurve;

  /// The fade curve of the second child.
  ///
  /// Defaults to [Curves.linear].
  final Curve secondCurve;

  /// The curve of the animation between the two children's sizes.
  ///
  /// Defaults to [Curves.linear].
  final Curve sizeCurve;

  /// How the children should be aligned while the size is animating.
  ///
  /// Defaults to [Alignment.topCenter].
  ///
  /// See also:
  ///
  ///  * [Alignment], a class with convenient constants typically used to
  ///    specify an [AlignmentGeometry].
  ///  * [AlignmentDirectional], like [Alignment] for specifying alignments
  ///    relative to text direction.
  final AlignmentGeometry alignment;

  /// A builder that positions the [firstChild] and [secondChild] widgets.
  ///
  /// The widget returned by this method is wrapped in an [AnimatedSize].
  ///
  /// By default, this uses [AnimatedCrossFade.defaultLayoutBuilder], which uses
  /// a [Stack] and aligns the `bottomChild` to the top of the stack while
  /// providing the `topChild` as the non-positioned child to fill the provided
  /// constraints. This works well when the [AnimatedCrossFade] is in a position
  /// to change size and when the children are not flexible. However, if the
  /// children are less fussy about their sizes (for example a
  /// [CircularProgressIndicator] inside a [Center]), or if the
  /// [AnimatedCrossFade] is being forced to a particular size, then it can
  /// result in the widgets jumping about when the cross-fade state is changed.
  final Widget Function(Widget, Key, Widget, Key) layoutBuilder;

  /// When true, this is equivalent to wrapping the bottom widget with an [ExcludeFocus]
  /// widget while it is at the bottom of the cross-fade stack.
  ///
  /// Defaults to true. When it is false, the bottom widget in the cross-fade stack
  /// can remain in focus until the top widget requests focus. This is useful for
  /// animating between different [TextField]s so the keyboard remains open during the
  /// cross-fade animation.
  final bool excludeBottomFocus;

  /// Controls whether the content is clipped during the cross-fade transition.
  ///
  /// During the size transition between [firstChild] and [secondChild],
  /// the content is clipped by default to prevent it from overflowing the
  /// bounding box of the animating widget.
  ///
  /// Set this to [Clip.none] to disable clipping entirely. This can be
  /// useful for widgets with shadows or visual effects that extend beyond
  /// their bounds.
  ///
  /// Defaults to [Clip.hardEdge].
  final Clip clipBehavior;

  /// Called every time an animation completes.
  ///
  /// This can be useful to trigger additional actions (e.g. another animation)
  /// at the end of the current animation.
  final void Function()? onEnd;

  @override
  Widget build(BuildContext context) {
    final ps = PixelSnap.of(context);
    Widget res = widgets.AnimatedCrossFade(
      firstChild: firstChild,
      secondChild: secondChild,
      crossFadeState: crossFadeState,
      duration: duration,
      reverseDuration: reverseDuration,
      firstCurve: firstCurve,
      secondCurve: secondCurve,
      sizeCurve: sizeCurve,
      alignment: alignment.pixelSnap(ps),
      layoutBuilder: layoutBuilder,
      excludeBottomFocus: excludeBottomFocus,
      clipBehavior: clipBehavior,
      onEnd: onEnd,
    );
    return res;
  }
}

/// Animated version of [Positioned] which automatically transitions the child's
/// position over a given duration whenever the given position changes.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=hC3s2YdtWt8}
///
/// Only works if it's the child of a [Stack].
///
/// This widget is a good choice if the _size_ of the child would end up
/// changing as a result of this animation. If the size is intended to remain
/// the same, with only the _position_ changing over time, then consider
/// [SlideTransition] instead. [SlideTransition] only triggers a repaint each
/// frame of the animation, whereas [AnimatedPositioned] will trigger a relayout
/// as well.
///
/// Here's an illustration of what using this widget looks like, using a [curve]
/// of [Curves.fastOutSlowIn].
/// {@animation 250 266 https://flutter.github.io/assets-for-api-docs/assets/widgets/animated_positioned.mp4}
///
/// For the animation, you can choose a [curve] as well as a [duration] and the
/// widget will automatically animate to the new target position. If you require
/// more control over the animation (e.g. if you want to stop it mid-animation),
/// consider using a [PositionedTransition] instead, which takes a provided
/// [Animation] as an argument. While that allows you to fine-tune the animation,
/// it also requires more development overhead as you have to manually manage
/// the lifecycle of the underlying [AnimationController].
///
/// {@tool dartpad}
/// The following example transitions an AnimatedPositioned
/// between two states. It adjusts the `height`, `width`, and
/// [Positioned] properties when tapped.
///
/// ** See code in examples/api/lib/widgets/implicit_animations/animated_positioned.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [AnimatedPositionedDirectional], which adapts to the ambient
///    [Directionality] (the same as this widget, but for animating
///    [PositionedDirectional]).
class AnimatedPositioned extends StatelessWidget {
  /// Creates a widget that animates its position implicitly.
  ///
  /// Only two out of the three horizontal values ([left], [right],
  /// [width]), and only two out of the three vertical values ([top],
  /// [bottom], [height]), can be set. In each case, at least one of
  /// the three must be null.
  const AnimatedPositioned({
    super.key,
    required this.child,
    this.left,
    this.top,
    this.right,
    this.bottom,
    this.width,
    this.height,
    this.curve = Curves.linear,
    required this.duration,
    this.onEnd,
  }) : assert(left == null || right == null || width == null),
       assert(top == null || bottom == null || height == null);

  /// Creates a widget that animates the rectangle it occupies implicitly.
  AnimatedPositioned.fromRect({
    super.key,
    required this.child,
    required Rect rect,
    this.curve = Curves.linear,
    required this.duration,
    this.onEnd,
  }) : left = rect.left,
       top = rect.top,
       width = rect.width,
       height = rect.height,
       right = null,
       bottom = null;

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget child;

  /// The offset of the child's left edge from the left of the stack.
  final double? left;

  /// The offset of the child's top edge from the top of the stack.
  final double? top;

  /// The offset of the child's right edge from the right of the stack.
  final double? right;

  /// The offset of the child's bottom edge from the bottom of the stack.
  final double? bottom;

  /// The child's width.
  ///
  /// Only two out of the three horizontal values ([left], [right], [width]) can
  /// be set. The third must be null.
  final double? width;

  /// The child's height.
  ///
  /// Only two out of the three vertical values ([top], [bottom], [height]) can
  /// be set. The third must be null.
  final double? height;

  /// The curve to apply when animating the parameters of this container.
  final Curve curve;

  /// The duration over which to animate the parameters of this container.
  final Duration duration;

  /// Called every time an animation completes.
  ///
  /// This can be useful to trigger additional actions (e.g. another animation)
  /// at the end of the current animation.
  final void Function()? onEnd;

  @override
  Widget build(BuildContext context) {
    final ps = PixelSnap.of(context);
    Widget res = widgets.AnimatedPositioned(
      left: left?.pixelSnap(ps),
      top: top?.pixelSnap(ps),
      right: right?.pixelSnap(ps),
      bottom: bottom?.pixelSnap(ps),
      width: width?.pixelSnap(ps),
      height: height?.pixelSnap(ps),
      curve: curve,
      duration: duration,
      onEnd: onEnd,
      child: child,
    );
    return res;
  }
}

/// Animated version of [Padding] which automatically transitions the
/// indentation over a given duration whenever the given inset changes.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=PY2m0fhGNz4}
///
/// Here's an illustration of what using this widget looks like, using a [curve]
/// of [Curves.fastOutSlowIn].
/// {@animation 250 266 https://flutter.github.io/assets-for-api-docs/assets/widgets/animated_padding.mp4}
///
/// {@tool dartpad}
/// The following code implements the [AnimatedPadding] widget, using a [curve] of
/// [Curves.easeInOut].
///
/// ** See code in examples/api/lib/widgets/implicit_animations/animated_padding.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [AnimatedContainer], which can transition more values at once.
///  * [AnimatedAlign], which automatically transitions its child's
///    position over a given duration whenever the given
///    [AnimatedAlign.alignment] changes.
class AnimatedPadding extends StatelessWidget {
  /// Creates a widget that insets its child by a value that animates
  /// implicitly.
  AnimatedPadding({
    super.key,
    required this.padding,
    this.child,
    this.curve = Curves.linear,
    required this.duration,
    this.onEnd,
  }) : assert(padding.isNonNegative);

  /// The amount of space by which to inset the child.
  final EdgeInsetsGeometry padding;

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget? child;

  /// The curve to apply when animating the parameters of this container.
  final Curve curve;

  /// The duration over which to animate the parameters of this container.
  final Duration duration;

  /// Called every time an animation completes.
  ///
  /// This can be useful to trigger additional actions (e.g. another animation)
  /// at the end of the current animation.
  final void Function()? onEnd;

  @override
  Widget build(BuildContext context) {
    final ps = PixelSnap.of(context);
    Widget res = widgets.AnimatedPadding(
      padding: padding.pixelSnap(ps),
      curve: curve,
      duration: duration,
      onEnd: onEnd,
      child: child,
    );
    return res;
  }
}

/// Animated version of [PhysicalModel].
///
/// The [borderRadius] and [elevation] are animated.
///
/// The [color] is animated if the [animateColor] property is set; otherwise,
/// the color changes immediately at the start of the animation for the other
/// two properties. This allows the color to be animated independently (e.g.
/// because it is being driven by an [AnimatedTheme]).
///
/// The [shape] is not animated.
///
/// Here's an illustration of what using this widget looks like, using a [curve]
/// of [Curves.fastOutSlowIn].
/// {@animation 250 266 https://flutter.github.io/assets-for-api-docs/assets/widgets/animated_physical_model.mp4}
class AnimatedPhysicalModel extends StatelessWidget {
  /// Creates a widget that animates the properties of a [PhysicalModel].
  ///
  /// The [elevation] must be non-negative.
  ///
  /// Animating [color] is optional and is controlled by the [animateColor] flag.
  ///
  /// Animating [shadowColor] is optional and is controlled by the [animateShadowColor] flag.
  const AnimatedPhysicalModel({
    super.key,
    required this.child,
    this.shape = BoxShape.rectangle,
    this.clipBehavior = Clip.none,
    this.borderRadius,
    this.elevation = 0.0,
    required this.color,
    this.animateColor = true,
    required this.shadowColor,
    this.animateShadowColor = true,
    this.curve = Curves.linear,
    required this.duration,
    this.onEnd,
  }) : assert(elevation >= 0.0);

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget child;

  /// The type of shape.
  ///
  /// This property is not animated.
  final BoxShape shape;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.none].
  final Clip clipBehavior;

  /// The target border radius of the rounded corners for a rectangle shape.
  ///
  /// If null, treated as [BorderRadius.zero].
  final BorderRadius? borderRadius;

  /// The target z-coordinate relative to the parent at which to place this
  /// physical object.
  ///
  /// The value will always be non-negative.
  final double elevation;

  /// The target background color.
  final Color color;

  /// Whether the color should be animated.
  final bool animateColor;

  /// The target shadow color.
  final Color shadowColor;

  /// Whether the shadow color should be animated.
  final bool animateShadowColor;

  /// The curve to apply when animating the parameters of this container.
  final Curve curve;

  /// The duration over which to animate the parameters of this container.
  final Duration duration;

  /// Called every time an animation completes.
  ///
  /// This can be useful to trigger additional actions (e.g. another animation)
  /// at the end of the current animation.
  final void Function()? onEnd;

  @override
  Widget build(BuildContext context) {
    final ps = PixelSnap.of(context);
    Widget res = widgets.AnimatedPhysicalModel(
      shape: shape,
      clipBehavior: clipBehavior,
      borderRadius: borderRadius?.pixelSnap(ps),
      elevation: elevation.pixelSnap(ps),
      color: color,
      animateColor: animateColor,
      shadowColor: shadowColor,
      animateShadowColor: animateShadowColor,
      curve: curve,
      duration: duration,
      onEnd: onEnd,
      child: child,
    );
    return res;
  }
}

/// Animated widget that automatically transitions its size over a given
/// duration whenever the given child's size changes.
///
/// {@tool dartpad}
/// This example defines a widget that uses [AnimatedSize] to change the size of
/// the [SizedBox] on tap.
///
/// ** See code in examples/api/lib/widgets/animated_size/animated_size.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [SizeTransition], which changes its size based on an [Animation].
class AnimatedSize extends StatelessWidget {
  /// Creates a widget that animates its size to match that of its child.
  const AnimatedSize({
    super.key,
    this.child,
    this.alignment = Alignment.center,
    this.curve = Curves.linear,
    required this.duration,
    this.reverseDuration,
    this.clipBehavior = Clip.hardEdge,
    this.onEnd,
  });

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget? child;

  /// The alignment of the child within the parent when the parent is not yet
  /// the same size as the child.
  ///
  /// The x and y values of the alignment control the horizontal and vertical
  /// alignment, respectively. An x value of -1.0 means that the left edge of
  /// the child is aligned with the left edge of the parent whereas an x value
  /// of 1.0 means that the right edge of the child is aligned with the right
  /// edge of the parent. Other values interpolate (and extrapolate) linearly.
  /// For example, a value of 0.0 means that the center of the child is aligned
  /// with the center of the parent.
  ///
  /// Defaults to [Alignment.center].
  ///
  /// See also:
  ///
  ///  * [Alignment], a class with convenient constants typically used to
  ///    specify an [AlignmentGeometry].
  ///  * [AlignmentDirectional], like [Alignment] for specifying alignments
  ///    relative to text direction.
  final AlignmentGeometry alignment;

  /// The animation curve when transitioning this widget's size to match the
  /// child's size.
  final Curve curve;

  /// The duration when transitioning this widget's size to match the child's
  /// size.
  final Duration duration;

  /// The duration when transitioning this widget's size to match the child's
  /// size when going in reverse.
  ///
  /// If not specified, defaults to [duration].
  final Duration? reverseDuration;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.hardEdge].
  final Clip clipBehavior;

  /// Called every time an animation completes.
  ///
  /// This can be useful to trigger additional actions (e.g. another animation)
  /// at the end of the current animation.
  final void Function()? onEnd;

  @override
  Widget build(BuildContext context) {
    final ps = PixelSnap.of(context);
    Widget res = widgets.AnimatedSize(
      alignment: alignment.pixelSnap(ps),
      curve: curve,
      duration: duration,
      reverseDuration: reverseDuration,
      clipBehavior: clipBehavior,
      onEnd: onEnd,
      child: child,
    );
    return res;
  }
}

/// A widget that displays its children in a one-dimensional array.
///
/// The [Flex] widget allows you to control the axis along which the children are
/// placed (horizontal or vertical). This is referred to as the _main axis_. If
/// you know the main axis in advance, then consider using a [Row] (if it's
/// horizontal) or [Column] (if it's vertical) instead, because that will be less
/// verbose.
///
/// To cause a child to expand to fill the available space in the [direction]
/// of this widget's main axis, wrap the child in an [Expanded] widget.
///
/// The [Flex] widget does not scroll (and in general it is considered an error
/// to have more children in a [Flex] than will fit in the available room). If
/// you have some widgets and want them to be able to scroll if there is
/// insufficient room, consider using a [ListView].
///
/// The [Flex] widget does not allow its children to wrap across multiple
/// horizontal or vertical runs. For a widget that allows its children to wrap,
/// consider using the [Wrap] widget instead of [Flex].
///
/// If you only have one child, then rather than using [Flex], [Row], or
/// [Column], consider using [Align] or [Center] to position the child.
///
/// ## Layout algorithm
///
/// _This section describes how a [Flex] is rendered by the framework._
/// _See [BoxConstraints] for an introduction to box layout models._
///
/// Layout for a [Flex] proceeds in six steps:
///
/// 1. Layout each child with a null or zero flex factor (e.g., those that are
///    not [Expanded]) with unbounded main axis constraints and the incoming
///    cross axis constraints. If the [crossAxisAlignment] is
///    [CrossAxisAlignment.stretch], instead use tight cross axis constraints
///    that match the incoming max extent in the cross axis.
/// 2. Divide the remaining main axis space among the children with non-zero
///    flex factors (e.g., those that are [Expanded]) according to their flex
///    factor. For example, a child with a flex factor of 2.0 will receive twice
///    the amount of main axis space as a child with a flex factor of 1.0.
/// 3. Layout each of the remaining children with the same cross axis
///    constraints as in step 1, but instead of using unbounded main axis
///    constraints, use max axis constraints based on the amount of space
///    allocated in step 2. Children with [Flexible.fit] properties that are
///    [FlexFit.tight] are given tight constraints (i.e., forced to fill the
///    allocated space), and children with [Flexible.fit] properties that are
///    [FlexFit.loose] are given loose constraints (i.e., not forced to fill the
///    allocated space).
/// 4. The cross axis extent of the [Flex] is the maximum cross axis extent of
///    the children (which will always satisfy the incoming constraints).
/// 5. The main axis extent of the [Flex] is determined by the [mainAxisSize]
///    property. If the [mainAxisSize] property is [MainAxisSize.max], then the
///    main axis extent of the [Flex] is the max extent of the incoming main
///    axis constraints. If the [mainAxisSize] property is [MainAxisSize.min],
///    then the main axis extent of the [Flex] is the sum of the main axis
///    extents of the children (subject to the incoming constraints).
/// 6. Determine the position for each child according to the
///    [mainAxisAlignment] and the [crossAxisAlignment]. For example, if the
///    [mainAxisAlignment] is [MainAxisAlignment.spaceBetween], any main axis
///    space that has not been allocated to children is divided evenly and
///    placed between the children.
///
/// See also:
///
///  * [Row], for a version of this widget that is always horizontal.
///  * [Column], for a version of this widget that is always vertical.
///  * [Expanded], to indicate children that should take all the remaining room.
///  * [Flexible], to indicate children that should share the remaining room.
///  * [Spacer], a widget that takes up space proportional to its flex value.
///    that may be sized smaller (leaving some remaining room unused).
///  * [Wrap], for a widget that allows its children to wrap over multiple _runs_.
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
class Flex extends MultiChildRenderObjectWidget {
  /// Creates a flex layout.
  ///
  /// The [direction] is required.
  ///
  /// If [crossAxisAlignment] is [CrossAxisAlignment.baseline], then
  /// [textBaseline] must not be null.
  ///
  /// The [textDirection] argument defaults to the ambient [Directionality], if
  /// any. If there is no ambient directionality, and a text direction is going
  /// to be necessary to decide which direction to lay the children in or to
  /// disambiguate `start` or `end` values for the main or cross axis
  /// directions, the [textDirection] must not be null.
  const Flex({
    super.key,
    required this.direction,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline, // NO DEFAULT: we don't know what the text's baseline should be
    this.clipBehavior = Clip.none,
    this.spacing = 0.0,
    super.children,
  }) : assert(
         (crossAxisAlignment != CrossAxisAlignment.baseline) ||
             textBaseline != null,
         'textBaseline is required if you specify the crossAxisAlignment with CrossAxisAlignment.baseline',
       );

  /// The direction to use as the main axis.
  ///
  /// If you know the axis in advance, then consider using a [Row] (if it's
  /// horizontal) or [Column] (if it's vertical) instead of a [Flex], since that
  /// will be less verbose. (For [Row] and [Column] this property is fixed to
  /// the appropriate axis.)
  final Axis direction;

  /// How the children should be placed along the main axis.
  ///
  /// For example, [MainAxisAlignment.start], the default, places the children
  /// at the start (i.e., the left for a [Row] or the top for a [Column]) of the
  /// main axis.
  final MainAxisAlignment mainAxisAlignment;

  /// How much space should be occupied in the main axis.
  ///
  /// After allocating space to children, there might be some remaining free
  /// space. This value controls whether to maximize or minimize the amount of
  /// free space, subject to the incoming layout constraints.
  ///
  /// If some children have a non-zero flex factors (and none have a fit of
  /// [FlexFit.loose]), they will expand to consume all the available space and
  /// there will be no remaining free space to maximize or minimize, making this
  /// value irrelevant to the final layout.
  final MainAxisSize mainAxisSize;

  /// How the children should be placed along the cross axis.
  ///
  /// For example, [CrossAxisAlignment.center], the default, centers the
  /// children in the cross axis (e.g., horizontally for a [Column]).
  ///
  /// When the cross axis is vertical (as for a [Row]) and the children
  /// contain text, consider using [CrossAxisAlignment.baseline] instead.
  /// This typically produces better visual results if the different children
  /// have text with different font metrics, for example because they differ in
  /// [TextStyle.fontSize] or other [TextStyle] properties, or because
  /// they use different fonts due to being written in different scripts.
  final CrossAxisAlignment crossAxisAlignment;

  /// Determines the order to lay children out horizontally and how to interpret
  /// `start` and `end` in the horizontal direction.
  ///
  /// Defaults to the ambient [Directionality].
  ///
  /// If [textDirection] is [TextDirection.rtl], then the direction in which
  /// text flows starts from right to left. Otherwise, if [textDirection] is
  /// [TextDirection.ltr], then the direction in which text flows starts from
  /// left to right.
  ///
  /// If the [direction] is [Axis.horizontal], this controls the order in which
  /// the children are positioned (left-to-right or right-to-left), and the
  /// meaning of the [mainAxisAlignment] property's [MainAxisAlignment.start] and
  /// [MainAxisAlignment.end] values.
  ///
  /// If the [direction] is [Axis.horizontal], and either the
  /// [mainAxisAlignment] is either [MainAxisAlignment.start] or
  /// [MainAxisAlignment.end], or there's more than one child, then the
  /// [textDirection] (or the ambient [Directionality]) must not be null.
  ///
  /// If the [direction] is [Axis.vertical], this controls the meaning of the
  /// [crossAxisAlignment] property's [CrossAxisAlignment.start] and
  /// [CrossAxisAlignment.end] values.
  ///
  /// If the [direction] is [Axis.vertical], and the [crossAxisAlignment] is
  /// either [CrossAxisAlignment.start] or [CrossAxisAlignment.end], then the
  /// [textDirection] (or the ambient [Directionality]) must not be null.
  final TextDirection? textDirection;

  /// Determines the order to lay children out vertically and how to interpret
  /// `start` and `end` in the vertical direction.
  ///
  /// Defaults to [VerticalDirection.down].
  ///
  /// If the [direction] is [Axis.vertical], this controls which order children
  /// are painted in (down or up), the meaning of the [mainAxisAlignment]
  /// property's [MainAxisAlignment.start] and [MainAxisAlignment.end] values.
  ///
  /// If the [direction] is [Axis.vertical], and either the [mainAxisAlignment]
  /// is either [MainAxisAlignment.start] or [MainAxisAlignment.end], or there's
  /// more than one child, then the [verticalDirection] must not be null.
  ///
  /// If the [direction] is [Axis.horizontal], this controls the meaning of the
  /// [crossAxisAlignment] property's [CrossAxisAlignment.start] and
  /// [CrossAxisAlignment.end] values.
  ///
  /// If the [direction] is [Axis.horizontal], and the [crossAxisAlignment] is
  /// either [CrossAxisAlignment.start] or [CrossAxisAlignment.end], then the
  /// [verticalDirection] must not be null.
  final VerticalDirection verticalDirection;

  /// If aligning items according to their baseline, which baseline to use.
  ///
  /// This must be set if using baseline alignment. There is no default because there is no
  /// way for the framework to know the correct baseline _a priori_.
  final TextBaseline? textBaseline;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.none].
  final Clip clipBehavior;

  /// {@macro flutter.rendering.RenderFlex.spacing}
  final double spacing;

  bool get _needTextDirection {
    switch (direction) {
      case Axis.horizontal:
        return true; // because it affects the layout order.
      case Axis.vertical:
        return crossAxisAlignment == CrossAxisAlignment.start ||
            crossAxisAlignment == CrossAxisAlignment.end;
    }
  }

  /// The value to pass to [RenderFlex.textDirection].
  ///
  /// This value is derived from the [textDirection] property and the ambient
  /// [Directionality]. The value is null if there is no need to specify the
  /// text direction. In practice there's always a need to specify the direction
  /// except for vertical flexes (e.g. [Column]s) whose [crossAxisAlignment] is
  /// not dependent on the text direction (not `start` or `end`). In particular,
  /// a [Row] always needs a text direction because the text direction controls
  /// its layout order. (For [Column]s, the layout order is controlled by
  /// [verticalDirection], which is always specified as it does not depend on an
  /// inherited widget and defaults to [VerticalDirection.down].)
  ///
  /// This method exists so that subclasses of [Flex] that create their own
  /// render objects that are derived from [RenderFlex] can do so and still use
  /// the logic for providing a text direction only when it is necessary.
  @protected
  TextDirection? getEffectiveTextDirection(BuildContext context) {
    return textDirection ??
        (_needTextDirection ? Directionality.maybeOf(context) : null);
  }

  @override
  RenderFlex createRenderObject(BuildContext context) {
    return RenderFlex(
      pixelSnap: PixelSnap.of(context),
      direction: direction,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: getEffectiveTextDirection(context),
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      clipBehavior: clipBehavior,
      spacing: spacing,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    covariant RenderFlex renderObject,
  ) {
    renderObject
      ..pixelSnap = PixelSnap.of(context)
      ..direction = direction
      ..mainAxisAlignment = mainAxisAlignment
      ..mainAxisSize = mainAxisSize
      ..crossAxisAlignment = crossAxisAlignment
      ..textDirection = getEffectiveTextDirection(context)
      ..verticalDirection = verticalDirection
      ..textBaseline = textBaseline
      ..clipBehavior = clipBehavior
      ..spacing = spacing;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(EnumProperty<Axis>('direction', direction));
    properties.add(
      EnumProperty<MainAxisAlignment>('mainAxisAlignment', mainAxisAlignment),
    );
    properties.add(
      EnumProperty<MainAxisSize>(
        'mainAxisSize',
        mainAxisSize,
        defaultValue: MainAxisSize.max,
      ),
    );
    properties.add(
      EnumProperty<CrossAxisAlignment>(
        'crossAxisAlignment',
        crossAxisAlignment,
      ),
    );
    properties.add(
      EnumProperty<TextDirection>(
        'textDirection',
        textDirection,
        defaultValue: null,
      ),
    );
    properties.add(
      EnumProperty<VerticalDirection>(
        'verticalDirection',
        verticalDirection,
        defaultValue: VerticalDirection.down,
      ),
    );
    properties.add(
      EnumProperty<TextBaseline>(
        'textBaseline',
        textBaseline,
        defaultValue: null,
      ),
    );
    properties.add(
      EnumProperty<Clip>('clipBehavior', clipBehavior, defaultValue: Clip.none),
    );
    properties.add(DoubleProperty('spacing', spacing, defaultValue: 0.0));
  }
}

/// A widget that displays its children in a horizontal array.
///
/// To cause a child to expand to fill the available horizontal space, wrap the
/// child in an [Expanded] widget.
///
/// The [Row] widget does not scroll (and in general it is considered an error
/// to have more children in a [Row] than will fit in the available room). If
/// you have a line of widgets and want them to be able to scroll if there is
/// insufficient room, consider using a [ListView].
///
/// For a vertical variant, see [Column].
///
/// If you only have one child, then consider using [Align] or [Center] to
/// position the child.
///
/// By default, [crossAxisAlignment] is [CrossAxisAlignment.center], which
/// centers the children in the vertical axis.  If several of the children
/// contain text, this is likely to make them visually misaligned if
/// they have different font metrics (for example because they differ in
/// [TextStyle.fontSize] or other [TextStyle] properties, or because
/// they use different fonts due to being written in different scripts).
/// Consider using [CrossAxisAlignment.baseline] instead.
///
/// {@tool snippet}
///
/// This example divides the available space into three (horizontally), and
/// places text centered in the first two cells and the Flutter logo centered in
/// the third:
///
/// ![](https://flutter.github.io/assets-for-api-docs/assets/widgets/row.png)
///
/// ```dart
/// const Row(
///   children: <Widget>[
///     Expanded(
///       child: Text('Deliver features faster', textAlign: TextAlign.center),
///     ),
///     Expanded(
///       child: Text('Craft beautiful UIs', textAlign: TextAlign.center),
///     ),
///     Expanded(
///       child: FittedBox(
///         child: FlutterLogo(),
///       ),
///     ),
///   ],
/// )
/// ```
/// {@end-tool}
///
/// ## Troubleshooting
///
/// ### Why does my row have a yellow and black warning stripe?
///
/// If the non-flexible contents of the row (those that are not wrapped in
/// [Expanded] or [Flexible] widgets) are together wider than the row itself,
/// then the row is said to have overflowed. When a row overflows, the row does
/// not have any remaining space to share between its [Expanded] and [Flexible]
/// children. The row reports this by drawing a yellow and black striped
/// warning box on the edge that is overflowing. If there is room on the outside
/// of the row, the amount of overflow is printed in red lettering.
///
/// #### Story time
///
/// Suppose, for instance, that you had this code:
///
/// ```dart
/// const Row(
///   children: <Widget>[
///     FlutterLogo(),
///     Text("Flutter's hot reload helps you quickly and easily experiment, build UIs, add features, and fix bug faster. Experience sub-second reload times, without losing state, on emulators, simulators, and hardware for iOS and Android."),
///     Icon(Icons.sentiment_very_satisfied),
///   ],
/// )
/// ```
///
/// The row first asks its first child, the [FlutterLogo], to lay out, at
/// whatever size the logo would like. The logo is friendly and happily decides
/// to be 24 pixels to a side. This leaves lots of room for the next child. The
/// row then asks that next child, the text, to lay out, at whatever size it
/// thinks is best.
///
/// At this point, the text, not knowing how wide is too wide, says "Ok, I will
/// be thiiiiiiiiiiiiiiiiiiiis wide.", and goes well beyond the space that the
/// row has available, not wrapping. The row responds, "That's not fair, now I
/// have no more room available for my other children!", and gets angry and
/// sprouts a yellow and black strip.
///
/// ![](https://flutter.github.io/assets-for-api-docs/assets/widgets/row_error.png)
///
/// The fix is to wrap the second child in an [Expanded] widget, which tells the
/// row that the child should be given the remaining room:
///
/// ```dart
/// const Row(
///   children: <Widget>[
///     FlutterLogo(),
///     Expanded(
///       child: Text("Flutter's hot reload helps you quickly and easily experiment, build UIs, add features, and fix bug faster. Experience sub-second reload times, without losing state, on emulators, simulators, and hardware for iOS and Android."),
///     ),
///     Icon(Icons.sentiment_very_satisfied),
///   ],
/// )
/// ```
///
/// Now, the row first asks the logo to lay out, and then asks the _icon_ to lay
/// out. The [Icon], like the logo, is happy to take on a reasonable size (also
/// 24 pixels, not coincidentally, since both [FlutterLogo] and [Icon] honor the
/// ambient [IconTheme]). This leaves some room left over, and now the row tells
/// the text exactly how wide to be: the exact width of the remaining space. The
/// text, now happy to comply to a reasonable request, wraps the text within
/// that width, and you end up with a paragraph split over several lines.
///
/// ![](https://flutter.github.io/assets-for-api-docs/assets/widgets/row_fixed.png)
///
/// The [textDirection] property controls the direction that children are rendered in.
/// [TextDirection.ltr] is the default [textDirection] of [Row] children, so the first
/// child is rendered at the `start` of the [Row], to the left, with subsequent children
/// following to the right. If you want to order children in the opposite
/// direction (right to left), then [textDirection] can be set to
/// [TextDirection.rtl]. This is shown in the example below
///
/// ```dart
/// const Row(
///   textDirection: TextDirection.rtl,
///   children: <Widget>[
///     FlutterLogo(),
///     Expanded(
///       child: Text("Flutter's hot reload helps you quickly and easily experiment, build UIs, add features, and fix bug faster. Experience sub-second reload times, without losing state, on emulators, simulators, and hardware for iOS and Android."),
///     ),
///     Icon(Icons.sentiment_very_satisfied),
///   ],
/// )
/// ```
///
/// ![](https://flutter.github.io/assets-for-api-docs/assets/widgets/row_textDirection.png)
///
/// ## Layout algorithm
///
/// _This section describes how a [Row] is rendered by the framework._
/// _See [BoxConstraints] for an introduction to box layout models._
///
/// Layout for a [Row] proceeds in six steps:
///
/// 1. Layout each child with a null or zero flex factor (e.g., those that are
///    not [Expanded]) with unbounded horizontal constraints and the incoming
///    vertical constraints. If the [crossAxisAlignment] is
///    [CrossAxisAlignment.stretch], instead use tight vertical constraints that
///    match the incoming max height.
/// 2. Divide the remaining horizontal space among the children with non-zero
///    flex factors (e.g., those that are [Expanded]) according to their flex
///    factor. For example, a child with a flex factor of 2.0 will receive twice
///    the amount of horizontal space as a child with a flex factor of 1.0.
/// 3. Layout each of the remaining children with the same vertical constraints
///    as in step 1, but instead of using unbounded horizontal constraints, use
///    horizontal constraints based on the amount of space allocated in step 2.
///    Children with [Flexible.fit] properties that are [FlexFit.tight] are
///    given tight constraints (i.e., forced to fill the allocated space), and
///    children with [Flexible.fit] properties that are [FlexFit.loose] are
///    given loose constraints (i.e., not forced to fill the allocated space).
/// 4. The height of the [Row] is the maximum height of the children (which will
///    always satisfy the incoming vertical constraints).
/// 5. The width of the [Row] is determined by the [mainAxisSize] property. If
///    the [mainAxisSize] property is [MainAxisSize.max], then the width of the
///    [Row] is the max width of the incoming constraints. If the [mainAxisSize]
///    property is [MainAxisSize.min], then the width of the [Row] is the sum
///    of widths of the children (subject to the incoming constraints).
/// 6. Determine the position for each child according to the
///    [mainAxisAlignment] and the [crossAxisAlignment]. For example, if the
///    [mainAxisAlignment] is [MainAxisAlignment.spaceBetween], any horizontal
///    space that has not been allocated to children is divided evenly and
///    placed between the children.
///
/// See also:
///
///  * [Column], for a vertical equivalent.
///  * [Flex], if you don't know in advance if you want a horizontal or vertical
///    arrangement.
///  * [Expanded], to indicate children that should take all the remaining room.
///  * [Flexible], to indicate children that should share the remaining room but
///    that may by sized smaller (leaving some remaining room unused).
///  * [Spacer], a widget that takes up space proportional to its flex value.
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
class Row extends Flex {
  /// Creates a horizontal array of children.
  ///
  /// If [crossAxisAlignment] is [CrossAxisAlignment.baseline], then
  /// [textBaseline] must not be null.
  ///
  /// The [textDirection] argument defaults to the ambient [Directionality], if
  /// any. If there is no ambient directionality, and a text direction is going
  /// to be necessary to determine the layout order (which is always the case
  /// unless the row has no children or only one child) or to disambiguate
  /// `start` or `end` values for the [mainAxisAlignment], the [textDirection]
  /// must not be null.
  const Row({
    super.key,
    super.mainAxisAlignment,
    super.mainAxisSize,
    super.crossAxisAlignment,
    super.textDirection,
    super.verticalDirection,
    super.textBaseline, // NO DEFAULT: we don't know what the text's baseline should be
    super.spacing,
    super.children,
  }) : super(direction: Axis.horizontal);
}

/// A widget that displays its children in a vertical array.
///
/// To cause a child to expand to fill the available vertical space, wrap the
/// child in an [Expanded] widget.
///
/// The [Column] widget does not scroll (and in general it is considered an error
/// to have more children in a [Column] than will fit in the available room). If
/// you have a line of widgets and want them to be able to scroll if there is
/// insufficient room, consider using a [ListView].
///
/// For a horizontal variant, see [Row].
///
/// If you only have one child, then consider using [Align] or [Center] to
/// position the child.
///
/// {@tool snippet}
///
/// This example uses a [Column] to arrange three widgets vertically, the last
/// being made to fill all the remaining space.
///
/// ![Using the Column in this way creates two short lines of text with a large Flutter underneath.](https://flutter.github.io/assets-for-api-docs/assets/widgets/column.png)
///
/// ```dart
/// const Column(
///   children: <Widget>[
///     Text('Deliver features faster'),
///     Text('Craft beautiful UIs'),
///     Expanded(
///       child: FittedBox(
///         child: FlutterLogo(),
///       ),
///     ),
///   ],
/// )
/// ```
/// {@end-tool}
/// {@tool snippet}
///
/// In the sample above, the text and the logo are centered on each line. In the
/// following example, the [crossAxisAlignment] is set to
/// [CrossAxisAlignment.start], so that the children are left-aligned. The
/// [mainAxisSize] is set to [MainAxisSize.min], so that the column shrinks to
/// fit the children.
///
/// ![](https://flutter.github.io/assets-for-api-docs/assets/widgets/column_properties.png)
///
/// ```dart
/// Column(
///   crossAxisAlignment: CrossAxisAlignment.start,
///   mainAxisSize: MainAxisSize.min,
///   children: <Widget>[
///     const Text('We move under cover and we move as one'),
///     const Text('Through the night, we have one shot to live another day'),
///     const Text('We cannot let a stray gunshot give us away'),
///     const Text('We will fight up close, seize the moment and stay in it'),
///     const Text("It's either that or meet the business end of a bayonet"),
///     const Text("The code word is 'Rochambeau,' dig me?"),
///     Text('Rochambeau!', style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0)),
///   ],
/// )
/// ```
/// {@end-tool}
///
/// ## Troubleshooting
///
/// ### When the incoming vertical constraints are unbounded
///
/// When a [Column] has one or more [Expanded] or [Flexible] children, and is
/// placed in another [Column], or in a [ListView], or in some other context
/// that does not provide a maximum height constraint for the [Column], you will
/// get an exception at runtime saying that there are children with non-zero
/// flex but the vertical constraints are unbounded.
///
/// The problem, as described in the details that accompany that exception, is
/// that using [Flexible] or [Expanded] means that the remaining space after
/// laying out all the other children must be shared equally, but if the
/// incoming vertical constraints are unbounded, there is infinite remaining
/// space.
///
/// The key to solving this problem is usually to determine why the [Column] is
/// receiving unbounded vertical constraints.
///
/// One common reason for this to happen is that the [Column] has been placed in
/// another [Column] (without using [Expanded] or [Flexible] around the inner
/// nested [Column]). When a [Column] lays out its non-flex children (those that
/// have neither [Expanded] or [Flexible] around them), it gives them unbounded
/// constraints so that they can determine their own dimensions (passing
/// unbounded constraints usually signals to the child that it should
/// shrink-wrap its contents). The solution in this case is typically to just
/// wrap the inner column in an [Expanded] to indicate that it should take the
/// remaining space of the outer column, rather than being allowed to take any
/// amount of room it desires.
///
/// Another reason for this message to be displayed is nesting a [Column] inside
/// a [ListView] or other vertical scrollable. In that scenario, there really is
/// infinite vertical space (the whole point of a vertical scrolling list is to
/// allow infinite space vertically). In such scenarios, it is usually worth
/// examining why the inner [Column] should have an [Expanded] or [Flexible]
/// child: what size should the inner children really be? The solution in this
/// case is typically to remove the [Expanded] or [Flexible] widgets from around
/// the inner children.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=jckqXR5CrPI}
///
/// For more discussion about constraints, see [BoxConstraints].
///
/// ### The yellow and black striped banner
///
/// When the contents of a [Column] exceed the amount of space available, the
/// [Column] overflows, and the contents are clipped. In debug mode, a yellow
/// and black striped bar is rendered at the overflowing edge to indicate the
/// problem, and a message is printed below the [Column] saying how much
/// overflow was detected.
///
/// The usual solution is to use a [ListView] rather than a [Column], to enable
/// the contents to scroll when vertical space is limited.
///
/// ## Layout algorithm
///
/// _This section describes how a [Column] is rendered by the framework._
/// _See [BoxConstraints] for an introduction to box layout models._
///
/// Layout for a [Column] proceeds in six steps:
///
/// 1. Layout each child with a null or zero flex factor (e.g., those that are
///    not [Expanded]) with unbounded vertical constraints and the incoming
///    horizontal constraints. If the [crossAxisAlignment] is
///    [CrossAxisAlignment.stretch], instead use tight horizontal constraints
///    that match the incoming max width.
/// 2. Divide the remaining vertical space among the children with non-zero
///    flex factors (e.g., those that are [Expanded]) according to their flex
///    factor. For example, a child with a flex factor of 2.0 will receive twice
///    the amount of vertical space as a child with a flex factor of 1.0.
/// 3. Layout each of the remaining children with the same horizontal
///    constraints as in step 1, but instead of using unbounded vertical
///    constraints, use vertical constraints based on the amount of space
///    allocated in step 2. Children with [Flexible.fit] properties that are
///    [FlexFit.tight] are given tight constraints (i.e., forced to fill the
///    allocated space), and children with [Flexible.fit] properties that are
///    [FlexFit.loose] are given loose constraints (i.e., not forced to fill the
///    allocated space).
/// 4. The width of the [Column] is the maximum width of the children (which
///    will always satisfy the incoming horizontal constraints).
/// 5. The height of the [Column] is determined by the [mainAxisSize] property.
///    If the [mainAxisSize] property is [MainAxisSize.max], then the height of
///    the [Column] is the max height of the incoming constraints. If the
///    [mainAxisSize] property is [MainAxisSize.min], then the height of the
///    [Column] is the sum of heights of the children (subject to the incoming
///    constraints).
/// 6. Determine the position for each child according to the
///    [mainAxisAlignment] and the [crossAxisAlignment]. For example, if the
///    [mainAxisAlignment] is [MainAxisAlignment.spaceBetween], any vertical
///    space that has not been allocated to children is divided evenly and
///    placed between the children.
///
/// See also:
///
///  * [Row], for a horizontal equivalent.
///  * [Flex], if you don't know in advance if you want a horizontal or vertical
///    arrangement.
///  * [Expanded], to indicate children that should take all the remaining room.
///  * [Flexible], to indicate children that should share the remaining room but
///    that may size smaller (leaving some remaining room unused).
///  * [SingleChildScrollView], whose documentation discusses some ways to
///    use a [Column] inside a scrolling container.
///  * [Spacer], a widget that takes up space proportional to its flex value.
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
class Column extends Flex {
  /// Creates a vertical array of children.
  ///
  /// If [crossAxisAlignment] is [CrossAxisAlignment.baseline], then
  /// [textBaseline] must not be null.
  ///
  /// The [textDirection] argument defaults to the ambient [Directionality], if
  /// any. If there is no ambient directionality, and a text direction is going
  /// to be necessary to disambiguate `start` or `end` values for the
  /// [crossAxisAlignment], the [textDirection] must not be null.
  const Column({
    super.key,
    super.mainAxisAlignment,
    super.mainAxisSize,
    super.crossAxisAlignment,
    super.textDirection,
    super.verticalDirection,
    super.textBaseline,
    super.spacing,
    super.children,
  }) : super(direction: Axis.vertical);
}

/// A widget that centers its child within itself.
///
/// This widget will be as big as possible if its dimensions are constrained and
/// [widthFactor] and [heightFactor] are null. If a dimension is unconstrained
/// and the corresponding size factor is null then the widget will match its
/// child's size in that dimension. If a size factor is non-null then the
/// corresponding dimension of this widget will be the product of the child's
/// dimension and the size factor. For example if widthFactor is 2.0 then
/// the width of this widget will always be twice its child's width.
///
/// See also:
///
///  * [Align], which lets you arbitrarily position a child within itself,
///    rather than just centering it.
///  * [Row], a widget that displays its children in a horizontal array.
///  * [Column], a widget that displays its children in a vertical array.
///  * [Container], a convenience widget that combines common painting,
///    positioning, and sizing widgets.
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
class Center extends Align {
  /// Creates a widget that centers its child.
  const Center({super.key, super.widthFactor, super.heightFactor, super.child});
}

/// A widget that sizes its child to a fraction of the total available space.
/// For more details about the layout algorithm, see
/// [RenderFractionallySizedOverflowBox].
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=PEsY654EGZ0}
///
/// {@tool dartpad}
/// This sample shows a [FractionallySizedBox] whose one child is 50% of
/// the box's size per the width and height factor parameters, and centered
/// within that box by the alignment parameter.
///
/// ** See code in examples/api/lib/widgets/basic/fractionally_sized_box.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [Align], which sizes itself based on its child's size and positions
///    the child according to an [Alignment] value.
///  * [OverflowBox], a widget that imposes different constraints on its child
///    than it gets from its parent, possibly allowing the child to overflow the
///    parent.
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
class FractionallySizedBox extends widgets.FractionallySizedBox {
  /// Creates a widget that sizes its child to a fraction of the total available space.
  ///
  /// If non-null, the [widthFactor] and [heightFactor] arguments must be
  /// non-negative.
  const FractionallySizedBox({
    super.key,
    super.alignment,
    super.widthFactor,
    super.heightFactor,
    super.child,
  });

  @override
  RenderFractionallySizedOverflowBox createRenderObject(BuildContext context) {
    return RenderFractionallySizedOverflowBox(
      pixelSnap: PixelSnap.of(context),
      alignment: alignment,
      widthFactor: widthFactor,
      heightFactor: heightFactor,
      textDirection: Directionality.maybeOf(context),
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    RenderFractionallySizedOverflowBox renderObject,
  ) {
    renderObject
      ..pixelSnap = PixelSnap.of(context)
      ..alignment = alignment
      ..widthFactor = widthFactor
      ..heightFactor = heightFactor
      ..textDirection = Directionality.maybeOf(context);
  }
}

/// A run of text with a single style.
///
/// The [Text] widget displays a string of text with single style. The string
/// might break across multiple lines or might all be displayed on the same line
/// depending on the layout constraints.
///
/// The [style] argument is optional. When omitted, the text will use the style
/// from the closest enclosing [DefaultTextStyle]. If the given style's
/// [TextStyle.inherit] property is true (the default), the given style will
/// be merged with the closest enclosing [DefaultTextStyle]. This merging
/// behavior is useful, for example, to make the text bold while using the
/// default font family and size.
///
/// {@tool snippet}
///
/// This example shows how to display text using the [Text] widget with the
/// [overflow] set to [TextOverflow.ellipsis].
///
/// ![If the text overflows, the Text widget displays an ellipsis to trim the overflowing text](https://flutter.github.io/assets-for-api-docs/assets/widgets/text_ellipsis.png)
///
/// ```dart
/// Container(
///   width: 100,
///   decoration: BoxDecoration(border: Border.all()),
///   child: const Text(
///     'Hello, how are you?',
///     overflow: TextOverflow.ellipsis,
///   ),
/// )
/// ```
/// {@end-tool}
///
/// {@tool snippet}
///
/// Setting [maxLines] to `1` is not equivalent to disabling soft wrapping with
/// [softWrap]. This is apparent when using [TextOverflow.fade] as the following
/// examples show.
///
/// ![If a second line overflows the Text widget displays a horizontal fade](https://flutter.github.io/assets-for-api-docs/assets/widgets/text_fade_max_lines.png)
///
/// ```dart
/// const Text(
///   'Hello, how are you?',
///   overflow: TextOverflow.fade,
///   maxLines: 1,
/// )
/// ```
///
/// Here soft wrapping is enabled and the [Text] widget tries to wrap the words
/// "how are you?" to a second line. This is prevented by the [maxLines] value
/// of `1`. The result is that a second line overflows and the fade appears in a
/// horizontal direction at the bottom.
///
/// ![If a single line overflows the Text widget displays a horizontal fade](https://flutter.github.io/assets-for-api-docs/assets/widgets/text_fade_soft_wrap.png)
///
/// ```dart
/// const Text(
///   'Hello, how are you?',
///   overflow: TextOverflow.fade,
///   softWrap: false,
/// )
/// ```
///
/// Here soft wrapping is disabled with `softWrap: false` and the [Text] widget
/// attempts to display its text in a single unbroken line. The result is that
/// the single line overflows and the fade appears in a vertical direction at
/// the right.
///
/// {@end-tool}
///
/// Using the [Text.rich] constructor, the [Text] widget can
/// display a paragraph with differently styled [TextSpan]s. The sample
/// that follows displays "Hello beautiful world" with different styles
/// for each word.
///
/// {@tool snippet}
///
/// ![The word "Hello" is shown with the default text styles. The word "beautiful" is italicized. The word "world" is bold.](https://flutter.github.io/assets-for-api-docs/assets/widgets/text_rich.png)
///
/// ```dart
/// const Text.rich(
///   TextSpan(
///     text: 'Hello', // default text style
///     children: <TextSpan>[
///       TextSpan(text: ' beautiful ', style: TextStyle(fontStyle: FontStyle.italic)),
///       TextSpan(text: 'world', style: TextStyle(fontWeight: FontWeight.bold)),
///     ],
///   ),
/// )
/// ```
/// {@end-tool}
///
/// ## Interactivity
///
/// To make [Text] react to touch events, wrap it in a [GestureDetector] widget
/// with a [GestureDetector.onTap] handler.
///
/// In a Material Design application, consider using a [TextButton] instead, or
/// if that isn't appropriate, at least using an [InkWell] instead of
/// [GestureDetector].
///
/// To make sections of the text interactive, use [RichText] and specify a
/// [TapGestureRecognizer] as the [TextSpan.recognizer] of the relevant part of
/// the text.
///
/// ## Selection
///
/// [Text] is not selectable by default. To make a [Text] selectable, one can
/// wrap a subtree with a [SelectionArea] widget. To exclude a part of a subtree
/// under [SelectionArea] from selection, one can also wrap that part of the
/// subtree with [SelectionContainer.disabled].
///
/// {@tool dartpad}
/// This sample demonstrates how to disable selection for a Text under a
/// SelectionArea.
///
/// ** See code in examples/api/lib/widgets/selection_container/selection_container_disabled.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [RichText], which gives you more control over the text styles.
///  * [DefaultTextStyle], which sets default styles for [Text] widgets.
///  * [SelectableRegion], which provides an overview of the selection system.
class Text extends widgets.Text {
  /// Creates a text widget.
  ///
  /// If the [style] argument is null, the text will use the style from the
  /// closest enclosing [DefaultTextStyle].
  ///
  /// The [overflow] property's behavior is affected by the [softWrap] argument.
  /// If the [softWrap] is true or null, the glyph causing overflow, and those
  /// that follow, will not be rendered. Otherwise, it will be shown with the
  /// given overflow option.
  const Text(
    super.data, {
    super.key,
    super.style,
    super.strutStyle,
    super.textAlign,
    super.textDirection,
    super.locale,
    super.softWrap,
    super.overflow,
    @Deprecated(
      'Use textScaler instead. '
      'Use of textScaleFactor was deprecated in preparation for the upcoming nonlinear text scaling support. '
      'This feature was deprecated after v3.12.0-2.0.pre.',
    )
    super.textScaleFactor,
    super.textScaler,
    super.maxLines,
    super.semanticsLabel,
    super.semanticsIdentifier,
    super.textWidthBasis,
    super.textHeightBehavior,
    super.hyphens,
    super.selectionColor,
  });

  /// Creates a text widget with a [InlineSpan].
  ///
  /// The following subclasses of [InlineSpan] may be used to build rich text:
  ///
  /// * [TextSpan]s define text and children [InlineSpan]s.
  /// * [WidgetSpan]s define embedded inline widgets.
  ///
  /// See [RichText] which provides a lower-level way to draw text.
  const Text.rich(
    super.textSpan, {
    super.key,
    super.style,
    super.strutStyle,
    super.textAlign,
    super.textDirection,
    super.locale,
    super.softWrap,
    super.overflow,
    @Deprecated(
      'Use textScaler instead. '
      'Use of textScaleFactor was deprecated in preparation for the upcoming nonlinear text scaling support. '
      'This feature was deprecated after v3.12.0-2.0.pre.',
    )
    super.textScaleFactor,
    super.textScaler,
    super.maxLines,
    super.semanticsLabel,
    super.semanticsIdentifier,
    super.textWidthBasis,
    super.textHeightBehavior,
    super.hyphens,
    super.selectionColor,
  }) : super.rich();

  @override
  Widget build(BuildContext context) {
    final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
    TextStyle? effectiveTextStyle = style;
    if (style == null || style!.inherit) {
      effectiveTextStyle = defaultTextStyle.style.merge(style);
    }
    if (MediaQuery.boldTextOf(context)) {
      effectiveTextStyle = effectiveTextStyle!.merge(
        const TextStyle(fontWeight: FontWeight.bold),
      );
    }
    // TODO(Renzo-Olivares): Investigate ways the framework can automatically
    // apply MediaQueryData.paragraphSpacingOverride to its own text components.
    // See: https://github.com/flutter/flutter/issues/177953 and https://github.com/flutter/flutter/issues/177408.
    final double? lineHeightScaleFactor =
        MediaQuery.maybeLineHeightScaleFactorOverrideOf(context);
    final double? letterSpacing = MediaQuery.maybeLetterSpacingOverrideOf(
      context,
    );
    final double? wordSpacing = MediaQuery.maybeWordSpacingOverrideOf(context);
    final TextSpan effectiveTextSpan =
        _OverridingTextStyleTextSpanUtils.applyTextSpacingOverrides(
          lineHeightScaleFactor: lineHeightScaleFactor,
          letterSpacing: letterSpacing,
          wordSpacing: wordSpacing,
          textSpan: TextSpan(
            style: effectiveTextStyle,
            text: data,
            locale: locale,
            children: textSpan != null ? <InlineSpan>[textSpan!] : null,
          ),
        );
    final StrutStyle? effectiveStrutStyle = strutStyle?.merge(
      StrutStyle(height: lineHeightScaleFactor),
    );
    final SelectionRegistrar? registrar = SelectionContainer.maybeOf(context);
    final TextScaler textScaler = switch ((this.textScaler, textScaleFactor)) {
      (final TextScaler textScaler, _) => textScaler,
      // For unmigrated apps, fall back to textScaleFactor.
      (null, final double textScaleFactor) => TextScaler.linear(
        textScaleFactor,
      ),
      (null, null) => MediaQuery.textScalerOf(context),
    };
    late Widget result;
    if (registrar != null) {
      result = MouseRegion(
        cursor:
            DefaultSelectionStyle.of(context).mouseCursor ??
            SystemMouseCursors.text,
        child: _SelectableTextContainer(
          textAlign: textAlign ?? defaultTextStyle.textAlign ?? TextAlign.start,
          textDirection: textDirection, // RichText uses Directionality.of to obtain a default if this is null.
          locale: locale, // RichText uses Localizations.localeOf to obtain a default if this is null
          softWrap: softWrap ?? defaultTextStyle.softWrap,
          overflow:
              overflow ??
              effectiveTextStyle?.overflow ??
              defaultTextStyle.overflow,
          textScaler: textScaler,
          maxLines: maxLines ?? defaultTextStyle.maxLines,
          strutStyle: effectiveStrutStyle,
          textWidthBasis: textWidthBasis ?? defaultTextStyle.textWidthBasis,
          textHeightBehavior:
              textHeightBehavior ??
              defaultTextStyle.textHeightBehavior ??
              DefaultTextHeightBehavior.maybeOf(context),
          hyphens: hyphens ?? ui.Hyphens.manual,
          selectionColor:
              selectionColor ??
              DefaultSelectionStyle.of(context).selectionColor ??
              DefaultSelectionStyle.defaultColor,
          text: effectiveTextSpan,
        ),
      );
    } else {
      result = RichText(
        textAlign: textAlign ?? defaultTextStyle.textAlign ?? TextAlign.start,
        textDirection: textDirection, // RichText uses Directionality.of to obtain a default if this is null.
        locale: locale, // RichText uses Localizations.localeOf to obtain a default if this is null
        softWrap: softWrap ?? defaultTextStyle.softWrap,
        overflow:
            overflow ??
            effectiveTextStyle?.overflow ??
            defaultTextStyle.overflow,
        textScaler: textScaler,
        maxLines: maxLines ?? defaultTextStyle.maxLines,
        strutStyle: effectiveStrutStyle,
        textWidthBasis: textWidthBasis ?? defaultTextStyle.textWidthBasis,
        textHeightBehavior:
            textHeightBehavior ??
            defaultTextStyle.textHeightBehavior ??
            DefaultTextHeightBehavior.maybeOf(context),
        hyphens: hyphens ?? ui.Hyphens.manual,
        selectionColor:
            selectionColor ??
            DefaultSelectionStyle.of(context).selectionColor ??
            DefaultSelectionStyle.defaultColor,
        text: effectiveTextSpan,
      );
    }
    if (semanticsLabel != null || semanticsIdentifier != null) {
      result = Semantics(
        textDirection: textDirection,
        label: semanticsLabel,
        identifier: semanticsIdentifier,
        child: ExcludeSemantics(
          excluding: semanticsLabel != null,
          child: result,
        ),
      );
    }
    return result;
  }
}

/// A paragraph of rich text.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=rykDVh-QFfw}
///
/// The [RichText] widget displays text that uses multiple different styles. The
/// text to display is described using a tree of [TextSpan] objects, each of
/// which has an associated style that is used for that subtree. The text might
/// break across multiple lines or might all be displayed on the same line
/// depending on the layout constraints.
///
/// Text displayed in a [RichText] widget must be explicitly styled. When
/// picking which style to use, consider using [DefaultTextStyle.of] the current
/// [BuildContext] to provide defaults. [MediaQuery.maybeBoldTextOf],
/// [MediaQuery.maybeLineHeightScaleFactorOverrideOf],
/// [MediaQuery.maybeLetterSpacingOverrideOf], [MediaQuery.maybeWordSpacingOverrideOf],
/// and [MediaQuery.maybeParagraphSpacingOverrideOf] can also be used to ensure the styling
/// for your text is accessible. For more details on how to style text in
/// a [RichText] widget, see the documentation for [TextStyle].
///
/// Consider using the [Text] widget to integrate with the [DefaultTextStyle]
/// automatically. When all the text uses the same style, the default constructor
/// is less verbose. The [Text.rich] constructor allows you to style multiple
/// spans with the default text style while still allowing specified styles per
/// span.
///
/// {@tool snippet}
///
/// This sample demonstrates how to mix and match text with different text
/// styles using the [RichText] Widget. It displays the text "Hello bold world,"
/// emphasizing the word "bold" using a bold font weight.
///
/// ![](https://flutter.github.io/assets-for-api-docs/assets/widgets/rich_text.png)
///
/// ```dart
/// RichText(
///   text: TextSpan(
///     text: 'Hello ',
///     style: DefaultTextStyle.of(context).style,
///     children: const <TextSpan>[
///       TextSpan(text: 'bold', style: TextStyle(fontWeight: FontWeight.bold)),
///       TextSpan(text: ' world!'),
///     ],
///   ),
/// )
/// ```
/// {@end-tool}
///
/// ## Selections
///
/// To make this [RichText] Selectable, the [RichText] needs to be in the
/// subtree of a [SelectionArea] or [SelectableRegion] and a
/// [SelectionRegistrar] needs to be assigned to the
/// [RichText.selectionRegistrar]. One can use
/// [SelectionContainer.maybeOf] to get the [SelectionRegistrar] from a context
/// that is below the [SelectionArea] or [SelectableRegion] in the widget tree.
/// This enables users to select the text in [RichText]s with mice or touch
/// events.
///
/// If the same build method creates both the [SelectionArea] and the
/// [RichText], use a [Builder] so that [SelectionContainer.maybeOf] is called
/// with a [BuildContext] below the [SelectionArea] in the widget tree.
///
/// The [selectionColor] also needs to be set if the selection is enabled to
/// draw the selection highlights.
///
/// {@tool snippet}
///
/// This sample demonstrates how to assign a [SelectionRegistrar] for RichTexts
/// in the SelectionArea subtree.
///
/// ![](https://flutter.github.io/assets-for-api-docs/assets/widgets/rich_text.png)
///
/// ```dart
/// SelectionArea(
///   child: Builder(
///     builder: (BuildContext context) {
///       return RichText(
///         text: const TextSpan(text: 'Hello'),
///         selectionRegistrar: SelectionContainer.maybeOf(context),
///         selectionColor: const Color(0xAF6694e8),
///       );
///     },
///   ),
/// )
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [TextStyle], which discusses how to style text.
///  * [TextSpan], which is used to describe the text in a paragraph.
///  * [Text], which automatically applies the ambient styles described by a
///    [DefaultTextStyle] to a single string.
///  * [Text.rich], a const text widget that provides similar functionality
///    as [RichText]. [Text.rich] will inherit [TextStyle] from [DefaultTextStyle].
///  * [SelectableRegion], which provides an overview of the selection system.
class RichText extends widgets.RichText {
  /// Creates a paragraph of rich text.
  ///
  /// The [maxLines] property may be null (and indeed defaults to null), but if
  /// it is not null, it must be greater than zero.
  ///
  /// The [textDirection], if null, defaults to the ambient [Directionality],
  /// which in that case must not be null.
  RichText({
    super.key,
    required super.text,
    super.textAlign,
    super.textDirection,
    super.softWrap,
    super.overflow,
    @Deprecated(
      'Use textScaler instead. '
      'Use of textScaleFactor was deprecated in preparation for the upcoming nonlinear text scaling support. '
      'This feature was deprecated after v3.12.0-2.0.pre.',
    )
    super.textScaleFactor,
    super.textScaler,
    super.maxLines,
    super.locale,
    super.strutStyle,
    super.textWidthBasis,
    super.textHeightBehavior,
    super.hyphens,
    super.selectionRegistrar,
    super.selectionColor,
  });

  double _getDevicePixelRatio(BuildContext context) =>
      MediaQuery.maybeDevicePixelRatioOf(context) ??
      View.maybeOf(context)?.devicePixelRatio ??
      1.0;

  @override
  RenderParagraph createRenderObject(BuildContext context) {
    assert(textDirection != null || debugCheckHasDirectionality(context));
    return RenderParagraph(
      pixelSnap: PixelSnap.of(context),
      text,
      textAlign: textAlign,
      textDirection: textDirection ?? Directionality.of(context),
      softWrap: softWrap,
      overflow: overflow,
      textScaler: textScaler,
      maxLines: maxLines,
      strutStyle: strutStyle,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
      hyphens: hyphens,
      locale: locale ?? Localizations.maybeLocaleOf(context),
      registrar: selectionRegistrar,
      selectionColor: selectionColor,
      devicePixelRatio: _getDevicePixelRatio(context),
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderParagraph renderObject) {
    assert(textDirection != null || debugCheckHasDirectionality(context));
    renderObject
      ..pixelSnap = PixelSnap.of(context)
      ..text = text
      ..textAlign = textAlign
      ..textDirection = textDirection ?? Directionality.of(context)
      ..softWrap = softWrap
      ..overflow = overflow
      ..textScaler = textScaler
      ..maxLines = maxLines
      ..strutStyle = strutStyle
      ..textWidthBasis = textWidthBasis
      ..textHeightBehavior = textHeightBehavior
      ..hyphens = hyphens
      ..locale = locale ?? Localizations.maybeLocaleOf(context)
      ..registrar = selectionRegistrar
      ..selectionColor = selectionColor
      ..devicePixelRatio = _getDevicePixelRatio(context);
  }
}

/// Scales and positions its child within itself according to [fit].
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=T4Uehk3_wlY}
///
/// {@tool dartpad}
/// In this example, the [Placeholder] is stretched to fill the entire
/// [Container]. Try changing the fit types to see the effect on the layout of
/// the [Placeholder].
///
/// ** See code in examples/api/lib/widgets/basic/fitted_box.0.dart **
/// {@end-tool}
///
/// See also:
///
/// * [Transform], which applies an arbitrary transform to its child widget at
///   paint time.
/// * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
class FittedBox extends widgets.FittedBox {
  /// Creates a widget that scales and positions its child within itself according to [fit].
  const FittedBox({
    super.key,
    super.fit,
    super.alignment,
    super.clipBehavior,
    super.child,
  });

  @override
  RenderFittedBox createRenderObject(BuildContext context) {
    return RenderFittedBox(
      pixelSnap: PixelSnap.of(context),
      fit: fit,
      alignment: alignment,
      textDirection: Directionality.maybeOf(context),
      clipBehavior: clipBehavior,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderFittedBox renderObject) {
    renderObject
      ..pixelSnap = PixelSnap.of(context)
      ..fit = fit
      ..alignment = alignment
      ..textDirection = Directionality.maybeOf(context)
      ..clipBehavior = clipBehavior;
  }
}

/// A widget that displays an image.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=7oIAs-0G4mw}
///
/// Several constructors are provided for the various ways that an image can be
/// specified:
///
///  * [Image.new], for obtaining an image from an [ImageProvider].
///  * [Image.asset], for obtaining an image from an [AssetBundle]
///    using a key.
///  * [Image.network], for obtaining an image from a URL.
///  * [Image.file], for obtaining an image from a [File].
///  * [Image.memory], for obtaining an image from a [Uint8List].
///
/// The following image formats are supported: {@macro dart.ui.imageFormats}
///
/// To automatically perform pixel-density-aware asset resolution, specify the
/// image using an [AssetImage] and make sure that a [MaterialApp], [WidgetsApp],
/// or [MediaQuery] widget exists above the [Image] widget in the widget tree.
///
/// The image is painted using [paintImage], which describes the meanings of the
/// various fields on this class in more detail.
///
/// {@tool snippet}
/// The default constructor can be used with any [ImageProvider], such as a
/// [NetworkImage], to display an image from the internet.
///
/// ![An image of an owl displayed by the image widget](https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg)
///
/// ```dart
/// const Image(
///   image: NetworkImage('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
/// )
/// ```
/// {@end-tool}
///
/// {@tool snippet}
/// The [Image] Widget also provides several constructors to display different
/// types of images for convenience. In this example, use the [Image.network]
/// constructor to display an image from the internet.
///
/// ![An image of an owl displayed by the image widget using the shortcut constructor](https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg)
///
/// ```dart
/// Image.network('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg')
/// ```
/// {@end-tool}
///
/// Multiframe images, such as animated GIFs, are paused when [TickerMode] is
/// disabled just like any other animation. They also paused when animations are
/// disabled via [MediaQueryData.disableAnimations], such as for accessibility
/// purposes. If the animation is paused when the image first loads, the first
/// frame will be displayed and then animation will stop.
///
/// {@tool snippet}
//// An example of pausing a multiframe image using [TickerMode].
///
/// ```dart
/// TickerMode(
///   enabled: !isPaused,
///   child: Image(image: myAnimatedGif),
/// ),
/// ```
/// {@end-tool}
///
/// ## Memory usage
///
/// The image is stored in memory in uncompressed form (so that it can be
/// rendered). Large images will use a lot of memory: a 4K image (3840×2160)
/// will use over 30MB of RAM (assuming 32 bits per pixel).
///
/// This problem is exacerbated by the images being cached in the [ImageCache],
/// so large images can use memory for even longer than they are displayed.
///
/// The [Image.asset], [Image.network], [Image.file], and [Image.memory]
/// constructors allow a custom decode size to be specified through `cacheWidth`
/// and `cacheHeight` parameters. The engine will then decode and store the
/// image at the specified size, instead of the image's natural size.
///
/// This can significantly reduce the memory usage. For example, a 4K image that
/// will be rendered at only 384×216 pixels (one-tenth the horizontal and
/// vertical dimensions) would only use 330KB if those dimensions are specified
/// using the `cacheWidth` and `cacheHeight` parameters, a 100-fold reduction in
/// memory usage.
///
/// ## Custom image providers
///
/// {@tool sample}
/// In this example, a variant of [NetworkImage] is created that passes all the
/// [ImageConfiguration] information (locale, platform, size, etc) to the server
/// using query arguments in the image URL.
///
/// ** See code in examples/api/lib/painting/image_provider/image_provider.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [Icon], which shows an image from a font.
///  * [Ink.image], which is the preferred way to show an image in a
///    material application (especially if the image is in a [Material] and will
///    have an [InkWell] on top of it).
///  * [Image](dart-ui/Image-class.html), the class in the [dart:ui] library.
///  * Cookbook: [Display images from the internet](https://docs.flutter.dev/cookbook/images/network-image)
///  * Cookbook: [Fade in images with a placeholder](https://docs.flutter.dev/cookbook/images/fading-in-images)
class Image extends widgets.Image {
  /// Creates a widget that displays an image.
  ///
  /// To show an image from the network or from an asset bundle, consider using
  /// [Image.network] and [Image.asset] respectively.
  ///
  /// Either the [width] and [height] arguments should be specified, or the
  /// widget should be placed in a context that sets tight layout constraints.
  /// Otherwise, the image dimensions will change as the image is loaded, which
  /// will result in ugly layout changes.
  ///
  /// {@template flutter.widgets.image.filterQualityParameter}
  /// Use [filterQuality] to specify the rendering quality of the image.
  /// {@endtemplate}
  ///
  /// If [excludeFromSemantics] is true, then [semanticLabel] will be ignored.
  const Image({
    super.key,
    required super.image,
    super.frameBuilder,
    super.loadingBuilder,
    super.errorBuilder,
    super.semanticLabel,
    super.excludeFromSemantics,
    super.width,
    super.height,
    super.color,
    super.opacity,
    super.colorBlendMode,
    super.fit,
    super.alignment,
    super.repeat,
    super.centerSlice,
    super.matchTextDirection,
    super.gaplessPlayback,
    super.isAntiAlias,
    super.filterQuality,
  });

  /// Creates a widget that displays an [ImageStream] obtained from the network.
  ///
  /// Either the [width] and [height] arguments should be specified, or the
  /// widget should be placed in a context that sets tight layout constraints.
  /// Otherwise, the image dimensions will change as the image is loaded, which
  /// will result in ugly layout changes.
  ///
  /// The `scale` argument specifies the linear scale factor for drawing this
  /// image at its intended size and applies to both the width and the height.
  /// {@macro flutter.painting.imageInfo.scale}
  ///
  /// All network images are cached regardless of HTTP headers.
  ///
  /// An optional [headers] argument can be used to send custom HTTP headers
  /// with the image request.
  ///
  /// {@macro flutter.widgets.image.filterQualityParameter}
  ///
  /// If [excludeFromSemantics] is true, then [semanticLabel] will be ignored.
  ///
  /// If `cacheWidth` or `cacheHeight` are provided, they indicate to the
  /// engine that the image should be decoded at the specified size. The image
  /// will be rendered to the constraints of the layout or [width] and [height]
  /// regardless of these parameters. These parameters are primarily intended
  /// to reduce the memory usage of [ImageCache].
  ///
  /// If [useLogicalCacheSize] is true, [cacheWidth] and [cacheHeight] are
  /// interpreted as logical pixels instead of physical pixels. Set this to
  /// true when [cacheWidth] and [cacheHeight] describe the image's on-screen
  /// size in logical pixels.
  ///
  /// In the case where the network image is on the Web platform, the [cacheWidth]
  /// and [cacheHeight] parameters are ignored as the web engine delegates
  /// image decoding to the web which does not support custom decode sizes.
  ///
  /// ### Same-origin policy on Web
  ///
  /// Due to browser restriction on Cross-Origin Resource Sharing (CORS),
  /// Flutter on the Web platform can not fetch images from other origins
  /// (domain, scheme, or port) than the origin that hosts the app, unless the
  /// image hosting origin explicitly allows so. CORS errors can be resolved
  /// by configuring the image hosting server. More information can be
  /// found at Mozilla's introduction on
  /// [same-origin policy](https://developer.mozilla.org/en-US/docs/Web/Security/Same-origin_policy)
  /// and
  /// [CORS errors](https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS/Errors).
  ///
  /// If it's not possible to configure the host, such as when images are hosted
  /// on a CDN or from arbitrary URLs, the app can set the
  /// `webHtmlElementStrategy` parameter of [Image.network] to display the image
  /// in an HTML element, which bypasses the same-origin policy.
  ///
  /// The HTML element is placed in a platform view, and therefore has the
  /// following drawbacks:
  ///
  ///  * Suboptimal performance.
  ///  * Can't be captured by screenshot widgets.
  ///  * The `headers` argument must be null or empty.
  ///  * Some image options are ignored, including [opacity], [colorBlendMode],
  ///    [repeat], filtering, and blurring.
  ///
  /// By default, this feature is turned off ([WebHtmlElementStrategy.never]).
  ///
  /// ### Android Permissions
  ///
  /// Images fetched from the network require the internet permission.
  /// Ensure that all AndroidMainifest.xml variants (especially release) have the internet permission.
  /// See https://docs.flutter.dev/data-and-backend/networking for more information.
  Image.network(
    super.src, {
    super.key,
    super.scale,
    super.frameBuilder,
    super.loadingBuilder,
    super.errorBuilder,
    super.semanticLabel,
    super.excludeFromSemantics,
    super.width,
    super.height,
    super.color,
    super.opacity,
    super.colorBlendMode,
    super.fit,
    super.alignment,
    super.repeat,
    super.centerSlice,
    super.matchTextDirection,
    super.gaplessPlayback,
    super.filterQuality,
    super.isAntiAlias,
    super.headers,
    super.cacheWidth,
    super.cacheHeight,
    super.useLogicalCacheSize,
    super.webHtmlElementStrategy,
  }) : super.network();

  /// Creates a widget that displays an [ImageStream] obtained from a [File].
  ///
  /// The `scale` argument specifies the linear scale factor for drawing this
  /// image at its intended size and applies to both the width and the height.
  /// {@macro flutter.painting.imageInfo.scale}
  ///
  /// Either the [width] and [height] arguments should be specified, or the
  /// widget should be placed in a context that sets tight layout constraints.
  /// Otherwise, the image dimensions will change as the image is loaded, which
  /// will result in ugly layout changes.
  ///
  /// On Android, this may require the
  /// `android.permission.READ_EXTERNAL_STORAGE` permission.
  ///
  /// {@macro flutter.widgets.image.filterQualityParameter}
  ///
  /// If [excludeFromSemantics] is true, then [semanticLabel] will be ignored.
  ///
  /// If `cacheWidth` or `cacheHeight` are provided, they indicate to the
  /// engine that the image must be decoded at the specified size. The image
  /// will be rendered to the constraints of the layout or [width] and [height]
  /// regardless of these parameters. These parameters are primarily intended
  /// to reduce the memory usage of [ImageCache].
  ///
  /// If [useLogicalCacheSize] is true, [cacheWidth] and [cacheHeight] are
  /// interpreted as logical pixels instead of physical pixels. Set this to
  /// true when [cacheWidth] and [cacheHeight] describe the image's on-screen
  /// size in logical pixels.
  ///
  /// Loading an image from a file creates an in memory copy of the file,
  /// which is retained in the [ImageCache]. The underlying file is not
  /// monitored for changes. If it does change, the application should evict
  /// the entry from the [ImageCache].
  ///
  /// See also:
  ///
  ///  * [FileImage] provider for evicting the underlying file easily.
  Image.file(
    super.file, {
    super.key,
    super.scale,
    super.frameBuilder,
    super.errorBuilder,
    super.semanticLabel,
    super.excludeFromSemantics,
    super.width,
    super.height,
    super.color,
    super.opacity,
    super.colorBlendMode,
    super.fit,
    super.alignment,
    super.repeat,
    super.centerSlice,
    super.matchTextDirection,
    super.gaplessPlayback,
    super.isAntiAlias,
    super.filterQuality,
    super.cacheWidth,
    super.cacheHeight,
    super.useLogicalCacheSize,
  }) : super.file();

  /// Creates a widget that displays an [ImageStream] obtained from an asset
  /// bundle. The key for the image is given by the `name` argument.
  ///
  /// The `package` argument must be non-null when displaying an image from a
  /// package and null otherwise. See the `Assets in packages` section for
  /// details.
  ///
  /// If the `bundle` argument is omitted or null, then the
  /// [DefaultAssetBundle] will be used.
  ///
  /// The `scale` argument specifies the linear scale factor for drawing this
  /// image at its intended size and applies to both the width and the height.
  /// {@macro flutter.painting.imageInfo.scale}
  ///
  /// By default, the pixel-density-aware asset resolution will be attempted. In
  /// addition:
  ///
  /// * If the `scale` argument is provided and is not null, then the exact
  /// asset specified will be used. To display an image variant with a specific
  /// density, the exact path must be provided (e.g. `images/2x/cat.png`).
  ///
  /// If [excludeFromSemantics] is true, then [semanticLabel] will be ignored.
  ///
  /// If `cacheWidth` or `cacheHeight` are provided, they indicate to the
  /// engine that the image must be decoded at the specified size. The image
  /// will be rendered to the constraints of the layout or [width] and [height]
  /// regardless of these parameters. These parameters are primarily intended
  /// to reduce the memory usage of [ImageCache].
  ///
  /// If [useLogicalCacheSize] is true, [cacheWidth] and [cacheHeight] are
  /// interpreted as logical pixels instead of physical pixels. Set this to
  /// true when [cacheWidth] and [cacheHeight] describe the image's on-screen
  /// size in logical pixels.
  ///
  /// Either the [width] and [height] arguments should be specified, or the
  /// widget should be placed in a context that sets tight layout constraints.
  /// Otherwise, the image dimensions will change as the image is loaded, which
  /// will result in ugly layout changes.
  ///
  /// {@macro flutter.widgets.image.filterQualityParameter}
  ///
  /// {@tool snippet}
  ///
  /// Suppose that the project's `pubspec.yaml` file contains the following:
  ///
  /// ```yaml
  /// flutter:
  ///   assets:
  ///     - images/cat.png
  ///     - images/2x/cat.png
  ///     - images/3.5x/cat.png
  /// ```
  /// {@end-tool}
  ///
  /// On a screen with a device pixel ratio of 2.0, the following widget would
  /// render the `images/2x/cat.png` file:
  ///
  /// ```dart
  /// Image.asset('images/cat.png')
  /// ```
  ///
  /// This corresponds to the file that is in the project's `images/2x/`
  /// directory with the name `cat.png` (the paths are relative to the
  /// `pubspec.yaml` file).
  ///
  /// On a device with a 4.0 device pixel ratio, the `images/3.5x/cat.png` asset
  /// would be used. On a device with a 1.0 device pixel ratio, the
  /// `images/cat.png` resource would be used.
  ///
  /// The `images/cat.png` image can be omitted from disk (though it must still
  /// be present in the manifest). If it is omitted, then on a device with a 1.0
  /// device pixel ratio, the `images/2x/cat.png` image would be used instead.
  ///
  ///
  /// ## Assets in packages
  ///
  /// To create the widget with an asset from a package, the [package] argument
  /// must be provided. For instance, suppose a package called `my_icons` has
  /// `icons/heart.png` .
  ///
  /// {@tool snippet}
  /// Then to display the image, use:
  ///
  /// ```dart
  /// Image.asset('icons/heart.png', package: 'my_icons')
  /// ```
  /// {@end-tool}
  ///
  /// Assets used by the package itself should also be displayed using the
  /// [package] argument as above.
  ///
  /// If the desired asset is specified in the `pubspec.yaml` of the package, it
  /// is bundled automatically with the app. In particular, assets used by the
  /// package itself must be specified in its `pubspec.yaml`.
  ///
  /// A package can also choose to have assets in its 'lib/' folder that are not
  /// specified in its `pubspec.yaml`. In this case for those images to be
  /// bundled, the app has to specify which ones to include. For instance a
  /// package named `fancy_backgrounds` could have:
  ///
  ///     lib/backgrounds/background1.png
  ///     lib/backgrounds/background2.png
  ///     lib/backgrounds/background3.png
  ///
  /// To include, say the first image, the `pubspec.yaml` of the app should
  /// specify it in the assets section:
  ///
  /// ```yaml
  ///   assets:
  ///     - packages/fancy_backgrounds/backgrounds/background1.png
  /// ```
  ///
  /// The `lib/` is implied, so it should not be included in the asset path.
  ///
  ///
  /// See also:
  ///
  ///  * [AssetImage], which is used to implement the behavior when the scale is
  ///    omitted.
  ///  * [ExactAssetImage], which is used to implement the behavior when the
  ///    scale is present.
  ///  * <https://docs.flutter.dev/ui/assets/assets-and-images>, an introduction to assets in
  ///    Flutter.
  Image.asset(
    super.name, {
    super.key,
    super.bundle,
    super.frameBuilder,
    super.errorBuilder,
    super.semanticLabel,
    super.excludeFromSemantics,
    super.scale,
    super.width,
    super.height,
    super.color,
    super.opacity,
    super.colorBlendMode,
    super.fit,
    super.alignment,
    super.repeat,
    super.centerSlice,
    super.matchTextDirection,
    super.gaplessPlayback,
    super.isAntiAlias,
    super.package,
    super.filterQuality,
    super.cacheWidth,
    super.cacheHeight,
    super.useLogicalCacheSize,
  }) : super.asset();

  /// Creates a widget that displays an [ImageStream] obtained from a [Uint8List].
  ///
  /// The `bytes` argument specifies encoded image bytes, which can be encoded
  /// in any of the following supported image formats:
  /// {@macro dart.ui.imageFormats}
  ///
  /// The `scale` argument specifies the linear scale factor for drawing this
  /// image at its intended size and applies to both the width and the height.
  /// {@macro flutter.painting.imageInfo.scale}
  ///
  /// This only accepts compressed image formats (e.g. PNG). Uncompressed
  /// formats like rawRgba (the default format of [dart:ui.Image.toByteData])
  /// will lead to exceptions.
  ///
  /// Either the [width] and [height] arguments should be specified, or the
  /// widget should be placed in a context that sets tight layout constraints.
  /// Otherwise, the image dimensions will change as the image is loaded, which
  /// will result in ugly layout changes.
  ///
  /// {@macro flutter.widgets.image.filterQualityParameter}
  ///
  /// If [excludeFromSemantics] is true, then [semanticLabel] will be ignored.
  ///
  /// If `cacheWidth` or `cacheHeight` are provided, they indicate to the
  /// engine that the image must be decoded at the specified size. The image
  /// will be rendered to the constraints of the layout or [width] and [height]
  /// regardless of these parameters. These parameters are primarily intended
  /// to reduce the memory usage of [ImageCache].
  ///
  /// If [useLogicalCacheSize] is true, [cacheWidth] and [cacheHeight] are
  /// interpreted as logical pixels instead of physical pixels. Set this to
  /// true when [cacheWidth] and [cacheHeight] describe the image's on-screen
  /// size in logical pixels.
  Image.memory(
    super.bytes, {
    super.key,
    super.scale,
    super.frameBuilder,
    super.errorBuilder,
    super.semanticLabel,
    super.excludeFromSemantics,
    super.width,
    super.height,
    super.color,
    super.opacity,
    super.colorBlendMode,
    super.fit,
    super.alignment,
    super.repeat,
    super.centerSlice,
    super.matchTextDirection,
    super.gaplessPlayback,
    super.isAntiAlias,
    super.filterQuality,
    super.cacheWidth,
    super.cacheHeight,
    super.useLogicalCacheSize,
  }) : super.memory();

  @override
  State<Image> createState() => _ImageState();
}

/// A utility class for overriding the text styles of a [TextSpan] tree.
// When changes are made to this class, the equivalent API in editable_text.dart
// must also be updated.
// TODO(Renzo-Olivares): Remove after investigating a solution for overriding all
// styles for children in an [InlineSpan] tree, see: https://github.com/flutter/flutter/issues/177952.
class _OverridingTextStyleTextSpanUtils {
  static TextSpan applyTextSpacingOverrides({
    double? lineHeightScaleFactor,
    double? letterSpacing,
    double? wordSpacing,
    required TextSpan textSpan,
  }) {
    if (lineHeightScaleFactor == null &&
        letterSpacing == null &&
        wordSpacing == null) {
      return textSpan;
    }
    return _applyTextStyleOverrides(
      TextStyle(
        height: lineHeightScaleFactor,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
      ),
      textSpan,
    );
  }

  static TextSpan _applyTextStyleOverrides(
    TextStyle overrideTextStyle,
    TextSpan textSpan,
  ) {
    return TextSpan(
      text: textSpan.text,
      children: textSpan.children?.map((InlineSpan child) {
        if (child is TextSpan && child.runtimeType == TextSpan) {
          return _applyTextStyleOverrides(overrideTextStyle, child);
        }
        return child;
      }).toList(),
      style: textSpan.style?.merge(overrideTextStyle) ?? overrideTextStyle,
      recognizer: textSpan.recognizer,
      mouseCursor: textSpan.mouseCursor,
      onEnter: textSpan.onEnter,
      onExit: textSpan.onExit,
      semanticsLabel: textSpan.semanticsLabel,
      semanticsIdentifier: textSpan.semanticsIdentifier,
      locale: textSpan.locale,
      spellOut: textSpan.spellOut,
    );
  }
}

class _SelectableTextContainer extends StatefulWidget {
  const _SelectableTextContainer({
    required this.text,
    required this.textAlign,
    this.textDirection,
    required this.softWrap,
    required this.overflow,
    required this.textScaler,
    this.maxLines,
    this.locale,
    this.strutStyle,
    required this.textWidthBasis,
    this.textHeightBehavior,
    required this.hyphens,
    required this.selectionColor,
  });

  final TextSpan text;
  final TextAlign textAlign;
  final TextDirection? textDirection;
  final bool softWrap;
  final TextOverflow overflow;
  final TextScaler textScaler;
  final int? maxLines;
  final Locale? locale;
  final StrutStyle? strutStyle;
  final TextWidthBasis textWidthBasis;
  final ui.TextHeightBehavior? textHeightBehavior;
  final ui.Hyphens hyphens;
  final Color selectionColor;

  @override
  State<_SelectableTextContainer> createState() =>
      _SelectableTextContainerState();
}

class _ImageState extends State<Image> with WidgetsBindingObserver {
  ImageStream? _imageStream;
  ImageInfo? _imageInfo;
  ImageChunkEvent? _loadingProgress;
  bool _isListeningToStream = false;
  late bool _invertColors;
  int? _frameNumber;
  bool _wasSynchronouslyLoaded = false;
  late DisposableBuildContext<State<Image>> _scrollAwareContext;
  Object? _lastException;
  StackTrace? _lastStack;
  ImageStreamCompleterHandle? _completerHandle;

  /// True when animations are disabled and the image should not update, such as
  /// when [TickerMode] is disabled or [MediaQueryData.disableAnimations] is
  /// true.
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _scrollAwareContext = DisposableBuildContext<State<Image>>(this);
  }

  @override
  void dispose() {
    assert(_imageStream != null);
    WidgetsBinding.instance.removeObserver(this);
    _stopListeningToStream();
    _completerHandle?.dispose();
    _scrollAwareContext.dispose();
    _replaceImage(info: null);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _updateInvertColors();
    _resolveImage();

    _isPaused =
        !TickerMode.of(context) ||
        (MediaQuery.maybeDisableAnimationsOf(context) ?? false);

    if (_isPaused && _frameNumber != null) {
      _stopListeningToStream(keepStreamAlive: true);
    } else {
      _listenToStream();
    }

    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(Image oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_isListeningToStream &&
        (widget.loadingBuilder == null) != (oldWidget.loadingBuilder == null)) {
      final ImageStreamListener oldListener = _getListener();
      _imageStream!.addListener(_getListener(recreateListener: true));
      _imageStream!.removeListener(oldListener);
    }
    if (widget.image != oldWidget.image) {
      _resolveImage();
      _listenToStream();
    }
  }

  @override
  void didChangeAccessibilityFeatures() {
    super.didChangeAccessibilityFeatures();
    setState(() {
      _updateInvertColors();
    });
  }

  @override
  void reassemble() {
    _resolveImage(); // in case the image cache was flushed
    super.reassemble();
  }

  void _updateInvertColors() {
    _invertColors =
        MediaQuery.maybeInvertColorsOf(context) ??
        SemanticsBinding.instance.accessibilityFeatures.invertColors;
  }

  void _resolveImage() {
    final provider = ScrollAwareImageProvider<Object>(
      context: _scrollAwareContext,
      imageProvider: widget.image,
    );
    final ImageStream newStream = provider.resolve(
      createLocalImageConfiguration(
        context,
        size: widget.width != null && widget.height != null
            ? Size(widget.width!, widget.height!)
            : null,
      ),
    );
    _updateSourceStream(newStream);
  }

  ImageStreamListener? _imageStreamListener;
  ImageStreamListener _getListener({bool recreateListener = false}) {
    if (_imageStreamListener == null || recreateListener) {
      _lastException = null;
      _lastStack = null;
      _imageStreamListener = ImageStreamListener(
        _handleImageFrame,
        onChunk: widget.loadingBuilder == null ? null : _handleImageChunk,
        onError: widget.errorBuilder != null || kDebugMode
            ? (Object error, StackTrace? stackTrace) {
                setState(() {
                  _lastException = error;
                  _lastStack = stackTrace;
                });
                assert(() {
                  if (widget.errorBuilder == null) {
                    // ignore: only_throw_errors, since we're just proxying the error.
                    throw error; // Ensures the error message is printed to the console.
                  }
                  return true;
                }());
              }
            : null,
        // Only suppress error reporting when errorBuilder is provided.
        reportErrors: widget.errorBuilder == null,
      );
    }
    return _imageStreamListener!;
  }

  void _handleImageFrame(ImageInfo imageInfo, bool synchronousCall) {
    setState(() {
      _replaceImage(info: imageInfo);
      _loadingProgress = null;
      _lastException = null;
      _lastStack = null;
      _frameNumber = _frameNumber == null ? 0 : _frameNumber! + 1;
      _wasSynchronouslyLoaded = _wasSynchronouslyLoaded | synchronousCall;
    });
    if (_isPaused) {
      _stopListeningToStream(keepStreamAlive: true);
    }
  }

  void _handleImageChunk(ImageChunkEvent event) {
    assert(widget.loadingBuilder != null);
    setState(() {
      _loadingProgress = event;
      _lastException = null;
      _lastStack = null;
    });
  }

  void _replaceImage({required ImageInfo? info}) {
    final ImageInfo? oldImageInfo = _imageInfo;
    if (oldImageInfo != null) {
      SchedulerBinding.instance.addPostFrameCallback(
        (Duration duration) => oldImageInfo.dispose(),
        debugLabel: 'Image.disposeOldInfo',
      );
    }
    _imageInfo = info;
  }

  // Updates _imageStream to newStream, and moves the stream listener
  // registration from the old stream to the new stream (if a listener was
  // registered).
  void _updateSourceStream(ImageStream newStream) {
    if (_imageStream?.key == newStream.key) {
      return;
    }

    if (_isListeningToStream) {
      _imageStream!.removeListener(_getListener());
    }

    if (!widget.gaplessPlayback) {
      setState(() {
        _replaceImage(info: null);
      });
    }

    setState(() {
      _loadingProgress = null;
      _frameNumber = null;
      _wasSynchronouslyLoaded = false;
    });

    _imageStream = newStream;
    if (_isListeningToStream) {
      _imageStream!.addListener(_getListener());
    }
  }

  void _listenToStream() {
    if (_isListeningToStream) {
      return;
    }

    _isListeningToStream = true;
    _imageStream!.addListener(_getListener());
    _completerHandle?.dispose();
    _completerHandle = null;
  }

  /// Stops listening to the image stream, if this state object has attached a
  /// listener.
  ///
  /// If the listener from this state is the last listener on the stream, the
  /// stream will be disposed. To keep the stream alive, set `keepStreamAlive`
  /// to true, which create [ImageStreamCompleterHandle] to keep the completer
  /// alive and is compatible with the [TickerMode] being off.
  void _stopListeningToStream({bool keepStreamAlive = false}) {
    if (!_isListeningToStream) {
      return;
    }

    if (keepStreamAlive &&
        _completerHandle == null &&
        _imageStream?.completer != null) {
      _completerHandle = _imageStream!.completer!.keepAlive();
    }

    // It's almost time to remove the last listener, which triggers the
    // disposal. But before that, add an ephemeral listener to potentially
    // suppress errors.
    //
    // Reason: When an app provides an `Image` widget with an `errorBuilder`, it
    // expects the widget to never report errors through `FlutterError` in any
    // cases. This is hard if the stream fails after the disposal, because an
    // image stream must have no listeners to be disposed, which then has
    // nothing to suppress the errors. This is solve with the help of an
    // ephemeral listener, which also suppresses the error but does not hinder
    // disposal. For more details, see
    // https://github.com/flutter/flutter/issues/97077 .
    if (_imageStream!.completer != null && widget.errorBuilder != null) {
      _imageStream!.completer!.addEphemeralErrorListener((
        Object exception,
        StackTrace? stackTrace,
      ) {
        // Intentionally blank.
      });
    }
    _imageStream!.removeListener(_getListener());
    _isListeningToStream = false;
  }

  Widget _debugBuildErrorWidget(BuildContext context, Object error) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        const Positioned.fill(child: Placeholder(color: Color(0xCF8D021F))),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: FittedBox(
            child: Text(
              '$error',
              textAlign: TextAlign.center,
              textDirection: TextDirection.ltr,
              style: const TextStyle(
                shadows: <Shadow>[Shadow(blurRadius: 1.0)],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_lastException != null) {
      if (widget.errorBuilder != null) {
        return widget.errorBuilder!(context, _lastException!, _lastStack);
      }
      if (kDebugMode) {
        return _debugBuildErrorWidget(context, _lastException!);
      }
    }

    late Widget result;
    if (_imageInfo case final WebImageInfo webImage) {
      // TODO(harryterkelsen): Support the remaining properties that are
      // supported by `RawImage` but not `RawWebImage`. See the following issue
      // above for a discussion of the missing properties and suggestions for
      // how they can be implemented, https://github.com/flutter/flutter/issues/159565.
      result = RawWebImage(
        image: webImage,
        debugImageLabel: _imageInfo?.debugLabel,
        width: widget.width,
        height: widget.height,
        fit: widget.fit,
        alignment: widget.alignment,
        matchTextDirection: widget.matchTextDirection,
      );
    } else {
      result = RawImage(
        // Do not clone the image, because RawImage is a stateless wrapper.
        // The image will be disposed by this state object when it is not needed
        // anymore, such as when it is unmounted or when the image stream pushes
        // a new image.
        image: _imageInfo?.image,
        debugImageLabel: _imageInfo?.debugLabel,
        width: widget.width,
        height: widget.height,
        scale: _imageInfo?.scale ?? 1.0,
        color: widget.color,
        opacity: widget.opacity,
        colorBlendMode: widget.colorBlendMode,
        fit: widget.fit,
        alignment: widget.alignment,
        repeat: widget.repeat,
        centerSlice: widget.centerSlice,
        matchTextDirection: widget.matchTextDirection,
        invertColors: _invertColors,
        isAntiAlias: widget.isAntiAlias,
        filterQuality: widget.filterQuality,
      );
    }

    if (!widget.excludeFromSemantics) {
      result = Semantics(
        container: widget.semanticLabel != null,
        image: true,
        label: widget.semanticLabel ?? '',
        child: result,
      );
    }

    if (widget.frameBuilder != null) {
      result = widget.frameBuilder!(
        context,
        result,
        _frameNumber,
        _wasSynchronouslyLoaded,
      );
    }

    if (widget.loadingBuilder != null) {
      result = widget.loadingBuilder!(context, result, _loadingProgress);
    }

    return result;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder description) {
    super.debugFillProperties(description);
    description.add(DiagnosticsProperty<ImageStream>('stream', _imageStream));
    description.add(DiagnosticsProperty<ImageInfo>('pixels', _imageInfo));
    description.add(
      DiagnosticsProperty<ImageChunkEvent>('loadingProgress', _loadingProgress),
    );
    description.add(DiagnosticsProperty<int>('frameNumber', _frameNumber));
    description.add(
      DiagnosticsProperty<bool>(
        'wasSynchronouslyLoaded',
        _wasSynchronouslyLoaded,
      ),
    );
  }
}

class _SelectableTextContainerState extends State<_SelectableTextContainer> {
  late final _SelectableTextContainerDelegate _selectionDelegate;
  final GlobalKey _textKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _selectionDelegate = _SelectableTextContainerDelegate(_textKey);
  }

  @override
  void dispose() {
    _selectionDelegate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SelectionContainer(
      delegate: _selectionDelegate,
      // Use [_RichText] wrapper so the underlying [RenderParagraph] can register
      // its [Selectable]s to the [SelectionContainer] created by this widget.
      child: _RichText(
        textKey: _textKey,
        textAlign: widget.textAlign,
        textDirection: widget.textDirection,
        locale: widget.locale,
        softWrap: widget.softWrap,
        overflow: widget.overflow,
        textScaler: widget.textScaler,
        maxLines: widget.maxLines,
        strutStyle: widget.strutStyle,
        textWidthBasis: widget.textWidthBasis,
        textHeightBehavior: widget.textHeightBehavior,
        hyphens: widget.hyphens,
        selectionColor: widget.selectionColor,
        text: widget.text,
      ),
    );
  }
}

class _SelectableTextContainerDelegate
    extends StaticSelectionContainerDelegate {
  _SelectableTextContainerDelegate(GlobalKey textKey) : _textKey = textKey;

  final GlobalKey _textKey;
  RenderParagraph get paragraph =>
      _textKey.currentContext!.findRenderObject()! as RenderParagraph;

  @override
  SelectionResult handleSelectParagraph(SelectParagraphSelectionEvent event) {
    final SelectionResult result = _handleSelectParagraph(event);
    super.didReceiveSelectionBoundaryEvents();
    return result;
  }

  SelectionResult _handleSelectParagraph(SelectParagraphSelectionEvent event) {
    if (event.absorb) {
      for (var index = 0; index < selectables.length; index += 1) {
        dispatchSelectionEventToChild(selectables[index], event);
      }
      currentSelectionStartIndex = 0;
      currentSelectionEndIndex = selectables.length - 1;
      return SelectionResult.next;
    }

    // First pass, if the position is on a placeholder then dispatch the selection
    // event to the [Selectable] at the location and terminate.
    for (var index = 0; index < selectables.length; index += 1) {
      final bool selectableIsPlaceholder = !paragraph
          .selectableBelongsToParagraph(selectables[index]);
      if (selectableIsPlaceholder &&
          selectables[index].boundingBoxes.isNotEmpty) {
        for (final Rect rect in selectables[index].boundingBoxes) {
          final Rect globalRect = MatrixUtils.transformRect(
            selectables[index].getTransformTo(null),
            rect,
          );
          if (globalRect.contains(event.globalPosition)) {
            currentSelectionStartIndex = currentSelectionEndIndex = index;
            return dispatchSelectionEventToChild(selectables[index], event);
          }
        }
      }
    }

    SelectionResult? lastSelectionResult;
    var foundStart = false;
    int? lastNextIndex;
    for (var index = 0; index < selectables.length; index += 1) {
      if (!paragraph.selectableBelongsToParagraph(selectables[index])) {
        if (foundStart) {
          final SelectionEvent synthesizedEvent = SelectParagraphSelectionEvent(
            globalPosition: event.globalPosition,
            absorb: true,
          );
          final SelectionResult result = dispatchSelectionEventToChild(
            selectables[index],
            synthesizedEvent,
          );
          if (selectables.length - 1 == index) {
            currentSelectionEndIndex = index;
            _flushInactiveSelections();
            return result;
          }
        }
        continue;
      }
      final SelectionGeometry existingGeometry = selectables[index].value;
      lastSelectionResult = dispatchSelectionEventToChild(
        selectables[index],
        event,
      );
      if (index == selectables.length - 1 &&
          lastSelectionResult == SelectionResult.next) {
        if (foundStart) {
          currentSelectionEndIndex = index;
        } else {
          currentSelectionStartIndex = currentSelectionEndIndex = index;
        }
        return SelectionResult.next;
      }
      if (lastSelectionResult == SelectionResult.next) {
        if (selectables[index].value == existingGeometry && !foundStart) {
          lastNextIndex = index;
        }
        if (selectables[index].value != existingGeometry && !foundStart) {
          assert(selectables[index].boundingBoxes.isNotEmpty);
          assert(selectables[index].value.selectionRects.isNotEmpty);
          final bool selectionAtStartOfSelectable = selectables[index]
              .boundingBoxes[0]
              .overlaps(selectables[index].value.selectionRects[0]);
          var startIndex = 0;
          if (lastNextIndex != null && selectionAtStartOfSelectable) {
            startIndex = lastNextIndex + 1;
          } else {
            startIndex = lastNextIndex == null && selectionAtStartOfSelectable
                ? 0
                : index;
          }
          for (var i = startIndex; i < index; i += 1) {
            final SelectionEvent synthesizedEvent =
                SelectParagraphSelectionEvent(
                  globalPosition: event.globalPosition,
                  absorb: true,
                );
            dispatchSelectionEventToChild(selectables[i], synthesizedEvent);
          }
          currentSelectionStartIndex = startIndex;
          foundStart = true;
        }
        continue;
      }
      if (index == 0 && lastSelectionResult == SelectionResult.previous) {
        return SelectionResult.previous;
      }
      if (selectables[index].value != existingGeometry) {
        if (!foundStart && lastNextIndex == null) {
          currentSelectionStartIndex = 0;
          for (var i = 0; i < index; i += 1) {
            final SelectionEvent synthesizedEvent =
                SelectParagraphSelectionEvent(
                  globalPosition: event.globalPosition,
                  absorb: true,
                );
            dispatchSelectionEventToChild(selectables[i], synthesizedEvent);
          }
        }
        currentSelectionEndIndex = index;
        // Geometry has changed as a result of select paragraph, need to clear the
        // selection of other selectables to keep selection in sync.
        _flushInactiveSelections();
      }
      return SelectionResult.end;
    }
    assert(lastSelectionResult == null);
    return SelectionResult.end;
  }

  SelectionResult _adjustSelection(
    SelectionEdgeUpdateEvent event, {
    required bool isEnd,
  }) {
    assert(() {
      if (isEnd) {
        assert(
          currentSelectionEndIndex < selectables.length &&
              currentSelectionEndIndex >= 0,
        );
        return true;
      }
      assert(
        currentSelectionStartIndex < selectables.length &&
            currentSelectionStartIndex >= 0,
      );
      return true;
    }());
    SelectionResult? finalResult;
    // Determines if the edge being adjusted is within the current viewport.
    //  - If so, we begin the search for the new selection edge position at the
    //    currentSelectionEndIndex/currentSelectionStartIndex.
    //  - If not, we attempt to locate the new selection edge starting from
    //    the opposite end.
    //  - If neither edge is in the current viewport, the search for the new
    //    selection edge position begins at 0.
    //
    // This can happen when there is a scrollable child and the edge being adjusted
    // has been scrolled out of view.
    final isCurrentEdgeWithinViewport = isEnd
        ? value.endSelectionPoint != null
        : value.startSelectionPoint != null;
    final isOppositeEdgeWithinViewport = isEnd
        ? value.startSelectionPoint != null
        : value.endSelectionPoint != null;
    int newIndex = switch ((
      isEnd,
      isCurrentEdgeWithinViewport,
      isOppositeEdgeWithinViewport,
    )) {
      (true, true, true) => currentSelectionEndIndex,
      (true, true, false) => currentSelectionEndIndex,
      (true, false, true) => currentSelectionStartIndex,
      (true, false, false) => 0,
      (false, true, true) => currentSelectionStartIndex,
      (false, true, false) => currentSelectionStartIndex,
      (false, false, true) => currentSelectionEndIndex,
      (false, false, false) => 0,
    };
    bool? forward;
    late SelectionResult currentSelectableResult;
    // This loop sends the selection event to one of the following to determine
    // the direction of the search.
    //  - currentSelectionEndIndex/currentSelectionStartIndex if the current edge
    //    is in the current viewport.
    //  - The opposite edge index if the current edge is not in the current viewport.
    //  - Index 0 if neither edge is in the current viewport.
    //
    // If the result is `SelectionResult.next`, this loop look backward.
    // Otherwise, it looks forward.
    //
    // The terminate condition are:
    // 1. the selectable returns end, pending, none.
    // 2. the selectable returns previous when looking forward.
    // 2. the selectable returns next when looking backward.
    while (newIndex < selectables.length &&
        newIndex >= 0 &&
        finalResult == null) {
      currentSelectableResult = dispatchSelectionEventToChild(
        selectables[newIndex],
        event,
      );
      switch (currentSelectableResult) {
        case SelectionResult.end:
        case SelectionResult.pending:
        case SelectionResult.none:
          finalResult = currentSelectableResult;
        case SelectionResult.next:
          if (forward == false) {
            newIndex += 1;
            finalResult = SelectionResult.end;
          } else if (newIndex == selectables.length - 1) {
            finalResult = currentSelectableResult;
          } else {
            forward = true;
            newIndex += 1;
          }
        case SelectionResult.previous:
          if (forward ?? false) {
            newIndex -= 1;
            finalResult = SelectionResult.end;
          } else if (newIndex == 0) {
            finalResult = currentSelectableResult;
          } else {
            forward = false;
            newIndex -= 1;
          }
      }
    }
    if (isEnd) {
      final bool forwardSelection =
          currentSelectionEndIndex >= currentSelectionStartIndex;
      if (forward != null &&
          ((!forwardSelection &&
                  forward &&
                  newIndex >= currentSelectionStartIndex) ||
              (forwardSelection &&
                  !forward &&
                  newIndex <= currentSelectionStartIndex))) {
        currentSelectionStartIndex = currentSelectionEndIndex;
      }
      currentSelectionEndIndex = newIndex;
    } else {
      final bool forwardSelection =
          currentSelectionEndIndex >= currentSelectionStartIndex;
      if (forward != null &&
          ((!forwardSelection &&
                  !forward &&
                  newIndex <= currentSelectionEndIndex) ||
              (forwardSelection &&
                  forward &&
                  newIndex >= currentSelectionEndIndex))) {
        currentSelectionEndIndex = currentSelectionStartIndex;
      }
      currentSelectionStartIndex = newIndex;
    }
    _flushInactiveSelections();
    return finalResult!;
  }

  /// The compare function this delegate used for determining the selection
  /// order of the [Selectable]s.
  ///
  /// Sorts the [Selectable]s by their top left [Rect].
  @override
  Comparator<Selectable> get compareOrder => _compareScreenOrder;

  static int _compareScreenOrder(Selectable a, Selectable b) {
    // Attempt to sort the selectables under a [_SelectableTextContainerDelegate]
    // by the top left rect.
    final Rect rectA = MatrixUtils.transformRect(
      a.getTransformTo(null),
      a.boundingBoxes.first,
    );
    final Rect rectB = MatrixUtils.transformRect(
      b.getTransformTo(null),
      b.boundingBoxes.first,
    );
    final int result = _compareVertically(rectA, rectB);
    if (result != 0) {
      return result;
    }
    return _compareHorizontally(rectA, rectB);
  }

  /// Compares two rectangles in the screen order solely by their vertical
  /// positions.
  ///
  /// Returns positive if a is lower, negative if a is higher, 0 if their
  /// order can't be determine solely by their vertical position.
  static int _compareVertically(Rect a, Rect b) {
    // The rectangles overlap so defer to horizontal comparison.
    if ((a.top - b.top < _kSelectableVerticalComparingThreshold &&
            a.bottom - b.bottom > -_kSelectableVerticalComparingThreshold) ||
        (b.top - a.top < _kSelectableVerticalComparingThreshold &&
            b.bottom - a.bottom > -_kSelectableVerticalComparingThreshold)) {
      return 0;
    }
    if ((a.top - b.top).abs() > _kSelectableVerticalComparingThreshold) {
      return a.top > b.top ? 1 : -1;
    }
    return a.bottom > b.bottom ? 1 : -1;
  }

  /// Compares two rectangles in the screen order by their horizontal positions
  /// assuming one of the rectangles enclose the other rect vertically.
  ///
  /// Returns positive if a is lower, negative if a is higher.
  static int _compareHorizontally(Rect a, Rect b) {
    // a encloses b.
    if (a.left - b.left < precisionErrorTolerance &&
        a.right - b.right > -precisionErrorTolerance) {
      return -1;
    }
    // b encloses a.
    if (b.left - a.left < precisionErrorTolerance &&
        b.right - a.right > -precisionErrorTolerance) {
      return 1;
    }
    if ((a.left - b.left).abs() > precisionErrorTolerance) {
      return a.left > b.left ? 1 : -1;
    }
    return a.right > b.right ? 1 : -1;
  }

  /// This method calculates a local [SelectedContentRange] based on the list
  /// of [selections] that are accumulated from the [Selectable] children under this
  /// delegate. This calculation takes into account the accumulated content
  /// length before the active selection, and returns null when either selection
  /// edge has not been set.
  SelectedContentRange? _calculateLocalRange(List<_SelectionInfo> selections) {
    if (currentSelectionStartIndex == -1 || currentSelectionEndIndex == -1) {
      return null;
    }
    var startOffset = 0;
    var endOffset = 0;
    var foundStart = false;
    bool forwardSelection =
        currentSelectionEndIndex >= currentSelectionStartIndex;
    if (currentSelectionEndIndex == currentSelectionStartIndex) {
      // Determining selection direction is inaccurate if currentSelectionStartIndex == currentSelectionEndIndex.
      // Use the range from the selectable within the selection as the source of truth for selection direction.
      final SelectedContentRange rangeAtSelectableInSelection =
          selectables[currentSelectionStartIndex].getSelection()!;
      forwardSelection =
          rangeAtSelectableInSelection.endOffset >=
          rangeAtSelectableInSelection.startOffset;
    }
    for (var index = 0; index < selections.length; index++) {
      final _SelectionInfo selection = selections[index];
      if (selection.range == null) {
        if (foundStart) {
          return SelectedContentRange(
            startOffset: forwardSelection ? startOffset : endOffset,
            endOffset: forwardSelection ? endOffset : startOffset,
          );
        }
        startOffset += selection.contentLength;
        endOffset = startOffset;
        continue;
      }
      final int selectionStartNormalized = min(
        selection.range!.startOffset,
        selection.range!.endOffset,
      );
      final int selectionEndNormalized = max(
        selection.range!.startOffset,
        selection.range!.endOffset,
      );
      if (!foundStart) {
        // Because a RenderParagraph may split its content into multiple selectables
        // we have to consider at what offset a selectable starts at relative
        // to the RenderParagraph, when the selectable is not the start of the content.
        final bool shouldConsiderContentStart =
            index > 0 &&
            paragraph.selectableBelongsToParagraph(selectables[index]);
        startOffset +=
            (selectionStartNormalized -
                    (shouldConsiderContentStart
                        ? paragraph
                              .getPositionForOffset(
                                selectables[index]
                                    .boundingBoxes
                                    .first
                                    .centerLeft,
                              )
                              .offset
                        : 0))
                .abs();
        endOffset =
            startOffset +
            (selectionEndNormalized - selectionStartNormalized).abs();
        foundStart = true;
      } else {
        endOffset += (selectionEndNormalized - selectionStartNormalized).abs();
      }
    }
    assert(
      foundStart,
      'The start of the selection has not been found despite this selection delegate having an existing currentSelectionStartIndex and currentSelectionEndIndex.',
    );
    return SelectedContentRange(
      startOffset: forwardSelection ? startOffset : endOffset,
      endOffset: forwardSelection ? endOffset : startOffset,
    );
  }

  /// Returns a [SelectedContentRange] considering the [SelectedContentRange]
  /// from each [Selectable] child managed under this delegate.
  ///
  /// When nothing is selected or either selection edge has not been set,
  /// this method will return `null`.
  @override
  SelectedContentRange? getSelection() {
    final selections = <_SelectionInfo>[
      for (final Selectable selectable in selectables)
        (
          contentLength: selectable.contentLength,
          range: selectable.getSelection(),
        ),
    ];
    return _calculateLocalRange(selections);
  }

  // From [SelectableRegion].

  // Clears the selection on all selectables not in the range of
  // currentSelectionStartIndex..currentSelectionEndIndex.
  //
  // If one of the edges does not exist, then this method will clear the selection
  // in all selectables except the existing edge.
  //
  // If neither of the edges exist this method immediately returns.
  void _flushInactiveSelections() {
    if (currentSelectionStartIndex == -1 && currentSelectionEndIndex == -1) {
      return;
    }
    if (currentSelectionStartIndex == -1 || currentSelectionEndIndex == -1) {
      final int skipIndex = currentSelectionStartIndex == -1
          ? currentSelectionEndIndex
          : currentSelectionStartIndex;
      for (var i = 0; i < selectables.length; i++) {
        if (i == skipIndex) {
          continue;
        }
        dispatchSelectionEventToChild(
          selectables[i],
          const ClearSelectionEvent(),
        );
      }
      return;
    }
    final int skipStart = min(
      currentSelectionStartIndex,
      currentSelectionEndIndex,
    );
    final int skipEnd = max(
      currentSelectionStartIndex,
      currentSelectionEndIndex,
    );
    for (var index = 0; index < selectables.length; index += 1) {
      if (index >= skipStart && index <= skipEnd) {
        continue;
      }
      dispatchSelectionEventToChild(
        selectables[index],
        const ClearSelectionEvent(),
      );
    }
  }

  @override
  SelectionResult handleSelectionEdgeUpdate(SelectionEdgeUpdateEvent event) {
    if (event.granularity != TextGranularity.paragraph) {
      return super.handleSelectionEdgeUpdate(event);
    }
    updateLastSelectionEdgeLocation(
      globalSelectionEdgeLocation: event.globalPosition,
      forEnd: event.type == SelectionEventType.endEdgeUpdate,
    );
    if (event.type == SelectionEventType.endEdgeUpdate) {
      return currentSelectionEndIndex == -1
          ? super.handleSelectionEdgeUpdate(event)
          : _adjustSelection(event, isEnd: true);
    }
    return currentSelectionStartIndex == -1
        ? super.handleSelectionEdgeUpdate(event)
        : _adjustSelection(event, isEnd: false);
  }
}

class _RichText extends StatelessWidget {
  const _RichText({
    this.textKey,
    required this.text,
    required this.textAlign,
    this.textDirection,
    required this.softWrap,
    required this.overflow,
    required this.textScaler,
    this.maxLines,
    this.locale,
    this.strutStyle,
    required this.textWidthBasis,
    this.textHeightBehavior,
    required this.hyphens,
    required this.selectionColor,
  });

  final GlobalKey? textKey;
  final InlineSpan text;
  final TextAlign textAlign;
  final TextDirection? textDirection;
  final bool softWrap;
  final TextOverflow overflow;
  final TextScaler textScaler;
  final int? maxLines;
  final Locale? locale;
  final StrutStyle? strutStyle;
  final TextWidthBasis textWidthBasis;
  final ui.TextHeightBehavior? textHeightBehavior;
  final ui.Hyphens hyphens;
  final Color selectionColor;

  @override
  Widget build(BuildContext context) {
    final SelectionRegistrar? registrar = SelectionContainer.maybeOf(context);
    return RichText(
      key: textKey,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      textScaler: textScaler,
      maxLines: maxLines,
      strutStyle: strutStyle,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
      hyphens: hyphens,
      selectionRegistrar: registrar,
      selectionColor: selectionColor,
      text: text,
    );
  }
}

const double _kSelectableVerticalComparingThreshold = 3.0;

/// The length of the content that can be selected, and the range that is
/// selected.
typedef _SelectionInfo = ({int contentLength, SelectedContentRange? range});
