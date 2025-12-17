import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'flick_theme.tailor.dart';

final lightFlickTheme = FlickTheme(
  background: Colors.white,
  primary: Color(0xff8D35EB),
  stroke: Color(0xff2D2D44),
  h1: TextStyle(),
);
final darkFlickTheme = FlickTheme(
  background: Color(0xFF0A0A0F),
  primary: Color(0xff8D35EB),
  stroke: Color(0xff2D2D44),
  h1: TextStyle(),
);

@TailorMixin(themeGetter: ThemeGetter.onBuildContext)
class FlickTheme extends ThemeExtension<FlickTheme>
    with DiagnosticableTreeMixin, _$FlickThemeTailorMixin {
  const FlickTheme({
    required this.primary,
    required this.background,
    required this.stroke,
    required this.h1,
  });

  @override
  final Color background;

  @override
  final Color primary;

  @override
  final Color stroke;

  @override
  final TextStyle h1;
}
