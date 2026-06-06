import 'package:flutter/material.dart';
import 'package:highlight/highlight.dart' show highlight;

/// Token colors inspired by Atom One Dark / Light themes.
class DartSyntaxColors {
  const DartSyntaxColors({
    required this.background,
    required this.foreground,
    required this.keyword,
    required this.string,
    required this.number,
    required this.className,
    required this.function,
    required this.type,
    required this.comment,
    required this.punctuation,
    required this.meta,
    required this.variable,
    required this.gutter,
    required this.border,
  });

  final Color background;
  final Color foreground;
  final Color keyword;
  final Color string;
  final Color number;
  final Color className;
  final Color function;
  final Color type;
  final Color comment;
  final Color punctuation;
  final Color meta;
  final Color variable;
  final Color gutter;
  final Color border;

  factory DartSyntaxColors.dark() => const DartSyntaxColors(
        background: Color(0xFF282C34),
        foreground: Color(0xFFABB2BF),
        keyword: Color(0xFFC678DD),
        string: Color(0xFF98C379),
        number: Color(0xFFD19A66),
        className: Color(0xFFE6C07B),
        function: Color(0xFF61AFEF),
        type: Color(0xFFE6C07B),
        comment: Color(0xFF5C6370),
        punctuation: Color(0xFFABB2BF),
        meta: Color(0xFF61AFEF),
        variable: Color(0xFFE06C75),
        gutter: Color(0xFF5C6370),
        border: Color(0xFF3E4451),
      );

  factory DartSyntaxColors.light() => const DartSyntaxColors(
        background: Color(0xFFFAFAFA),
        foreground: Color(0xFF383A42),
        keyword: Color(0xFFA626A4),
        string: Color(0xFF50A14F),
        number: Color(0xFF986801),
        className: Color(0xFFC18401),
        function: Color(0xFF4078F2),
        type: Color(0xFFC18401),
        comment: Color(0xFFA0A1A7),
        punctuation: Color(0xFF383A42),
        meta: Color(0xFF4078F2),
        variable: Color(0xFFE45649),
        gutter: Color(0xFF9CA3AF),
        border: Color(0xFFE1E4E8),
      );

  Color forClass(String? tokenClass) {
    if (tokenClass == null || tokenClass.isEmpty) return foreground;
    final classes = tokenClass.split(' ');
    for (final cls in classes) {
      switch (cls) {
        case 'keyword':
          return keyword;
        case 'string':
        case 'literal':
          return string;
        case 'number':
          return number;
        case 'class':
        case 'title.class':
        case 'title.class.inherited':
          return className;
        case 'function':
        case 'title.function':
          return function;
        case 'type':
        case 'title':
        case 'built_in':
          return type;
        case 'comment':
        case 'quote':
          return comment;
        case 'punctuation':
        case 'operator':
        case 'params':
          return punctuation;
        case 'meta':
        case 'meta.keyword':
          return meta;
        case 'variable':
        case 'variable.language':
        case 'property':
          return variable;
        case 'name':
          return foreground;
      }
    }
    return foreground;
  }
}

List<TextSpan> buildHighlightedDartSpans(
  String code,
  DartSyntaxColors colors, {
  double fontSize = 12,
  double height = 1.6,
}) {
  final baseStyle = TextStyle(
    fontFamily: 'monospace',
    fontSize: fontSize,
    height: height,
    color: colors.foreground,
  );

  try {
    final result = highlight.parse(code, language: 'dart');
    final spans = <TextSpan>[];

    void walk(dynamic node) {
      if (node.value != null) {
        spans.add(
          TextSpan(
            text: node.value as String,
            style: baseStyle.copyWith(
              color: colors.forClass(node.className as String?),
            ),
          ),
        );
      }
      final children = node.children;
      if (children != null) {
        for (final child in children) {
          walk(child);
        }
      }
    }

    walk(result);
    return spans;
  } catch (_) {
    return [TextSpan(text: code, style: baseStyle)];
  }
}
