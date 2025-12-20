import 'package:whisp/theme/domain/whisp_theme.dart';
import 'package:flutter/material.dart';

class StyledCircularProgressIndicator extends StatelessWidget {
  final double? size;
  final Color? color;
  final Color? backgroundColor;
  final double? strokeWidth;
  final double? value;
  const StyledCircularProgressIndicator({
    super.key,
    this.size,
    this.color,
    this.backgroundColor,
    this.strokeWidth,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: CircularProgressIndicator(
        value: value,
        color: color ?? context.whispTheme.primary,
        backgroundColor: backgroundColor ?? context.whispTheme.stroke,
        strokeWidth: strokeWidth ?? 3,
      ),
    );
  }
}
