import 'package:flick/conversations_library/domain/contact.dart';
import 'package:flick/theme/domain/flick_theme.dart';
import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final Contact contact;
  const ProfileImage({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 18,
      backgroundColor: context.flickTheme.primary,
      child: Text(
        contact.username[0].toUpperCase(),
        style: context.flickTheme.h6,
      ),
    );
  }
}
