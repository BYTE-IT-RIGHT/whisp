import 'package:flick/theme/domain/flick_theme.dart';
import 'package:flutter/material.dart';

class ContactsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ContactsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(title: Text('Contacts'),
    backgroundColor: context.flickTheme.background,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
