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
  TextStyle get h1;

  @override
  FlickTheme copyWith({Color? background, TextStyle? h1}) {
    return FlickTheme(
      background: background ?? this.background,
      h1: h1 ?? this.h1,
    );
  }

  @override
  FlickTheme lerp(covariant ThemeExtension<FlickTheme>? other, double t) {
    if (other is! FlickTheme) return this as FlickTheme;
    return FlickTheme(
      background: Color.lerp(background, other.background, t)!,
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
            const DeepCollectionEquality().equals(h1, other.h1));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(background),
      const DeepCollectionEquality().hash(h1),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FlickTheme'))
      ..add(DiagnosticsProperty('background', background))
      ..add(DiagnosticsProperty('h1', h1));
  }
}

extension FlickThemeBuildContext on BuildContext {
  FlickTheme get flickTheme => Theme.of(this).extension<FlickTheme>()!;
}
