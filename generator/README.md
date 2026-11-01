# pixel_snap_generator

This package keeps the Flutter code in pixel_snap_fork current. It has two tools.

- `bin/generate.dart` writes `lib/src/generated/`.
- `bin/forks.dart` merges new Flutter releases into the files that the package copies in full.

The tools use the Flutter SDK that the package root resolves to. Run `flutter pub get` in the package root before you use them.

## How the package replaces Flutter widgets

`lib/src/widgets_in.dart` lists the widgets. Each widget has one of two annotations.

- `@GeneratePixelSnap<T>()` makes a wrapper. The wrapper is a `StatelessWidget` with the same constructors and fields as `T`. Its `build` method snaps the sizes, paddings, decorations and alignments, and then builds Flutter's `T`.
- `@GeneratePixelSnapSubclass<T>()` makes a subclass of Flutter's `T`. The constructors pass every argument to Flutter's constructors. The subclass copies the methods that make the widget tree or the render object (`build`, `createRenderObject`, `updateRenderObject`), and the private members that they use. The fields and the other members come from Flutter's class. The widget is a Flutter `T`, so `find.text`, `tester.widget<T>` and other code that tests for `T` work. Use it when you can.
- `@GeneratePixelSnapFork<T>()` copies the Flutter source of `T`. Use it when a subclass cannot do the work:
  - A copied method uses a private field of the class.
  - The widget must make a render object that is not a subclass of Flutter's. For example, the `RenderFlex` of the package is a full copy, and Flutter's `Flex.createRenderObject` returns Flutter's `RenderFlex`. Thus `Flex`, `Row` and `Column` are forks.
  - The method to change is in a superclass of `T`. The subclass copies only the methods of `T`. For example, `Center` gets its render object from `Align`.

In the copied code, the generator gives each `Render*` object the `PixelSnap` of the context.

Copied code uses private declarations of its Flutter library. The generator finds them in the copied code and copies them too. It also finds the import for each name that the copied code uses. The imports keep their conditions, for example `if (dart.library.js_interop)`.

`localOverrides` in `lib/generator.dart` maps the names that the package defines itself (for example `RenderFlex` and `RawImage`) to their files. Copied code that uses such a name uses the version of the package.

The render objects are in `lib/src/forked/`. Most of them extend Flutter's render object and override a small number of methods. `render_flex.dart` is a full copy, because the snapping is inside the layout code.

## Update for a new Flutter release

1. In the package root, change to the new Flutter and run `flutter pub get`.
2. In `generator/`, run `dart run bin/generate.dart`.
3. In `generator/`, run `dart run bin/forks.dart update`. If it reports conflicts, resolve the conflict markers in the fork.
4. In the package root, run `flutter analyze` and `flutter test`.
5. In `generator/`, run `dart test`.
6. Compare `lib/src/forked/` with the new Flutter source of each render object that the files extend. The tools do not track these subclasses. `RenderFittedBox` and `RawImage` contain copies of Flutter methods.

`bin/forks.dart check` fails when Flutter changed a forked file. The test `lib/src/generated is current with the Flutter SDK` fails when the generated files do not match the output of the generator. The Unit workflow runs both with the pinned Flutter. The Upstream workflow runs them every night with Flutter stable and beta.

## Release for a new Flutter version

Each release of the package works with one Flutter version and the versions after it, until Flutter changes the code that the package copies. Dart has no conditions on the Flutter version, so one release cannot support two Flutter versions that need different code. Pub selects the newest release whose `environment` agrees with the Flutter of the app.

Pub ignores a maximum on `flutter:`. A release can say "3.47 or newer", but not "3.47 to 3.49". Thus an app on a newer Flutter can get a release that does not compile on it. The minimum is the only thing that keeps an app on an older Flutter away from a new release.

### The `flutter-beta` branch

`main` works with the pinned Flutter. The `flutter-beta` branch keeps the package for the next Flutter: there you do the steps of [Update for a new Flutter release](#update-for-a-new-flutter-release) with Flutter beta. You cannot do this work on `main`, because the code for the next Flutter does not compile on the pinned Flutter.

The Upstream workflow runs every night, and at each push to `flutter-beta`:

- **Flutter stable** tests `main`. If it fails, a stable Flutter needs a new release of the package.
- **Flutter beta** tests `flutter-beta`. It fails if the branch does not exist, or if the branch does not pass on the current beta. Fix the branch, and the job passes again until a new beta needs more changes.

Keep `flutter:` in `pubspec.yaml` of `flutter-beta` at the minimum of `main`. A beta such as `3.50.0-0.3.pre` is lower than `3.50.0`, so `">=3.50.0"` excludes it. Merge `main` into `flutter-beta` when `main` changes, so that the release merge is small.

### Steps

1. Merge `flutter-beta` into a new branch from `main`. If the stable Flutter is different from the beta that `flutter-beta` was tested with, do the steps in [Update for a new Flutter release](#update-for-a-new-flutter-release) again with the stable Flutter.
2. In `pubspec.yaml`, set `flutter:` to the new Flutter version, for example `">=3.50.0"`. Set `sdk:` to the Dart version of that Flutter (`flutter --version` shows it), for example `^3.14.0`.
3. Change the Flutter of CI. The workflows install the Flutter in `flutter_version.txt` of Telosnex/telosnex_ci_tools, at the commit that they pin. Release telosnex_ci_tools with the new version, then change the commit and the version comment of each `Telosnex/telosnex_ci_tools/...@` line in `.github/workflows/`. Until then, the Unit workflow fails on the new code.
4. In `CHANGELOG.md`, add the new version. Write the new minimum Flutter version as **BREAKING**. Give the new parameters and the fixes from Flutter.
5. In `pubspec.yaml`, change `version:`. Increase the minor version (for example 0.2.x to 0.3.0): apps on the old Flutter cannot use the release.
6. Merge to `main`. Make sure that the Unit and Integration workflows pass, and the Flutter stable job of the Upstream workflow.
7. In the package root, run `dart pub publish --dry-run`, then `dart pub publish`.
8. In Telosnex, change the Flutter version and the pixel_snap_fork version in the same change. Run its tests. A change in Flutter's widgets can also change the tests that find text or measure layouts.
9. Reset `flutter-beta` to `main` (`git push --force origin main:flutter-beta`). Then do the work for the next beta on it.

## How the fork merge works

`upstream/` holds the Flutter file that each fork started from, formatted like the package. `upstream/flutter_version.txt` holds its Flutter version. `update` uses `git merge-file`. It applies the changes between the old and the new Flutter file to the fork, and keeps the changes of the fork. Then it replaces the file in `upstream/` with the new Flutter file.

To fork one more Flutter file in full, add it to `forks` in `bin/forks.dart`. Put the formatted Flutter file in `upstream/` before you change the copy in `lib/src/forked/`.
