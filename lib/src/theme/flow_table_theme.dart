import 'package:flutter/material.dart';

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

  bool isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  Brightness brightness(BuildContext context) =>
      isDark(context) ? Brightness.dark : Brightness.light;

  Color borderColor(BuildContext context) {
    final isDark = this.isDark(context);
    return isDark
        ? (darkBorderColor ?? Colors.grey[800]!)
        : (lightBorderColor ?? Colors.grey[300]!);
  }

  Color headerBgColor(BuildContext context) {
    final isDark = this.isDark(context);
    return isDark
        ? (darkHeaderBgColor ?? Colors.grey[900]!)
        : (lightHeaderBgColor ?? Colors.grey[50]!);
  }

  Color indexBgColor(BuildContext context) {
    final isDark = this.isDark(context);
    return isDark
        ? (darkIndexBgColor ?? Colors.grey[900]!)
        : (lightIndexBgColor ?? Colors.grey[50]!);
  }

  Color cellBgColor(BuildContext context) {
    final isDark = this.isDark(context);
    return isDark
        ? (darkCellBgColor ?? const Color(0xFF0F0F0F))
        : (lightCellBgColor ?? Colors.white);
  }

  Color hoverOverlay(BuildContext context) {
    final isDark = this.isDark(context);
    return isDark
        ? (darkHoverOverlay ?? Colors.white.withValues(alpha: 0.06))
        : (lightHoverOverlay ?? Colors.black.withValues(alpha: 0.04));
  }

  Color headerTextColor(BuildContext context) {
    final isDark = this.isDark(context);
    return isDark
        ? (darkHeaderTextColor ?? Colors.grey[300]!)
        : (lightHeaderTextColor ?? Colors.grey[700]!);
  }

  Color primaryTextColor(BuildContext context) {
    final isDark = this.isDark(context);
    return isDark
        ? (darkPrimaryTextColor ?? Colors.grey[100]!)
        : (lightPrimaryTextColor ?? Colors.grey[900]!);
  }

  Color secondaryTextColor(BuildContext context) {
    final isDark = this.isDark(context);
    return isDark
        ? (darkSecondaryTextColor ?? Colors.grey[400]!)
        : (lightSecondaryTextColor ?? Colors.grey[600]!);
  }

  Color indexTextColor(BuildContext context) {
    final isDark = this.isDark(context);
    return isDark
        ? (darkIndexTextColor ?? Colors.grey[400]!)
        : (lightIndexTextColor ?? Colors.grey[600]!);
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
