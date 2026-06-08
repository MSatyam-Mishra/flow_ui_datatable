import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'dart_syntax.dart';

class CodePanel extends StatelessWidget {
  const CodePanel({super.key, required this.code, this.language = 'dart'});

  final String code;
  final String language;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colors = isDark ? DartSyntaxColors.dark() : DartSyntaxColors.light();
    final lines = code.split('\n');
    const lineHeight = 20.8;
    const fontSize = 12.0;

    return Container(
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 8, 10),
            child: Row(
              children: [
                _WindowDot(color: Colors.red[400]!),
                const SizedBox(width: 6),
                _WindowDot(color: Colors.amber[400]!),
                const SizedBox(width: 6),
                _WindowDot(color: Colors.green[400]!),
                const SizedBox(width: 16),
                Text(
                  language.toUpperCase(),
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: colors.gutter,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.8,
                  ),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: code));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Code copied to clipboard'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  icon: Icon(
                    LucideIcons.copy,
                    size: 15,
                    color: theme.colorScheme.primary,
                  ),
                  label: Text(
                    'Copy',
                    style: TextStyle(color: theme.colorScheme.primary),
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: colors.border),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: List.generate(
                        lines.length,
                        (index) => SizedBox(
                          height: lineHeight,
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: fontSize,
                              height: 1.6,
                              color: colors.gutter,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 1,
                    height: lines.length * lineHeight,
                    color: colors.border,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: lines.map((line) {
                        return SizedBox(
                          height: lineHeight,
                          width: double.infinity,
                          child: SelectableText.rich(
                            TextSpan(
                              children: language == 'dart'
                                  ? buildHighlightedDartSpans(
                                      line.isEmpty ? ' ' : line,
                                      colors,
                                      fontSize: fontSize,
                                    )
                                  : [
                                      TextSpan(
                                        text: line.isEmpty ? ' ' : line,
                                        style: TextStyle(
                                          fontFamily: 'monospace',
                                          fontSize: fontSize,
                                          height: 1.6,
                                          color: colors.foreground,
                                        ),
                                      ),
                                    ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WindowDot extends StatelessWidget {
  const _WindowDot({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
