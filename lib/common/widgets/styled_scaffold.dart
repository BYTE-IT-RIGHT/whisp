import 'package:flick/theme/domain/flick_theme.dart';
import 'package:flutter/material.dart';

class StyledScaffold extends StatelessWidget {
  final Widget? body;
  final Widget? floatingActionButton;
  final PreferredSizeWidget? appBar;
  const StyledScaffold({
    super.key,
    this.body,
    this.floatingActionButton,
    this.appBar,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: appBar,
        backgroundColor: context.flickTheme.background,
        body: body,
        floatingActionButton: floatingActionButton,
      ),
    );
  }
}
