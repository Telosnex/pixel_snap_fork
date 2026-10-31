# pixel_snap_generator

This package keeps the Flutter code in pixel_snap_fork current. It has two tools.

- `bin/generate.dart` writes `lib/src/generated/`.
- `bin/forks.dart` merges new Flutter releases into the files that the package copies in full.

The tools use the Flutter SDK that the package root resolves to. Run `flutter pub get` in the package root before you use them.

## How the package replaces Flutter widgets

`lib/src/widgets_in.dart` lists the widgets. Each widget has one of two annotations.

- `@GeneratePixelSnap<T>()` makes a wrapper. The wrapper is a `StatelessWidget` with the same constructors and fields as `T`. Its `build` method snaps the sizes, paddings, decorations and alignments, and then builds Flutter's `T`.
- `@GeneratePixelSnapSubclass<T>()` makes a subclass of Flutter's `T`. The constructors pass every argument to Flutter's constructors. The subclass copies the methods that make the widget tree or the render object (`build`, `createRenderObject`, `updateRenderObject`), and the private members that they use. The fields and the other members come from Flutter's class. The widget is a Flutter `T`, so `find.text`, `tester.widget<T>` and other code that tests for `T` work. Use it when you can.
- `@GeneratePixelSnapFork<T>()` copies the Flutter source of `T`. Use it when a subclass cannot do the work. For example, a subclass cannot copy a method that uses a private field.

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

## How the fork merge works

`upstream/` holds the Flutter file that each fork started from, formatted like the package. `upstream/flutter_version.txt` holds its Flutter version. `update` uses `git merge-file`. It applies the changes between the old and the new Flutter file to the fork, and keeps the changes of the fork. Then it replaces the file in `upstream/` with the new Flutter file.

To fork one more Flutter file in full, add it to `forks` in `bin/forks.dart`. Put the formatted Flutter file in `upstream/` before you change the copy in `lib/src/forked/`.
