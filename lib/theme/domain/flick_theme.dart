import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'flick_theme.tailor.dart';

final lightFlickTheme = FlickTheme(background: Colors.white, h1: TextStyle());
final darkFlickTheme = FlickTheme(
  background: Color(0xFF0A0A0F),
  h1: TextStyle(),
);

@TailorMixin(themeGetter: ThemeGetter.onBuildContext)
class FlickTheme extends ThemeExtension<FlickTheme>
    with DiagnosticableTreeMixin, _$FlickThemeTailorMixin {
  const FlickTheme({required this.background, required this.h1});

  @override
  final Color background;

  @override
  final TextStyle h1;
}
