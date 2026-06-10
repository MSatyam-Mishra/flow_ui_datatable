import 'package:flutter/widgets.dart';

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
          backgroundColor: const Color(0x2610B981), // green with 0.15 opacity
          textColor: const Color(0xFF047857), // green[700]
        );
      case 'pending':
      case 'warning':
        return FlowBadgeStyle(
          backgroundColor: const Color(0x26F59E0B), // orange with 0.15 opacity
          textColor: const Color(0xFFB45309), // orange[700]
        );
      case 'inactive':
      case 'offline':
      case 'error':
        return FlowBadgeStyle(
          backgroundColor: const Color(0x269CA3AF), // grey with 0.15 opacity
          textColor: const Color(0xFF374151), // grey[700]
        );
      default:
        return FlowBadgeStyle(
          backgroundColor: const Color(0x263B82F6), // blue with 0.15 opacity
          textColor: const Color(0xFF1D4ED8), // blue[700]
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
