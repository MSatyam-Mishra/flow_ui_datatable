import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../theme/flow_table_theme.dart';

/// Inline surface-style dropdown for editable table cells (e.g. role, status).
class FlowDropdownCell extends StatelessWidget {
  const FlowDropdownCell({
    super.key,
    required this.value,
    required this.options,
    required this.theme,
    this.onChanged,
    this.icon = LucideIcons.chevronDown,
    this.borderRadius = 6,
    this.isDense = true,
    this.isPlain = false,
  });

  final String value;
  final List<String> options;
  final FlowTableTheme theme;
  final ValueChanged<String>? onChanged;
  final IconData icon;
  final double borderRadius;
  final bool isDense;

  /// Whether to render the dropdown cell without the button border,
  /// background, or minimum width constraints (acting as plain text with a chevron down icon).
  final bool isPlain;

  @override
  Widget build(BuildContext context) {
    final isDark = theme.isDark(context);
    final borderColor = theme.borderColor(context);
    final surfaceColor = isDark
        ? Colors.white.withValues(alpha: 0.04)
        : Colors.black.withValues(alpha: 0.03);
    final enabled = onChanged != null && options.length > 1;

    return MenuAnchor(
      alignmentOffset: const Offset(0, 6),
      style: MenuStyle(
        elevation: const WidgetStatePropertyAll(6),
        surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
        backgroundColor: WidgetStatePropertyAll(theme.cellBgColor(context)),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: borderColor),
          ),
        ),
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(vertical: 4),
        ),
      ),
      builder: (context, controller, child) {
        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: enabled
                ? () {
                    if (controller.isOpen) {
                      controller.close();
                    } else {
                      controller.open();
                    }
                  }
                : null,
            borderRadius: BorderRadius.circular(borderRadius),
            child: Container(
              constraints: isPlain ? null : const BoxConstraints(minWidth: 88),
              padding: isPlain
                  ? EdgeInsets.zero
                  : EdgeInsets.symmetric(
                      horizontal: isDense ? 8 : 10,
                      vertical: isDense ? 4 : 6,
                    ),
              decoration: isPlain
                  ? null
                  : BoxDecoration(
                      color: surfaceColor,
                      borderRadius: BorderRadius.circular(borderRadius),
                      border: Border.all(
                        color: enabled
                            ? borderColor
                            : borderColor.withValues(alpha: 0.6),
                      ),
                    ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      value,
                      overflow: TextOverflow.ellipsis,
                      style: theme.bodyStyle(
                        context,
                        fontWeight: isPlain ? null : FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    icon,
                    size: 14,
                    color: theme.secondaryTextColor(context),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      menuChildren: options
          .map(
            (option) => MenuItemButton(
              onPressed: onChanged == null
                  ? null
                  : () {
                      if (option != value) onChanged!(option);
                    },
              style: ButtonStyle(
                padding: const WidgetStatePropertyAll(
                  EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                foregroundColor: WidgetStateProperty.resolveWith((states) {
                  if (option == value) {
                    return theme.primaryTextColor(context);
                  }
                  return theme.secondaryTextColor(context);
                }),
                backgroundColor: WidgetStateProperty.resolveWith((states) {
                  if (option == value) {
                    return isDark
                        ? Colors.white.withValues(alpha: 0.06)
                        : Colors.black.withValues(alpha: 0.04);
                  }
                  return Colors.transparent;
                }),
              ),
              trailingIcon: option == value
                  ? Icon(
                      LucideIcons.check,
                      size: 14,
                      color: theme.primaryTextColor(context),
                    )
                  : null,
              child: Text(option, style: theme.bodyStyle(context)),
            ),
          )
          .toList(),
    );
  }
}
