import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../models/flow_pagination.dart';
import '../theme/flow_table_theme.dart';

class FlowTablePaginationBar extends StatelessWidget {
  const FlowTablePaginationBar({
    super.key,
    required this.pagination,
    required this.theme,
  });

  final FlowPagination pagination;
  final FlowTableTheme theme;

  @override
  Widget build(BuildContext context) {
    final borderColor = theme.borderColor(context);
    final isDark = theme.isDark(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: theme.headerBgColor(context),
        border: Border(
          top: BorderSide(color: borderColor),
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(theme.borderRadius),
          bottomRight: Radius.circular(theme.borderRadius),
        ),
      ),
      child: Row(
        children: [
          Flexible(
            child: Text(
              'Showing ${pagination.startIndex + 1}-${pagination.endIndex} of ${pagination.totalItems}',
              overflow: TextOverflow.ellipsis,
              style: theme.bodyStyle(context).copyWith(
                    fontSize: 12,
                    color: theme.secondaryTextColor(context),
                  ),
            ),
          ),
          const SizedBox(width: 12),
          if (pagination.showPageSizeSelector &&
              pagination.onPageSizeChanged != null) ...[
            Text(
              'Rows per page',
              style: theme.bodyStyle(context).copyWith(fontSize: 12),
            ),
            const SizedBox(width: 8),
            _PageSizeDropdown(
              value: pagination.pageSize,
              options: pagination.effectivePageSizeOptions,
              onChanged: pagination.onPageSizeChanged!,
              theme: theme,
            ),
            const SizedBox(width: 16),
          ],
          _PaginationButton(
            icon: LucideIcons.chevronLeft,
            enabled: pagination.hasPrevious,
            onPressed: pagination.hasPrevious
                ? () => pagination.onPageChanged?.call(pagination.currentPage - 1)
                : null,
            theme: theme,
            isDark: isDark,
          ),
          const SizedBox(width: 4),
          Text(
            '${pagination.currentPage} / ${pagination.totalPages}',
            style: theme.bodyStyle(context).copyWith(fontSize: 12),
          ),
          const SizedBox(width: 4),
          _PaginationButton(
            icon: LucideIcons.chevronRight,
            enabled: pagination.hasNext,
            onPressed: pagination.hasNext
                ? () => pagination.onPageChanged?.call(pagination.currentPage + 1)
                : null,
            theme: theme,
            isDark: isDark,
          ),
        ],
      ),
    );
  }
}

class _PageSizeDropdown extends StatelessWidget {
  const _PageSizeDropdown({
    required this.value,
    required this.options,
    required this.onChanged,
    required this.theme,
  });

  final int value;
  final List<int> options;
  final ValueChanged<int> onChanged;
  final FlowTableTheme theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(color: theme.borderColor(context)),
        borderRadius: BorderRadius.circular(6),
        color: theme.cellBgColor(context),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: value,
          isDense: true,
          style: theme.bodyStyle(context).copyWith(fontSize: 12),
          items: options
              .map(
                (size) => DropdownMenuItem(
                  value: size,
                  child: Text('$size'),
                ),
              )
              .toList(),
          onChanged: (v) {
            if (v != null) onChanged(v);
          },
        ),
      ),
    );
  }
}

class _PaginationButton extends StatelessWidget {
  const _PaginationButton({
    required this.icon,
    required this.enabled,
    required this.onPressed,
    required this.theme,
    required this.isDark,
  });

  final IconData icon;
  final bool enabled;
  final VoidCallback? onPressed;
  final FlowTableTheme theme;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        icon,
        size: 18,
        color: enabled
            ? theme.primaryTextColor(context)
            : (isDark ? Colors.grey[700] : Colors.grey[400]),
      ),
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
      onPressed: onPressed,
    );
  }
}
