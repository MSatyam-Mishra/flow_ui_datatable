import 'package:flutter/widgets.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../theme/flow_table_theme.dart';

/// Inline surface-style dropdown for editable table cells (e.g. role, status).
///
/// Refactored to use [Overlay] and [CompositedTransformFollower] to operate
/// independently of the Material library.
class FlowDropdownCell extends StatefulWidget {
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
  State<FlowDropdownCell> createState() => _FlowDropdownCellState();
}

class _FlowDropdownCellState extends State<FlowDropdownCell> {
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
            // Tap out detector to close menu when tapping outside
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: _closeMenu,
              child: const SizedBox.expand(),
            ),
            Positioned(
              width: 140, // Standard dropdown cell width
              child: CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: Offset(0, widget.theme.rowHeight * 0.75),
                child: Container(
                  decoration: BoxDecoration(
                    color: menuBgColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: borderColor),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF000000).withValues(alpha: isDark ? 0.3 : 0.08),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
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
                          if (widget.onChanged != null && option != widget.value) {
                            widget.onChanged!(option);
                          }
                        },
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
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
                                    option,
                                    style: widget.theme.bodyStyle(context).copyWith(
                                          color: isSelected
                                              ? widget.theme.primaryTextColor(context)
                                              : widget.theme.secondaryTextColor(context),
                                        ),
                                  ),
                                ),
                                if (isSelected)
                                  Icon(
                                    LucideIcons.check,
                                    size: 14,
                                    color: widget.theme.primaryTextColor(context),
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
    final isDark = widget.theme.isDark(context);
    final borderColor = widget.theme.borderColor(context);
    final surfaceColor = isDark
        ? const Color(0xFFFFFFFF).withValues(alpha: 0.04)
        : const Color(0xFF000000).withValues(alpha: 0.03);
    final enabled = widget.onChanged != null && widget.options.length > 1;

    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: enabled ? _toggleMenu : null,
        child: MouseRegion(
          cursor: enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
          child: Container(
            constraints: widget.isPlain ? null : const BoxConstraints(minWidth: 88),
            padding: widget.isPlain
                ? EdgeInsets.zero
                : EdgeInsets.symmetric(
                    horizontal: widget.isDense ? 8 : 10,
                    vertical: widget.isDense ? 4 : 6,
                  ),
            decoration: widget.isPlain
                ? null
                : BoxDecoration(
                    color: surfaceColor,
                    borderRadius: BorderRadius.circular(widget.borderRadius),
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
                    widget.value,
                    overflow: TextOverflow.ellipsis,
                    style: widget.theme.bodyStyle(
                      context,
                      fontWeight: widget.isPlain ? null : FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  widget.icon,
                  size: 14,
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
