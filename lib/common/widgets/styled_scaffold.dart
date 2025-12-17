import 'package:flick/theme/domain/flick_theme.dart';
import 'package:flutter/material.dart';

class StyledScaffold extends StatelessWidget {
  final Widget? body;
  final Widget? floatingActionButton;
  const StyledScaffold({super.key, this.body, this.floatingActionButton});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.flickTheme.background,
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
