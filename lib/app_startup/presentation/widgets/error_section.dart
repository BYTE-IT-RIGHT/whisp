import 'package:flutter/material.dart';
import 'package:whisp/app_startup/application/cubit/app_startup_cubit.dart';
import 'package:whisp/theme/domain/whisp_theme.dart';

class ErrorSection extends StatelessWidget {
  final AppStartupError state;
  final WhispTheme theme;

  const ErrorSection({
    super.key,
    required this.state,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.red.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.red.shade300,
            size: 48,
          ),
          const SizedBox(height: 16),
          const Text(
            'Connection Failed',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            state.message,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

