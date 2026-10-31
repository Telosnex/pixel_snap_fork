import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:collection/collection.dart';

class Field {
  Field({
    required this.type,
    required this.name,
    required this.docString,
    required this.nullable,
    required this.fromSuperClass,
    required this.named,
    this.defaultValue,
  });

  final String type;
  final String name;
  final String? docString;
  final bool nullable;
  final bool named;
  final bool fromSuperClass;
  final String? defaultValue;
}

class Constructor {
  Constructor({required this.docString, required this.code});

  final String? docString;
  final String code;

  @override
  String toString() => code;
}

enum ChildType { nullable, nonNullable, none }

/// A widget that the generator wraps: the wrapper builds the Flutter widget
/// with pixel-snapped arguments.
class Class {
  Class({
    required this.constructors,
    required this.fields,
    required this.docString,
    required this.className,
    required this.childType,
  });

  @override
  String toString() {
    final b = StringBuffer();
    b.writeln('Class $className (${constructors.length} constructors)');
    for (final f in fields) {
      b.writeln('  Field ${f.type}${f.nullable ? '?' : ''} ${f.name}');
    }
    return b.toString();
  }

  final List<Constructor> constructors;
  final List<Field> fields;
  final String? docString;
  final String className;
  final ChildType childType;
}

/// A widget whose Flutter source the generator copies.
class ForkedClass {
  ForkedClass({required this.className, required this.contents});

  final String className;
  final String contents;
}

/// An import that the copied Flutter source needs.
class ImportSpec {
  ImportSpec({
    required this.uri,
    this.prefix,
    this.configurations = const [],
    Set<String>? show,
  }) : show = show ?? <String>{};

  final String uri;
  final String? prefix;

  /// `if (name) 'uri'` clauses, in source order.
  final List<String> configurations;

  /// The names to show. Empty: the import shows every name.
  final Set<String> show;

  /// Imports with the same key merge into one directive.
  String get key => '$uri|$prefix|${configurations.join(' ')}';

  String get directive {
    final b = StringBuffer("import '$uri'");
    for (final c in configurations) {
      b.write(' $c');
    }
    if (prefix != null) b.write(' as $prefix');
    if (show.isNotEmpty) b.write(' show ${(show.toList()..sort()).join(', ')}');
    b.write(';');
    return b.toString();
  }
}

class ParseException implements Exception {
  ParseException(this.message);

  final String message;

  @override
  String toString() => 'ParseException: $message';
}

class Contents {
  Contents({
    required this.classes,
    required this.forkedClasses,
    required this.helpers,
    required this.imports,
    required this.localImports,
    required this.widgetsHides,
  });

  final List<Class> classes;
  final List<ForkedClass> forkedClasses;

  /// The private declarations that the forked classes use, copied from Flutter.
  final List<String> helpers;

  /// The imports that the forked classes and the helpers need.
  final List<ImportSpec> imports;

  /// The files of this package that the forked classes use, relative to the
  /// generated file.
  final List<String> localImports;

  /// The names that `package:flutter/widgets.dart` exports and this package
  /// replaces.
  final List<String> widgetsHides;
}

/// The public Flutter libraries. `widgets.dart` comes first: the generated
/// file imports it in full. The others are in order of preference for an
/// import: the library that declares a name before the ones that re-export it.
const _publicFlutterLibraries = [
  'package:flutter/widgets.dart',
  'package:flutter/foundation.dart',
  'package:flutter/animation.dart',
  'package:flutter/physics.dart',
  'package:flutter/scheduler.dart',
  'package:flutter/semantics.dart',
  'package:flutter/services.dart',
  'package:flutter/gestures.dart',
  'package:flutter/painting.dart',
  'package:flutter/rendering.dart',
];

/// Parses `widgets_in.dart` and collects what the generator writes.
class Parser {
  Parser(this.rootPath, {required this.localOverrides})
    : _context = _createAnalysisContext(path: rootPath);

  /// The input file (`widgets_in.dart`).
  final String rootPath;

  /// Names that this package defines, mapped to the file (relative to the
  /// generated file) that defines them. Copied Flutter source that uses such a
  /// name uses this package's version.
  final Map<String, String> localOverrides;

  Future<Contents> parse() async {
    final rootUnit = await _context.currentSession.getResolvedUnit(rootPath);
    if (rootUnit is! ResolvedUnitResult) {
      throw ParseException('Cannot resolve $rootPath: $rootUnit');
    }
    for (final uri in _publicFlutterLibraries) {
      final result = await _context.currentSession.getLibraryByUri(uri);
      if (result is! LibraryElementResult) {
        throw ParseException('Cannot resolve $uri: $result');
      }
      _publicLibraries.add(result.element);
    }

    final generate = rootUnit.libraryElement.topLevelFunctions.first;
    final wrapped = <InterfaceType>[];
    final forked = <InterfaceType>[];
    for (final annotation in generate.metadata.annotations) {
      final value = annotation.computeConstantValue();
      final type = value!.type as InterfaceType;
      final target = type.typeArguments.first as InterfaceType;
      switch (type.element.name) {
        case 'GeneratePixelSnap':
          wrapped.add(target);
        case 'GeneratePixelSnapFork':
          forked.add(target);
      }
    }
    _provided.addAll([...wrapped, ...forked].map((t) => t.element.name!));
    _provided.addAll(localOverrides.keys);

    for (final type in wrapped) {
      await _processClass(type);
    }
    for (final type in forked) {
      await _processFork(type);
    }
    // Helpers can use more helpers.
    while (_pendingHelpers.isNotEmpty) {
      await _processHelper(_pendingHelpers.removeAt(0));
    }

    final widgets = _publicLibraries.first;
    final widgetsHides = localOverrides.keys
        .where((name) => widgets.exportNamespace.get2(name) != null)
        .toList();

    return Contents(
      classes: _classes,
      forkedClasses: _forkedClasses,
      helpers: _helpers,
      imports: _imports.values.toList()..sortBy((i) => i.directive),
      localImports: _localImports.toList()..sort(),
      widgetsHides: widgetsHides,
    );
  }

  void _gatherFields(
    InterfaceType instanceType,
    List<Field> fields,
    bool isSuperClass,
  ) {
    final constructor = instanceType.constructors.first;
    for (final field in instanceType.element.fields) {
      if (!field.isOriginDeclaration || field.isStatic) {
        continue;
      }
      final name = field.name!;

      // The type with nullability inside, but without the nullable suffix.
      final type = field.type.getDisplayString().replaceAll(RegExp(r'\?$'), '');
      final nullable =
          field.type.nullabilitySuffix == NullabilitySuffix.question;
      final parameter = constructor.formalParameters.firstWhereOrNull(
        (p) => p.name == name,
      );

      fields.add(
        Field(
          type: type,
          name: name,
          docString: field.documentationComment,
          nullable: nullable,
          named: parameter?.isNamed ?? false,
          fromSuperClass: isSuperClass,
          defaultValue: parameter?.defaultValueCode,
        ),
      );
    }
  }

  Future<void> _processClass(InterfaceType type) async {
    final constructors = <Constructor>[];
    for (final c in type.constructors) {
      final node = await _declaration(c);
      _collectReferences(node);
      constructors.add(
        Constructor(docString: c.documentationComment, code: node.toSource()),
      );
    }
    final fields = <Field>[];
    _gatherFields(type, fields, false);
    if (type.superclass!.element.name != 'Widget') {
      _gatherFields(type.superclass!, fields, true);
    }
    // The wrapper declares the same fields: their types need imports.
    for (final field in [
      type,
      type.superclass!,
    ].expand((t) => t.element.fields)) {
      if (field.isOriginDeclaration && !field.isStatic) {
        _collectReferences((await _declaration(field)).parent!);
      }
    }

    var childType = ChildType.none;
    final childParameter = type.constructors.first.formalParameters
        .firstWhereOrNull((element) => element.name == 'child');
    if (childParameter != null) {
      childType =
          childParameter.type.nullabilitySuffix == NullabilitySuffix.question
          ? ChildType.nullable
          : ChildType.nonNullable;
    }

    _classes.add(
      Class(
        constructors: constructors,
        fields: fields,
        docString: type.element.documentationComment,
        className: type.element.name!,
        childType: childType,
      ),
    );
  }

  Future<void> _processFork(InterfaceType type) async {
    final element = type.element;
    _seenHelpers.add(element);
    final node = await _declaration(element);
    _forkedClasses.add(
      ForkedClass(className: element.name!, contents: _sourceOf(node)),
    );
    _collectReferences(node);
  }

  Future<void> _processHelper(Element element) async {
    var node = await _declaration(element);
    // A top-level variable is declared in a list (`const a = 1, b = 2;`).
    if (node is VariableDeclaration) {
      node = node.thisOrAncestorOfType<TopLevelVariableDeclaration>()!;
    }
    final source = _sourceOf(node);
    if (_helperSources.add(source)) {
      _helpers.add(source);
      _collectReferences(node);
    }
  }

  /// Records the helpers and imports that the code of [node] needs.
  void _collectReferences(AstNode node) {
    final unit = node.root as CompilationUnit;
    final fileUri = unit.declaredFragment!.source.uri;
    final collector = _ReferenceCollector();
    node.accept(collector);

    for (final MapEntry(key: prefix, value: names)
        in collector.prefixed.entries) {
      _addPrefixedImports(unit, fileUri, prefix, names);
    }

    for (final element in collector.elements) {
      final top = _topLevel(element);
      if (top == null) continue;
      final library = top.library;
      if (library == null || library.uri.toString() == 'dart:core') continue;
      final name = top.name;
      if (name == null || name.isEmpty) continue;

      if (top.isPrivate) {
        if (_seenHelpers.add(top)) _pendingHelpers.add(top);
        continue;
      }

      final local = localOverrides[name];
      if (local != null) {
        _localImports.add(local);
        continue;
      }
      if (_provided.contains(name)) continue;
      if (_exports(_publicLibraries.first, name, top)) continue;

      if (library.uri.isScheme('dart')) {
        _addImport(ImportSpec(uri: library.uri.toString(), show: {name}));
        continue;
      }
      final public = _publicLibraries.firstWhereOrNull(
        (l) => _exports(l, name, top),
      );
      if (public != null) {
        _addImport(ImportSpec(uri: public.uri.toString(), show: {name}));
        continue;
      }
      // Not public: use the import of the source file that provides the name,
      // with its configurations (conditional imports).
      final directive = unit.directives
          .whereType<ImportDirective>()
          .firstWhereOrNull(
            (d) =>
                d.prefix == null &&
                d.libraryImport?.importedLibrary != null &&
                _exports(d.libraryImport!.importedLibrary!, name, top),
          );
      if (directive == null) {
        // Declared in the source file itself.
        _addImport(ImportSpec(uri: library.uri.toString(), show: {name}));
        continue;
      }
      _addImport(
        ImportSpec(
          uri: _absolute(fileUri, directive.uri.stringValue!),
          configurations: _configurations(fileUri, directive),
          show: {name},
        ),
      );
    }
  }

  /// Adds the imports with [prefix] that [names] need, from the imports of
  /// [unit].
  void _addPrefixedImports(
    CompilationUnit unit,
    Uri fileUri,
    String prefix,
    Set<String> names,
  ) {
    final directives = unit.directives.whereType<ImportDirective>().where(
      (d) => d.prefix?.name == prefix,
    );
    for (final name in names) {
      final directive = directives.firstWhereOrNull(
        (d) => _importProvides(d, name),
      );
      if (directive == null) {
        throw ParseException('No import provides $prefix.$name in $fileUri');
      }
      _addImport(
        ImportSpec(
          uri: _absolute(fileUri, directive.uri.stringValue!),
          prefix: prefix,
          configurations: _configurations(fileUri, directive),
          show: {name},
        ),
      );
    }
  }

  /// Whether the import [d] makes [name] visible.
  static bool _importProvides(ImportDirective d, String name) {
    final library = d.libraryImport?.importedLibrary;
    if (library == null || library.exportNamespace.get2(name) == null) {
      return false;
    }
    for (final c in d.combinators) {
      final names = switch (c) {
        ShowCombinator() => c.shownNames.map((n) => n.name),
        HideCombinator() => c.hiddenNames.map((n) => n.name),
      };
      if ((c is ShowCombinator) != names.contains(name)) return false;
    }
    return true;
  }

  void _addImport(ImportSpec spec) {
    final existing = _imports[spec.key];
    if (existing == null) {
      _imports[spec.key] = spec;
    } else if (existing.show.isEmpty || spec.show.isEmpty) {
      existing.show.clear();
    } else {
      existing.show.addAll(spec.show);
    }
  }

  List<String> _configurations(Uri fileUri, ImportDirective d) => [
    for (final c in d.configurations)
      "if (${c.name.toSource()}"
          "${c.value == null ? '' : ' == ${c.value!.toSource()}'}) "
          "'${_absolute(fileUri, c.uri.stringValue!)}'",
  ];

  static String _absolute(Uri base, String uri) => base.resolve(uri).toString();

  static bool _exports(LibraryElement library, String name, Element element) {
    final exported = library.exportNamespace.get2(name);
    return exported != null && _same(exported, element);
  }

  static bool _same(Element a, Element b) =>
      a.name == b.name && a.library?.uri == b.library?.uri;

  /// The library-level element that declares [element], or `null` for local
  /// elements.
  static Element? _topLevel(Element element) {
    Element? e = element;
    if (e is PropertyAccessorElement) {
      final variable = e.variable;
      if (variable is TopLevelVariableElement) e = variable;
    }
    while (e != null && e.enclosingElement is! LibraryElement) {
      if (e is LocalElement || e is FormalParameterElement) return null;
      e = e.enclosingElement;
    }
    return e;
  }

  Future<AstNode> _declaration(Element element) async {
    final library = element.library!;
    var resolved = _resolvedLibraries[library.uri];
    if (resolved == null) {
      final result = await _context.currentSession.getResolvedLibraryByElement(
        library,
      );
      if (result is! ResolvedLibraryResult) {
        throw ParseException('Cannot resolve ${library.uri}: $result');
      }
      resolved = result;
      _resolvedLibraries[library.uri] = resolved;
    }
    final declaration = resolved.getFragmentDeclaration(element.firstFragment);
    if (declaration == null) {
      throw ParseException('No declaration for $element in ${library.uri}');
    }
    return declaration.node;
  }

  /// The source text of [node], with its documentation comment.
  static String _sourceOf(AstNode node) {
    final unit = node.root as CompilationUnit;
    final content = unit.declaredFragment!.source.contents.data;
    return content.substring(node.offset, node.end);
  }

  final _classes = <Class>[];
  final _forkedClasses = <ForkedClass>[];
  final _helpers = <String>[];
  final _helperSources = <String>{};
  final _seenHelpers = <Element>{};
  final _pendingHelpers = <Element>[];
  final _imports = <String, ImportSpec>{};
  final _localImports = <String>{};
  final _provided = <String>{};
  final _publicLibraries = <LibraryElement>[];
  final _resolvedLibraries = <Uri, ResolvedLibraryResult>{};
  final AnalysisContext _context;

  static AnalysisContext _createAnalysisContext({required String path}) {
    final collection = AnalysisContextCollection(includedPaths: <String>[path]);
    final contexts = collection.contexts;
    if (contexts.length != 1) {
      throw ArgumentError('path must be an absolute path to a single file');
    }
    return contexts[0];
  }
}

/// Collects the elements that code needs in scope, and the names it uses with
/// an import prefix. Skips documentation comments: a name there needs no
/// import.
class _ReferenceCollector extends RecursiveAstVisitor<void> {
  final elements = <Element>{};

  /// Import prefix to the names used with it.
  final prefixed = <String, Set<String>>{};

  void _addPrefixed(String prefix, String name) =>
      (prefixed[prefix] ??= <String>{}).add(name);

  @override
  void visitComment(Comment node) {}

  @override
  void visitPrefixedIdentifier(PrefixedIdentifier node) {
    if (node.prefix.element is PrefixElement) {
      _addPrefixed(node.prefix.name, node.identifier.name);
      return;
    }
    super.visitPrefixedIdentifier(node);
  }

  @override
  void visitMethodInvocation(MethodInvocation node) {
    final target = node.target;
    if (target is SimpleIdentifier && target.element is PrefixElement) {
      _addPrefixed(target.name, node.methodName.name);
      node.typeArguments?.accept(this);
      node.argumentList.accept(this);
      return;
    }
    super.visitMethodInvocation(node);
  }

  @override
  void visitNamedType(NamedType node) {
    final prefix = node.importPrefix;
    if (prefix != null) {
      _addPrefixed(prefix.name.lexeme, node.name.lexeme);
    } else if (node.element case final element?) {
      elements.add(element);
    }
    node.typeArguments?.accept(this);
  }

  @override
  void visitSimpleIdentifier(SimpleIdentifier node) {
    final element = node.element;
    if (element == null ||
        element is PrefixElement ||
        node.inDeclarationContext()) {
      return;
    }
    final enclosing = element.enclosingElement;
    if (enclosing is ExtensionElement) {
      // An extension member, also when used as `x.member`: the extension must
      // be in scope.
      elements.add(enclosing);
    } else if (enclosing is InterfaceElement) {
      // A member: its class comes in by name where the code names it.
    } else {
      elements.add(element);
    }
  }
}
