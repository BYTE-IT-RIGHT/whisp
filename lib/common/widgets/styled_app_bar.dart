import 'package:flutter/material.dart';
import 'package:whisp/theme/domain/whisp_theme.dart';

class StyledAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  const StyledAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.actions,
    this.bottom,
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: titleWidget ?? (title != null ? Text(title!) : null),
      backgroundColor: context.whispTheme.background,
      notificationPredicate: (_) => false,
      centerTitle: true,
      actions: actions,
      bottom: bottom,
    );
  }
}
