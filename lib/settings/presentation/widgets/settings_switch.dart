import 'package:flutter/material.dart';
import 'package:whisp/theme/domain/whisp_theme.dart';

class SettingsSwitch extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const SettingsSwitch({
    super.key,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.whispTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: theme.secondary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.stroke),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: theme.subtitle),
                const SizedBox(height: 2),
                Text(subtitle, style: theme.caption),
              ],
            ),
          ),
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeThumbColor: theme.primary,
          ),
        ],
      ),
    );
  }
}
