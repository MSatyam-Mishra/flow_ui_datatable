import 'package:flutter/material.dart';

import '../theme/flow_table_theme.dart';

/// Color mapping for a status badge label.
class FlowBadgeStyle {
  const FlowBadgeStyle({
    required this.backgroundColor,
    required this.textColor,
  });

  final Color backgroundColor;
  final Color textColor;
}

/// Pill-shaped status badge matching the original table design.
class FlowStatusBadge extends StatelessWidget {
  const FlowStatusBadge({
    super.key,
    required this.label,
    required this.theme,
    this.style,
    this.styleMap,
  });

  final String label;
  final FlowTableTheme theme;
  final FlowBadgeStyle? style;
  final Map<String, FlowBadgeStyle>? styleMap;

  FlowBadgeStyle _resolveStyle() {
    if (style != null) return style!;
    if (styleMap != null && styleMap!.containsKey(label)) {
      return styleMap![label]!;
    }

    switch (label.toLowerCase()) {
      case 'active':
      case 'online':
      case 'success':
        return FlowBadgeStyle(
          backgroundColor: Colors.green.withValues(alpha: 0.15),
          textColor: Colors.green[700]!,
        );
      case 'pending':
      case 'warning':
        return FlowBadgeStyle(
          backgroundColor: Colors.orange.withValues(alpha: 0.15),
          textColor: Colors.orange[700]!,
        );
      case 'inactive':
      case 'offline':
      case 'error':
        return FlowBadgeStyle(
          backgroundColor: Colors.grey.withValues(alpha: 0.15),
          textColor: Colors.grey[700]!,
        );
      default:
        return FlowBadgeStyle(
          backgroundColor: Colors.blue.withValues(alpha: 0.15),
          textColor: Colors.blue[700]!,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final resolved = _resolveStyle();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: resolved.backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: theme.fontFamily,
          fontSize: theme.badgeFontSize,
          fontWeight: FontWeight.bold,
          color: resolved.textColor,
        ),
      ),
    );
  }
}
