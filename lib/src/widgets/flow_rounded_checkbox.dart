import 'package:flutter/widgets.dart';

/// Rounded checkbox used by [FlowDataTable] selection column.
///
/// Implemented using basic widgets ([AnimatedContainer] and [CustomPaint])
/// to allow use in environments without a Material Design ancestor.
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
    final isSelected = value == true;
    final isIndeterminate = value == null;
    final hasOnChanged = onChanged != null;

    final resolvedBorder = borderColor ?? const Color(0xFF9CA3AF); // grey[400]
    final resolvedActive = activeColor ?? const Color(0xFF4F46E5); // Indigo 600

    Widget inner;
    if (isSelected) {
      inner = CustomPaint(
        size: Size(size * 0.6, size * 0.6),
        painter: _CheckPainter(color: const Color(0xFFFFFFFF), isIndeterminate: false),
      );
    } else if (isIndeterminate) {
      inner = CustomPaint(
        size: Size(size * 0.6, size * 0.6),
        painter: _CheckPainter(color: const Color(0xFFFFFFFF), isIndeterminate: true),
      );
    } else {
      inner = const SizedBox();
    }

    final box = AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: (isSelected || isIndeterminate) ? resolvedActive : const Color(0x00000000),
        border: Border.all(
          color: (isSelected || isIndeterminate) ? resolvedActive : resolvedBorder,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      alignment: Alignment.center,
      child: inner,
    );

    if (!hasOnChanged) {
      return box;
    }

    return GestureDetector(
      onTap: () {
        if (value == null || value == false) {
          onChanged!(true);
        } else {
          onChanged!(false);
        }
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: box,
      ),
    );
  }
}

class _CheckPainter extends CustomPainter {
  const _CheckPainter({required this.color, required this.isIndeterminate});

  final Color color;
  final bool isIndeterminate;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    if (isIndeterminate) {
      // Draw a horizontal line in the middle
      canvas.drawLine(
        Offset(size.width * 0.2, size.height * 0.5),
        Offset(size.width * 0.8, size.height * 0.5),
        paint,
      );
    } else {
      // Draw a checkmark
      final path = Path()
        ..moveTo(size.width * 0.15, size.height * 0.45)
        ..lineTo(size.width * 0.42, size.height * 0.72)
        ..lineTo(size.width * 0.85, size.height * 0.22);
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _CheckPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.isIndeterminate != isIndeterminate;
  }
}
