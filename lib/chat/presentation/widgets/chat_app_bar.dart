import 'package:auto_route/auto_route.dart';
import 'package:flick/common/widgets/profile_image.dart';
import 'package:flick/conversations_library/domain/contact.dart';
import 'package:flick/theme/domain/flick_theme.dart';
import 'package:flutter/material.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Contact contact;
  const ChatAppBar({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    final theme = context.flickTheme;
    return AppBar(
      backgroundColor: theme.background,
      elevation: 0,
      automaticallyImplyLeading: true,
      title: Row(
        children: [
          ProfileImage(contact: contact),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(contact.username, style: context.flickTheme.h6),
                Text(
                  'Encrypted',
                  style: TextStyle(color: theme.primary, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(30),
        child: Container(
          height: 30,
          decoration: BoxDecoration(color: theme.stroke),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  spacing: 8,
                  children: [
                    Icon(Icons.info_outline, color: theme.primary, size: 16),
                    Text(
                      'End-to-end encrypted via Tor network',
                      style: theme.caption,
                    ),
                  ],
                ),
                Icon(Icons.shield, color: theme.contrast, size: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 30);
}
