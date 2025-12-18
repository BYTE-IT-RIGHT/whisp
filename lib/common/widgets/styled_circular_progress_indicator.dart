import 'package:whisp/theme/domain/whisp_theme.dart';
import 'package:flutter/material.dart';

class StyledCircularProgressIndicator extends StatelessWidget {
  final double? size;
  const StyledCircularProgressIndicator({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: CircularProgressIndicator(
        color: context.whispTheme.primary,
        backgroundColor: context.whispTheme.stroke,
        strokeWidth: 3,
      ),
    );
  }
}
