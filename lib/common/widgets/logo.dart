import 'package:flick/theme/domain/flick_theme.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final double size;
  const Logo({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.flickTheme.primary,
        borderRadius: BorderRadius.circular(size / 2),
      ),
      child: Padding(
        padding: EdgeInsets.all(size / 3),
        child: Icon(Icons.offline_bolt, size: size),
      ),
    );
  }
}
