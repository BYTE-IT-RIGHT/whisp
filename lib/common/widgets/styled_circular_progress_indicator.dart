import 'package:flick/theme/domain/flick_theme.dart';
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
        color: context.flickTheme.primary,
        backgroundColor: context.flickTheme.stroke,
        strokeWidth: 3,
      ),
    );
  }
}
