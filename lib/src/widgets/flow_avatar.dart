import 'package:flutter/widgets.dart';

/// Lightweight avatar with initials — used by [FlowCells.avatarWithSubtitle].
///
/// Implemented using standard [Container] and [BoxDecoration] widgets to remove
/// dependencies on the Material library's CircleAvatar.
class FlowAvatar extends StatelessWidget {
  const FlowAvatar({
    super.key,
    required this.name,
    this.radius = 16,
    this.fontSize = 14,
    this.backgroundColor,
    this.foregroundColor,
    this.imageUrl,
  });

  final String name;
  final double radius;
  final double fontSize;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final String? imageUrl;

  String get _initials {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) return '?';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }

  Color _colorFromName(String value) {
    final hash = value.codeUnits.fold(0, (prev, c) => prev + c);
    final colors = [
      const Color(0xFF6366F1),
      const Color(0xFF8B5CF6),
      const Color(0xFFEC4899),
      const Color(0xFF14B8A6),
      const Color(0xFFF59E0B),
      const Color(0xFF3B82F6),
      const Color(0xFF10B981),
    ];
    return colors[hash % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ?? _colorFromName(name);
    final fg = foregroundColor ?? const Color(0xFFFFFFFF);
    final size = radius * 2;

    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: NetworkImage(imageUrl!),
            fit: BoxFit.cover,
            onError: (exception, stackTrace) {},
          ),
        ),
      );
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: bg,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        _initials,
        style: TextStyle(
          color: fg,
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
