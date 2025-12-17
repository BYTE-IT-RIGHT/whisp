import 'package:auto_route/auto_route.dart';
import 'package:flick/common/widgets/styled_scaffold.dart';
import 'package:flick/navigation/navigation.gr.dart';
import 'package:flick/theme/domain/flick_theme.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ContactsLibraryScreen extends StatelessWidget {
  const ContactsLibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StyledScaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushRoute(AddContactRoute()),
        backgroundColor: context.flickTheme.primary,
        child: Icon(Icons.add),
      ),
    );
  }
}
