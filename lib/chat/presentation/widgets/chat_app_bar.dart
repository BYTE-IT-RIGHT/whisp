import 'package:flick/common/widgets/profile_image.dart';
import 'package:flick/conversations_library/domain/contact.dart';
import 'package:flick/theme/domain/flick_theme.dart';
import 'package:flutter/material.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Contact contact;
  final bool isOnline;

  const ChatAppBar({super.key, required this.contact, this.isOnline = false});

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
                Row(
                  children: [
                    Text(contact.username, style: context.flickTheme.h6),
                    const SizedBox(width: 8),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: 1.0,
                      child: Text(
                        isOnline ? 'Online' : 'Offline',
                        style: TextStyle(
                          color: isOnline ? theme.contrast : Colors.grey,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: 4,
                  children: [
                    Badge(
                      backgroundColor: isOnline ? theme.contrast : theme.stroke,
                    ),
                    Text(
                      'P2P ${isOnline ? 'Connected' : 'Disconnected'}',
                      style: theme.caption,
                    ),
                  ],
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
