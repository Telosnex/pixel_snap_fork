import 'package:flutter/widgets.dart';

enum PixelSnapMode {
  /// Snap to the nearest pixel.
  snap,

  /// Snap to the nearest pixel, rounding up.
  ceil,

  /// Snap to the nearest pixel, rounding down.
  floor,
}

typedef PixelSnapFunction = double Function(
  double value,
  double devicePixelRatio,
  PixelSnapMode mode,
);

class PixelSnap {
  PixelSnap.custom({
    required this.devicePixelRatio,
    this.pixelSnapFunction = _defaultPixelSnap,
  });

  /// Returns the resolved pixel snap configuration for [context].
  ///
  /// Install a [PixelSnapScope] below the app's [MediaQuery] to resolve the
  /// device pixel ratio once for its subtree. Without a scope this falls back
  /// to reading [MediaQuery] directly for backwards compatibility.
  static PixelSnap of(BuildContext context) {
    final scoped = context
        .dependOnInheritedWidgetOfExactType<_ResolvedPixelSnapScope>()
        ?.pixelSnap;
    return scoped ??
        _cached(MediaQuery.devicePixelRatioOf(context), _defaultPixelSnap);
  }

  static PixelSnap _cached(
    double devicePixelRatio,
    PixelSnapFunction pixelSnapFunction,
  ) {
    final last = _last;
    if (last != null &&
        last.devicePixelRatio == devicePixelRatio &&
        last.pixelSnapFunction == pixelSnapFunction) {
      return last;
    }

    final key = _PixelSnapCacheKey(devicePixelRatio, pixelSnapFunction);
    final cached = _cache[key];
    if (cached != null) return _last = cached;
    // Tiny bounded FIFO cache. In practice apps use one devicePixelRatio and
    // the default function; PixelSnapOverride may add a handful more. Avoid
    // retaining arbitrarily many override closures forever while still
    // removing the hot-path allocation from every generated widget build.
    if (_cache.length >= _cacheMaxEntries) {
      _cache.remove(_cache.keys.first);
    }
    final pixelSnap = PixelSnap.custom(
      devicePixelRatio: devicePixelRatio,
      pixelSnapFunction: pixelSnapFunction,
    );
    _cache[key] = pixelSnap;
    return _last = pixelSnap;
  }

  static const int _cacheMaxEntries = 16;
  static PixelSnap? _last;
  static final Map<_PixelSnapCacheKey, PixelSnap> _cache =
      <_PixelSnapCacheKey, PixelSnap>{};

  /// Snaps the [value] to nearest physical pixel according to provided [mode].
  double call(double value, [PixelSnapMode mode = PixelSnapMode.snap]) {
    return pixelSnapFunction(value, devicePixelRatio, mode);
  }

  @override
  bool operator ==(Object other) {
    return other is PixelSnap &&
        other.devicePixelRatio == devicePixelRatio &&
        other.pixelSnapFunction == pixelSnapFunction;
  }

  @override
  int get hashCode => Object.hash(devicePixelRatio, pixelSnapFunction);

  final double devicePixelRatio;
  final PixelSnapFunction pixelSnapFunction;
}

class _PixelSnapCacheKey {
  const _PixelSnapCacheKey(this.devicePixelRatio, this.pixelSnapFunction);

  final double devicePixelRatio;
  final PixelSnapFunction pixelSnapFunction;

  @override
  bool operator ==(Object other) {
    return other is _PixelSnapCacheKey &&
        other.devicePixelRatio == devicePixelRatio &&
        other.pixelSnapFunction == pixelSnapFunction;
  }

  @override
  int get hashCode => Object.hash(devicePixelRatio, pixelSnapFunction);
}

/// Resolves the device pixel ratio once for an application subtree.
///
/// Place this below the app's [MediaQuery], typically in `MaterialApp.builder`
/// or `WidgetsApp.builder`:
///
/// ```dart
/// MaterialApp(
///   builder: (context, child) => PixelSnapScope(child: child!),
/// )
/// ```
///
/// Descendant pixel-snapped widgets then perform one simple inherited lookup
/// instead of independently resolving [MediaQuery.devicePixelRatioOf].
class PixelSnapScope extends StatelessWidget {
  const PixelSnapScope({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return _ResolvedPixelSnapScope(
      pixelSnap: PixelSnap._cached(
        MediaQuery.devicePixelRatioOf(context),
        _defaultPixelSnap,
      ),
      child: child,
    );
  }
}

/// Widget that allows overriding pixel snap configuration for subtree.
///
/// For example the code below disables pixel snapping for the subtree
/// while ensuring that rest of the app remains pixel snapped:
/// ```dart
/// // Make sure the widget size is still pixel snapped
/// // and doesn't affect the rest of the app.
/// PixelSnapSize(
///   child: PixelSnapOverride(
///     pixelSnapFunction: (value, _, __) => value,
///     child: Container( // this container will not be pixel snapped.
/// )));
/// ```
class PixelSnapOverride extends StatelessWidget {
  const PixelSnapOverride({
    super.key,
    this.devicePixelRatio,
    this.pixelSnapFunction,
    required this.child,
  });

  final double? devicePixelRatio;
  final PixelSnapFunction? pixelSnapFunction;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final parent = context
        .dependOnInheritedWidgetOfExactType<_ResolvedPixelSnapScope>()
        ?.pixelSnap;
    return _ResolvedPixelSnapScope(
      pixelSnap: PixelSnap._cached(
        devicePixelRatio ??
            parent?.devicePixelRatio ??
            MediaQuery.devicePixelRatioOf(context),
        pixelSnapFunction ?? parent?.pixelSnapFunction ?? _defaultPixelSnap,
      ),
      child: child,
    );
  }
}

class _ResolvedPixelSnapScope extends InheritedWidget {
  const _ResolvedPixelSnapScope({
    required this.pixelSnap,
    required super.child,
  });

  final PixelSnap pixelSnap;

  @override
  bool updateShouldNotify(covariant _ResolvedPixelSnapScope oldWidget) {
    return pixelSnap != oldWidget.pixelSnap;
  }
}

double _defaultPixelSnap(
  double value,
  double devicePixelRatio,
  PixelSnapMode mode,
) {
  if (!value.isFinite) {
    return value;
  }
  switch (mode) {
    case PixelSnapMode.snap:
      // Ensure that 1.5 is rounded down. 1 logical pixel at 150% scale
      // should render at 1 physical pixel. At 175% it should render at
      // 2 physical pixels.
      return (value * devicePixelRatio - 0.05).round() / devicePixelRatio;
    case PixelSnapMode.ceil:
      return (value * devicePixelRatio).ceil() / devicePixelRatio;
    case PixelSnapMode.floor:
      return (value * devicePixelRatio).floor() / devicePixelRatio;
  }
}
