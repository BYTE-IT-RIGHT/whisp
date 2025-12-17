// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'flick_theme.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$FlickThemeTailorMixin
    on ThemeExtension<FlickTheme>, DiagnosticableTreeMixin {
  Color get background;
  Color get primary;
  Color get stroke;
  TextStyle get h1;

  @override
  FlickTheme copyWith({
    Color? background,
    Color? primary,
    Color? stroke,
    TextStyle? h1,
  }) {
    return FlickTheme(
      background: background ?? this.background,
      primary: primary ?? this.primary,
      stroke: stroke ?? this.stroke,
      h1: h1 ?? this.h1,
    );
  }

  @override
  FlickTheme lerp(covariant ThemeExtension<FlickTheme>? other, double t) {
    if (other is! FlickTheme) return this as FlickTheme;
    return FlickTheme(
      background: Color.lerp(background, other.background, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      stroke: Color.lerp(stroke, other.stroke, t)!,
      h1: TextStyle.lerp(h1, other.h1, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FlickTheme &&
            const DeepCollectionEquality().equals(
              background,
              other.background,
            ) &&
            const DeepCollectionEquality().equals(primary, other.primary) &&
            const DeepCollectionEquality().equals(stroke, other.stroke) &&
            const DeepCollectionEquality().equals(h1, other.h1));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(background),
      const DeepCollectionEquality().hash(primary),
      const DeepCollectionEquality().hash(stroke),
      const DeepCollectionEquality().hash(h1),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FlickTheme'))
      ..add(DiagnosticsProperty('background', background))
      ..add(DiagnosticsProperty('primary', primary))
      ..add(DiagnosticsProperty('stroke', stroke))
      ..add(DiagnosticsProperty('h1', h1));
  }
}

extension FlickThemeBuildContext on BuildContext {
  FlickTheme get flickTheme => Theme.of(this).extension<FlickTheme>()!;
}
