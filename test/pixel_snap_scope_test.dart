import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pixel_snap_fork/pixel_snap.dart';

void main() {
  testWidgets('scope resolves and shares PixelSnap for its subtree', (
    tester,
  ) async {
    final resolved = <PixelSnap>[];

    await tester.pumpWidget(
      _mediaQuery(
        devicePixelRatio: 1.5,
        child: PixelSnapScope(
          child: Column(
            children: [
              Builder(
                builder: (context) {
                  resolved.add(PixelSnap.of(context));
                  return const SizedBox();
                },
              ),
              Builder(
                builder: (context) {
                  resolved.add(PixelSnap.of(context));
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );

    expect(resolved, hasLength(2));
    expect(resolved.first.devicePixelRatio, 1.5);
    expect(identical(resolved.first, resolved.last), isTrue);
  });

  testWidgets('scope updates when the MediaQuery pixel ratio changes', (
    tester,
  ) async {
    PixelSnap? resolved;

    Widget app(double devicePixelRatio) {
      return _mediaQuery(
        devicePixelRatio: devicePixelRatio,
        child: PixelSnapScope(
          child: Builder(
            builder: (context) {
              resolved = PixelSnap.of(context);
              return const SizedBox();
            },
          ),
        ),
      );
    }

    await tester.pumpWidget(app(1.5));
    expect(resolved!.devicePixelRatio, 1.5);

    await tester.pumpWidget(app(2));
    expect(resolved!.devicePixelRatio, 2);
  });

  testWidgets('override composes with the resolved parent configuration', (
    tester,
  ) async {
    PixelSnap? resolved;
    double customSnap(
      double value,
      double devicePixelRatio,
      PixelSnapMode mode,
    ) {
      return value + devicePixelRatio;
    }

    await tester.pumpWidget(
      _mediaQuery(
        devicePixelRatio: 1.5,
        child: PixelSnapScope(
          child: PixelSnapOverride(
            pixelSnapFunction: customSnap,
            child: Builder(
              builder: (context) {
                resolved = PixelSnap.of(context);
                return const SizedBox();
              },
            ),
          ),
        ),
      ),
    );

    expect(resolved!.devicePixelRatio, 1.5);
    expect(resolved!(2), 3.5);
  });

  testWidgets('PixelSnap.of remains compatible without a scope', (
    tester,
  ) async {
    PixelSnap? resolved;

    await tester.pumpWidget(
      _mediaQuery(
        devicePixelRatio: 1.75,
        child: Builder(
          builder: (context) {
            resolved = PixelSnap.of(context);
            return const SizedBox();
          },
        ),
      ),
    );

    expect(resolved!.devicePixelRatio, 1.75);
  });
}

Widget _mediaQuery({required double devicePixelRatio, required Widget child}) {
  return MediaQuery(
    data: MediaQueryData(devicePixelRatio: devicePixelRatio),
    child: child,
  );
}
