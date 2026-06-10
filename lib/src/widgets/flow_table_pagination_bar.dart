import 'package:flutter/widgets.dart';
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
        border: Border(top: BorderSide(color: borderColor)),
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
                ? () =>
                      pagination.onPageChanged?.call(pagination.currentPage - 1)
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
                ? () =>
                      pagination.onPageChanged?.call(pagination.currentPage + 1)
                : null,
            theme: theme,
            isDark: isDark,
          ),
        ],
      ),
    );
  }
}

class _PageSizeDropdown extends StatefulWidget {
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
  State<_PageSizeDropdown> createState() => _PageSizeDropdownState();
}

class _PageSizeDropdownState extends State<_PageSizeDropdown> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;

  void _toggleMenu() {
    if (_isOpen) {
      _closeMenu();
    } else {
      _openMenu();
    }
  }

  void _openMenu() {
    if (_overlayEntry != null) return;

    final overlay = Overlay.of(context);
    final isDark = widget.theme.isDark(context);
    final borderColor = widget.theme.borderColor(context);
    final menuBgColor = widget.theme.cellBgColor(context);

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: _closeMenu,
              child: const SizedBox.expand(),
            ),
            Positioned(
              width: 80,
              child: CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: const Offset(0, 32),
                child: Container(
                  decoration: BoxDecoration(
                    color: menuBgColor,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: borderColor),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF000000).withValues(alpha: isDark ? 0.3 : 0.08),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: widget.options.map((option) {
                      final isSelected = option == widget.value;
                      return GestureDetector(
                        onTap: () {
                          _closeMenu();
                          widget.onChanged(option);
                        },
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            color: isSelected
                                ? (isDark
                                    ? const Color(0xFFFFFFFF).withValues(alpha: 0.06)
                                    : const Color(0xFF000000).withValues(alpha: 0.04))
                                : const Color(0x00000000),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '$option',
                                    style: widget.theme.bodyStyle(context).copyWith(
                                          fontSize: 12,
                                          color: isSelected
                                              ? widget.theme.primaryTextColor(context)
                                              : widget.theme.secondaryTextColor(context),
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    overlay.insert(_overlayEntry!);
    setState(() {
      _isOpen = true;
    });
  }

  void _closeMenu({bool isDisposing = false}) {
    _overlayEntry?.remove();
    _overlayEntry = null;
    if (!isDisposing && mounted) {
      setState(() {
        _isOpen = false;
      });
    }
  }

  @override
  void dispose() {
    _closeMenu(isDisposing: true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _toggleMenu,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Container(
            height: 28,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              border: Border.all(color: widget.theme.borderColor(context)),
              borderRadius: BorderRadius.circular(6),
              color: widget.theme.cellBgColor(context),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${widget.value}',
                  style: widget.theme.bodyStyle(context).copyWith(fontSize: 12),
                ),
                const SizedBox(width: 4),
                Icon(
                  LucideIcons.chevronDown,
                  size: 12,
                  color: widget.theme.secondaryTextColor(context),
                ),
              ],
            ),
          ),
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
    final color = enabled
        ? theme.primaryTextColor(context)
        : (isDark ? const Color(0xFF374151) : const Color(0xFFD1D5DB)); // grey[700] : grey[300]

    Widget result = Container(
      width: 32,
      height: 32,
      alignment: Alignment.center,
      child: Icon(icon, size: 18, color: color),
    );

    if (enabled && onPressed != null) {
      result = GestureDetector(
        onTap: onPressed,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: result,
        ),
      );
    }

    return result;
  }
}
