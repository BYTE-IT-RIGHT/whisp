import 'package:flutter/material.dart';
import 'package:whisp/theme/domain/whisp_theme.dart';

class TutorialPage extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color accentColor;
  final String learnMoreUrl;
  final bool isComingSoon;
  final bool isWarning;

  const TutorialPage({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.accentColor,
    required this.learnMoreUrl,
    this.isComingSoon = false,
    this.isWarning = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.whispTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
              border: Border.all(
                color: accentColor.withValues(alpha: 0.3),
                width: 2,
              ),
            ),
            child: Icon(icon, size: 56, color: accentColor),
          ),

          const SizedBox(height: 40),

          if (isComingSoon || isWarning)
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: accentColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                isComingSoon ? 'COMING SOON' : 'IMPORTANT',
                style: theme.overline.copyWith(
                  color: accentColor,
                  fontSize: 10,
                ),
              ),
            ),

          Text(title, style: theme.h4, textAlign: TextAlign.center),

          const SizedBox(height: 16),

          Text(
            description,
            style: theme.body.copyWith(
              color: theme.body.color?.withValues(alpha: 0.7),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
