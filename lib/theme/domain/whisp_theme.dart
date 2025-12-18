import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'whisp_theme.tailor.dart';

// Light theme colors
const _lightBackground = Colors.white;
const _lightPrimary = Color(0xff8D35EB);
const _lightStroke = Color(0xff2D2D44);
const _lightTextColor = Color(0xFF000000);
const _lightSecondary = Color(0xffF5F5F7);
const _lightContrast = Color(0xff4BB543);

// Dark theme colors
const _darkBackground = Color(0xFF121212);
const _darkPrimary = Color(0xff8D35EB);
const _darkTextColor = Color(0xFFFFFFFF);
const _darkStroke = Color(0xff1F2937);
const _darkSecondary = Color(0xff1E1E1E);
const _darkContrast = Color(0xff4BB543);

final lightWhispTheme = WhispTheme(
  background: _lightBackground,
  primary: _lightPrimary,
  stroke: _lightStroke,
  secondary: _lightSecondary,
  contrast: _lightContrast,
  // Headings
  h1: TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.w700,
    color: _lightTextColor,
  ),
  h2: TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: _lightTextColor,
  ),
  h3: TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: _lightTextColor,
  ),
  h4: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: _lightTextColor,
  ),
  h5: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: _lightTextColor,
  ),
  h6: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: _lightTextColor,
  ),
  // Text styles
  subtitle: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: _lightTextColor,
  ),
  lead: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: _lightTextColor,
  ),
  overline: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: _lightTextColor,
    letterSpacing: 1.2,
  ),
  body: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: _lightTextColor,
  ),
  small: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: _lightTextColor,
  ),
  caption: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: _lightTextColor.withValues(alpha: 0.7),
  ),
  label: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: _lightTextColor,
  ),
  button: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: _lightTextColor,
  ),
);

final darkWhispTheme = WhispTheme(
  background: _darkBackground,
  primary: _darkPrimary,
  stroke: _darkStroke,
  secondary: _darkSecondary,
  contrast: _darkContrast,
  // Headings
  h1: TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.w700,
    color: _darkTextColor,
  ),
  h2: TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: _darkTextColor,
  ),
  h3: TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: _darkTextColor,
  ),
  h4: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: _darkTextColor,
  ),
  h5: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: _darkTextColor,
  ),
  h6: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: _darkTextColor,
  ),
  // Text styles
  subtitle: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: _darkTextColor,
  ),
  lead: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: _darkTextColor,
  ),
  overline: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: _darkTextColor,
    letterSpacing: 1.2,
  ),
  body: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: _darkTextColor,
  ),
  small: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: _darkTextColor,
  ),
  caption: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: _darkTextColor.withValues(alpha: 0.7),
  ),
  label: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: _darkTextColor,
  ),
  button: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: _darkTextColor,
  ),
);

@TailorMixin(themeGetter: ThemeGetter.onBuildContext)
class WhispTheme extends ThemeExtension<WhispTheme>
    with DiagnosticableTreeMixin, _$WhispThemeTailorMixin {
  const WhispTheme({
    required this.primary,
    required this.background,
    required this.contrast,
    required this.secondary,
    required this.stroke,
    required this.h1,
    required this.h2,
    required this.h3,
    required this.h4,
    required this.h5,
    required this.h6,
    required this.subtitle,
    required this.lead,
    required this.overline,
    required this.body,
    required this.small,
    required this.caption,
    required this.label,
    required this.button,
  });

  // Colors
  @override
  final Color background;
  @override
  final Color secondary;
  @override
  final Color contrast;
  @override
  final Color primary;
  @override
  final Color stroke;

  // Headings
  @override
  final TextStyle h1;
  @override
  final TextStyle h2;
  @override
  final TextStyle h3;
  @override
  final TextStyle h4;
  @override
  final TextStyle h5;
  @override
  final TextStyle h6;

  // Text styles
  @override
  final TextStyle subtitle;
  @override
  final TextStyle lead;
  @override
  final TextStyle overline;
  @override
  final TextStyle body;
  @override
  final TextStyle small;
  @override
  final TextStyle caption;
  @override
  final TextStyle label;
  @override
  final TextStyle button;
}
