import 'package:flutter/widgets.dart';

import '../theme/flow_table_theme.dart';

/// Spreadsheet-style cell with hover highlight and subtle scale animation.
class FlowInteractiveCell extends StatefulWidget {
  const FlowInteractiveCell({
    super.key,
    required this.child,
    required this.theme,
    required this.brightness,
    this.alignment = Alignment.centerLeft,
    this.baseBgColor,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
  });

  final Widget child;
  final FlowTableTheme theme;
  final Brightness brightness;
  final AlignmentGeometry alignment;
  final Color? baseBgColor;
  final VoidCallback? onTap;
  final VoidCallback? onDoubleTap;
  final VoidCallback? onLongPress;

  @override
  State<FlowInteractiveCell> createState() => _FlowInteractiveCellState();
}

class _FlowInteractiveCellState extends State<FlowInteractiveCell> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final hoverColor = widget.theme.hoverOverlay(context);

    Widget result = AnimatedContainer(
      duration: widget.theme.hoverAnimationDuration,
      height: widget.theme.rowHeight,
      padding: EdgeInsets.symmetric(
        horizontal: widget.theme.cellHorizontalPadding,
      ),
      alignment: widget.alignment,
      decoration: BoxDecoration(
        color: _isHovered
            ? hoverColor
            : (widget.baseBgColor ?? const Color(0x00000000)),
      ),
      child: AnimatedScale(
        scale: _isHovered ? widget.theme.hoverScale : 1.0,
        duration: widget.theme.hoverAnimationDuration,
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );

    final hasTap =
        widget.onTap != null ||
        widget.onDoubleTap != null ||
        widget.onLongPress != null;

    if (hasTap) {
      result = GestureDetector(
        onTap: widget.onTap,
        onDoubleTap: widget.onDoubleTap,
        onLongPress: widget.onLongPress,
        child: MouseRegion(cursor: SystemMouseCursors.click, child: result),
      );
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: result,
    );
  }
}
