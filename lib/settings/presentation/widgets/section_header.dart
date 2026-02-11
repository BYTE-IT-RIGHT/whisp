import 'package:flutter/material.dart';
import 'package:whisp/theme/domain/whisp_theme.dart';

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(title, style: context.whispTheme.h5);
  }
}
