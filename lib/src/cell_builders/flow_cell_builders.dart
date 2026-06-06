import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../theme/flow_table_theme.dart';
import '../widgets/flow_avatar.dart';
import '../widgets/flow_dropdown_cell.dart';
import '../widgets/flow_status_badge.dart';

/// Pre-built cell widgets that preserve the original table look and feel.
abstract final class FlowCells {
  /// Simple text cell.
  static Widget text(
    BuildContext context,
    String value, {
    FlowTableTheme theme = FlowTableTheme.defaults,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    return Text(
      value,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow ?? TextOverflow.ellipsis,
      style: theme.bodyStyle(context, fontWeight: fontWeight),
    );
  }

  /// Avatar with title and subtitle (e.g. user name + email).
  static Widget avatarWithSubtitle(
    BuildContext context, {
    required String title,
    required String subtitle,
    FlowTableTheme theme = FlowTableTheme.defaults,
    String? imageUrl,
    double avatarRadius = 16,
    double avatarFontSize = 14,
  }) {
    return Row(
      children: [
        FlowAvatar(
          name: title,
          radius: avatarRadius,
          fontSize: avatarFontSize,
          imageUrl: imageUrl,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: theme.bodyStyle(context, fontWeight: FontWeight.bold)
                    .copyWith(fontSize: 14),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                overflow: TextOverflow.ellipsis,
                style: theme.subtitleStyle(context),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Colored status pill badge.
  static Widget badge(
    BuildContext context,
    String label, {
    FlowTableTheme theme = FlowTableTheme.defaults,
    FlowBadgeStyle? style,
    Map<String, FlowBadgeStyle>? styleMap,
  }) {
    return FlowStatusBadge(
      label: label,
      theme: theme,
      style: style,
      styleMap: styleMap,
    );
  }

  /// Icon with text (e.g. tasks completed).
  static Widget iconWithText(
    BuildContext context, {
    required IconData icon,
    required String text,
    FlowTableTheme theme = FlowTableTheme.defaults,
    Color? iconColor,
    FontWeight? fontWeight,
  }) {
    final isDark = theme.isDark(context);
    return Row(
      children: [
        Icon(
          icon,
          size: 14,
          color: iconColor ?? Colors.green[500],
        ),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            style: theme.bodyStyle(context, fontWeight: fontWeight ?? FontWeight.w600)
                .copyWith(
              color: isDark ? Colors.grey[300] : Colors.grey[700],
            ),
          ),
        ),
      ],
    );
  }

  /// Dot indicator with text (e.g. online status).
  static Widget dotWithText(
    BuildContext context, {
    required String text,
    required bool isActive,
    FlowTableTheme theme = FlowTableTheme.defaults,
    Color? activeColor,
    Color? inactiveColor,
  }) {
    return Row(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: isActive
                ? (activeColor ?? Colors.green)
                : (inactiveColor ?? Colors.grey),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            style: theme.bodyStyle(context),
          ),
        ),
      ],
    );
  }

  /// Surface-style inline dropdown cell (e.g. editable role per row).
  static Widget dropdown(
    BuildContext context, {
    required String value,
    required List<String> options,
    ValueChanged<String>? onChanged,
    FlowTableTheme theme = FlowTableTheme.defaults,
    IconData icon = LucideIcons.chevronDown,
  }) {
    return FlowDropdownCell(
      value: value,
      options: options,
      onChanged: onChanged,
      theme: theme,
      icon: icon,
    );
  }

  /// Default actions menu button.
  static Widget actionsButton({
    required VoidCallback? onPressed,
    IconData icon = LucideIcons.ellipsis,
    double iconSize = 18,
  }) {
    return IconButton(
      icon: Icon(icon, size: iconSize),
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      onPressed: onPressed,
    );
  }
}
