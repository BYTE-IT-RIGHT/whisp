import 'package:flutter/material.dart';
import 'package:whisp/theme/domain/whisp_theme.dart';

class AnimatedGradientBackground extends StatefulWidget {
  final WhispTheme theme;
  const AnimatedGradientBackground({super.key, required this.theme});

  @override
  State<AnimatedGradientBackground> createState() =>
      _AnimatedGradientBackgroundState();
}

class _AnimatedGradientBackgroundState extends State<AnimatedGradientBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment(
                -0.5 + _controller.value * 1.0,
                -0.3 + _controller.value * 0.6,
              ),
              radius: 1.5,
              colors: [
                widget.theme.primary.withOpacity(0.15),
                widget.theme.background,
              ],
            ),
          ),
        );
      },
    );
  }
}

