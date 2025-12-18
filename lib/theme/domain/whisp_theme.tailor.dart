// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'whisp_theme.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$WhispThemeTailorMixin
    on ThemeExtension<WhispTheme>, DiagnosticableTreeMixin {
  Color get background;
  Color get secondary;
  Color get contrast;
  Color get primary;
  Color get stroke;
  TextStyle get h1;
  TextStyle get h2;
  TextStyle get h3;
  TextStyle get h4;
  TextStyle get h5;
  TextStyle get h6;
  TextStyle get subtitle;
  TextStyle get lead;
  TextStyle get overline;
  TextStyle get body;
  TextStyle get small;
  TextStyle get caption;
  TextStyle get label;
  TextStyle get button;

  @override
  WhispTheme copyWith({
    Color? background,
    Color? secondary,
    Color? contrast,
    Color? primary,
    Color? stroke,
    TextStyle? h1,
    TextStyle? h2,
    TextStyle? h3,
    TextStyle? h4,
    TextStyle? h5,
    TextStyle? h6,
    TextStyle? subtitle,
    TextStyle? lead,
    TextStyle? overline,
    TextStyle? body,
    TextStyle? small,
    TextStyle? caption,
    TextStyle? label,
    TextStyle? button,
  }) {
    return WhispTheme(
      background: background ?? this.background,
      secondary: secondary ?? this.secondary,
      contrast: contrast ?? this.contrast,
      primary: primary ?? this.primary,
      stroke: stroke ?? this.stroke,
      h1: h1 ?? this.h1,
      h2: h2 ?? this.h2,
      h3: h3 ?? this.h3,
      h4: h4 ?? this.h4,
      h5: h5 ?? this.h5,
      h6: h6 ?? this.h6,
      subtitle: subtitle ?? this.subtitle,
      lead: lead ?? this.lead,
      overline: overline ?? this.overline,
      body: body ?? this.body,
      small: small ?? this.small,
      caption: caption ?? this.caption,
      label: label ?? this.label,
      button: button ?? this.button,
    );
  }

  @override
  WhispTheme lerp(covariant ThemeExtension<WhispTheme>? other, double t) {
    if (other is! WhispTheme) return this as WhispTheme;
    return WhispTheme(
      background: Color.lerp(background, other.background, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      contrast: Color.lerp(contrast, other.contrast, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      stroke: Color.lerp(stroke, other.stroke, t)!,
      h1: TextStyle.lerp(h1, other.h1, t)!,
      h2: TextStyle.lerp(h2, other.h2, t)!,
      h3: TextStyle.lerp(h3, other.h3, t)!,
      h4: TextStyle.lerp(h4, other.h4, t)!,
      h5: TextStyle.lerp(h5, other.h5, t)!,
      h6: TextStyle.lerp(h6, other.h6, t)!,
      subtitle: TextStyle.lerp(subtitle, other.subtitle, t)!,
      lead: TextStyle.lerp(lead, other.lead, t)!,
      overline: TextStyle.lerp(overline, other.overline, t)!,
      body: TextStyle.lerp(body, other.body, t)!,
      small: TextStyle.lerp(small, other.small, t)!,
      caption: TextStyle.lerp(caption, other.caption, t)!,
      label: TextStyle.lerp(label, other.label, t)!,
      button: TextStyle.lerp(button, other.button, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WhispTheme &&
            const DeepCollectionEquality().equals(
              background,
              other.background,
            ) &&
            const DeepCollectionEquality().equals(secondary, other.secondary) &&
            const DeepCollectionEquality().equals(contrast, other.contrast) &&
            const DeepCollectionEquality().equals(primary, other.primary) &&
            const DeepCollectionEquality().equals(stroke, other.stroke) &&
            const DeepCollectionEquality().equals(h1, other.h1) &&
            const DeepCollectionEquality().equals(h2, other.h2) &&
            const DeepCollectionEquality().equals(h3, other.h3) &&
            const DeepCollectionEquality().equals(h4, other.h4) &&
            const DeepCollectionEquality().equals(h5, other.h5) &&
            const DeepCollectionEquality().equals(h6, other.h6) &&
            const DeepCollectionEquality().equals(subtitle, other.subtitle) &&
            const DeepCollectionEquality().equals(lead, other.lead) &&
            const DeepCollectionEquality().equals(overline, other.overline) &&
            const DeepCollectionEquality().equals(body, other.body) &&
            const DeepCollectionEquality().equals(small, other.small) &&
            const DeepCollectionEquality().equals(caption, other.caption) &&
            const DeepCollectionEquality().equals(label, other.label) &&
            const DeepCollectionEquality().equals(button, other.button));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(background),
      const DeepCollectionEquality().hash(secondary),
      const DeepCollectionEquality().hash(contrast),
      const DeepCollectionEquality().hash(primary),
      const DeepCollectionEquality().hash(stroke),
      const DeepCollectionEquality().hash(h1),
      const DeepCollectionEquality().hash(h2),
      const DeepCollectionEquality().hash(h3),
      const DeepCollectionEquality().hash(h4),
      const DeepCollectionEquality().hash(h5),
      const DeepCollectionEquality().hash(h6),
      const DeepCollectionEquality().hash(subtitle),
      const DeepCollectionEquality().hash(lead),
      const DeepCollectionEquality().hash(overline),
      const DeepCollectionEquality().hash(body),
      const DeepCollectionEquality().hash(small),
      const DeepCollectionEquality().hash(caption),
      const DeepCollectionEquality().hash(label),
      const DeepCollectionEquality().hash(button),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'WhispTheme'))
      ..add(DiagnosticsProperty('background', background))
      ..add(DiagnosticsProperty('secondary', secondary))
      ..add(DiagnosticsProperty('contrast', contrast))
      ..add(DiagnosticsProperty('primary', primary))
      ..add(DiagnosticsProperty('stroke', stroke))
      ..add(DiagnosticsProperty('h1', h1))
      ..add(DiagnosticsProperty('h2', h2))
      ..add(DiagnosticsProperty('h3', h3))
      ..add(DiagnosticsProperty('h4', h4))
      ..add(DiagnosticsProperty('h5', h5))
      ..add(DiagnosticsProperty('h6', h6))
      ..add(DiagnosticsProperty('subtitle', subtitle))
      ..add(DiagnosticsProperty('lead', lead))
      ..add(DiagnosticsProperty('overline', overline))
      ..add(DiagnosticsProperty('body', body))
      ..add(DiagnosticsProperty('small', small))
      ..add(DiagnosticsProperty('caption', caption))
      ..add(DiagnosticsProperty('label', label))
      ..add(DiagnosticsProperty('button', button));
  }
}

extension WhispThemeBuildContext on BuildContext {
  WhispTheme get whispTheme => Theme.of(this).extension<WhispTheme>()!;
}
