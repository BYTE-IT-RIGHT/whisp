import 'package:flutter/material.dart';
import 'package:whisp/theme/domain/whisp_theme.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final WhispTheme theme;

  const SectionHeader({super.key, required this.title, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Text(title, style: theme.h5);
  }
}

