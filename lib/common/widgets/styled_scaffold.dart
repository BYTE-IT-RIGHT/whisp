import 'package:flick/theme/domain/flick_theme.dart';
import 'package:flutter/material.dart';

class StyledScaffold extends StatelessWidget {
  final Widget body;
  const StyledScaffold({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.flickTheme.background,
      body: body,
    );
  }
}
