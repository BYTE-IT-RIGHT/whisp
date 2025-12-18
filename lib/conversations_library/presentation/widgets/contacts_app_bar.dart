import 'package:whisp/theme/domain/whisp_theme.dart';
import 'package:flutter/material.dart';

class ContactsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ContactsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(title: Text('Contacts'),
    backgroundColor: context.whispTheme.background,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
