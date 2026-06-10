import 'package:flutter/widgets.dart';

/// Visual styling for [FlowDataTable]. Defaults match the original spreadsheet UI.
class FlowTableTheme {
  const FlowTableTheme({
    this.fontFamily = 'Inter',
    this.borderRadius = 8,
    this.rowHeight = 56,
    this.headerHeight = 38,
    this.cellHorizontalPadding = 12,
    this.headerFontSize = 13,
    this.bodyFontSize = 13,
    this.subtitleFontSize = 12,
    this.badgeFontSize = 11,
    this.hoverAnimationDuration = const Duration(milliseconds: 150),
    this.hoverScale = 1.05,
    this.lightBorderColor,
    this.darkBorderColor,
    this.lightHeaderBgColor,
    this.darkHeaderBgColor,
    this.lightIndexBgColor,
    this.darkIndexBgColor,
    this.lightCellBgColor,
    this.darkCellBgColor,
    this.lightHoverOverlay,
    this.darkHoverOverlay,
    this.lightHeaderTextColor,
    this.darkHeaderTextColor,
    this.lightPrimaryTextColor,
    this.darkPrimaryTextColor,
    this.lightSecondaryTextColor,
    this.darkSecondaryTextColor,
    this.lightIndexTextColor,
    this.darkIndexTextColor,
  });

  final String fontFamily;
  final double borderRadius;
  final double rowHeight;
  final double headerHeight;
  final double cellHorizontalPadding;
  final double headerFontSize;
  final double bodyFontSize;
  final double subtitleFontSize;
  final double badgeFontSize;
  final Duration hoverAnimationDuration;
  final double hoverScale;

  final Color? lightBorderColor;
  final Color? darkBorderColor;
  final Color? lightHeaderBgColor;
  final Color? darkHeaderBgColor;
  final Color? lightIndexBgColor;
  final Color? darkIndexBgColor;
  final Color? lightCellBgColor;
  final Color? darkCellBgColor;
  final Color? lightHoverOverlay;
  final Color? darkHoverOverlay;
  final Color? lightHeaderTextColor;
  final Color? darkHeaderTextColor;
  final Color? lightPrimaryTextColor;
  final Color? darkPrimaryTextColor;
  final Color? lightSecondaryTextColor;
  final Color? darkSecondaryTextColor;
  final Color? lightIndexTextColor;
  final Color? darkIndexTextColor;

  bool isDark(BuildContext context) {
    final mediaQuery = MediaQuery.maybeOf(context);
    if (mediaQuery != null) {
      return mediaQuery.platformBrightness == Brightness.dark;
    }
    return false;
  }

  Brightness brightness(BuildContext context) =>
      isDark(context) ? Brightness.dark : Brightness.light;

  Color borderColor(BuildContext context) {
    final isDark = this.isDark(context);
    return isDark
        ? (darkBorderColor ?? const Color(0xFF1F2937))
        : (lightBorderColor ?? const Color(0xFFD1D5DB));
  }

  Color headerBgColor(BuildContext context) {
    final isDark = this.isDark(context);
    return isDark
        ? (darkHeaderBgColor ?? const Color(0xFF111827))
        : (lightHeaderBgColor ?? const Color(0xFFF9FAFB));
  }

  Color indexBgColor(BuildContext context) {
    final isDark = this.isDark(context);
    return isDark
        ? (darkIndexBgColor ?? const Color(0xFF111827))
        : (lightIndexBgColor ?? const Color(0xFFF9FAFB));
  }

  Color cellBgColor(BuildContext context) {
    final isDark = this.isDark(context);
    return isDark
        ? (darkCellBgColor ?? const Color(0xFF0F0F0F))
        : (lightCellBgColor ?? const Color(0xFFFFFFFF));
  }

  Color hoverOverlay(BuildContext context) {
    final isDark = this.isDark(context);
    return isDark
        ? (darkHoverOverlay ?? const Color(0x0FFFFFFF))
        : (lightHoverOverlay ?? const Color(0x0A000000));
  }

  Color headerTextColor(BuildContext context) {
    final isDark = this.isDark(context);
    return isDark
        ? (darkHeaderTextColor ?? const Color(0xFFD1D5DB))
        : (lightHeaderTextColor ?? const Color(0xFF374151));
  }

  Color primaryTextColor(BuildContext context) {
    final isDark = this.isDark(context);
    return isDark
        ? (darkPrimaryTextColor ?? const Color(0xFFF3F4F6))
        : (lightPrimaryTextColor ?? const Color(0xFF111827));
  }

  Color secondaryTextColor(BuildContext context) {
    final isDark = this.isDark(context);
    return isDark
        ? (darkSecondaryTextColor ?? const Color(0xFF9CA3AF))
        : (lightSecondaryTextColor ?? const Color(0xFF4B5563));
  }

  Color indexTextColor(BuildContext context) {
    final isDark = this.isDark(context);
    return isDark
        ? (darkIndexTextColor ?? const Color(0xFF9CA3AF))
        : (lightIndexTextColor ?? const Color(0xFF4B5563));
  }

  TextStyle headerStyle(BuildContext context) => TextStyle(
    fontFamily: fontFamily,
    fontSize: headerFontSize,
    fontWeight: FontWeight.w600,
    color: headerTextColor(context),
  );

  TextStyle bodyStyle(BuildContext context, {FontWeight? fontWeight}) =>
      TextStyle(
        fontFamily: fontFamily,
        fontSize: bodyFontSize,
        fontWeight: fontWeight,
        color: primaryTextColor(context),
      );

  TextStyle subtitleStyle(BuildContext context) => TextStyle(
    fontFamily: fontFamily,
    fontSize: subtitleFontSize,
    color: secondaryTextColor(context),
  );

  TextStyle indexStyle(BuildContext context) => TextStyle(
    fontFamily: fontFamily,
    fontSize: bodyFontSize,
    color: indexTextColor(context),
    fontWeight: FontWeight.bold,
  );

  static const FlowTableTheme defaults = FlowTableTheme();
}
