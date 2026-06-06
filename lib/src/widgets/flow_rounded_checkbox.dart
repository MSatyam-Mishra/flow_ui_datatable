import 'package:flutter/material.dart';

/// Rounded checkbox used by [FlowDataTable] selection column.
class FlowRoundedCheckbox extends StatelessWidget {
  const FlowRoundedCheckbox({
    super.key,
    required this.value,
    this.onChanged,
    this.borderRadius = 6,
    this.size = 18,
    this.activeColor,
    this.borderColor,
  });

  final bool? value;
  final ValueChanged<bool?>? onChanged;
  final double borderRadius;
  final double size;
  final Color? activeColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final resolvedBorder = borderColor ??
        (isDark ? Colors.grey[600]! : Colors.grey[400]!);
    final resolvedActive = activeColor ?? theme.colorScheme.primary;

    return SizedBox(
      width: size,
      height: size,
      child: Checkbox(
        value: value,
        onChanged: onChanged,
        tristate: true,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        side: WidgetStateBorderSide.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return BorderSide(color: resolvedActive, width: 1.5);
          }
          if (states.contains(WidgetState.disabled)) {
            return BorderSide(
              color: resolvedBorder.withValues(alpha: 0.5),
              width: 1.5,
            );
          }
          return BorderSide(color: resolvedBorder, width: 1.5);
        }),
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return resolvedActive;
          }
          return Colors.transparent;
        }),
      ),
    );
  }
}
