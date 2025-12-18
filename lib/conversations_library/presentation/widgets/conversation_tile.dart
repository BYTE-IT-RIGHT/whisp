import 'package:auto_route/auto_route.dart';
import 'package:flick/conversations_library/domain/conversation.dart';
import 'package:flick/navigation/navigation.gr.dart';
import 'package:flick/theme/domain/flick_theme.dart';
import 'package:flutter/material.dart';

class ConversationTile extends StatelessWidget {
  final Conversation conversation;
  const ConversationTile({super.key, required this.conversation});

  @override
  Widget build(BuildContext context) {
    final lastMessage = conversation.lastMessage;

    return ListTile(
      onTap: () => context.pushRoute(ChatRoute(contact: conversation.contact)),
      leading: CircleAvatar(
        backgroundColor: context.flickTheme.primary,
        child: Text(
          conversation.contact.username[0].toUpperCase(),
          style: context.flickTheme.body,
        ),
      ),
      title: Text(
        conversation.contact.username,
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: lastMessage != null
          ? Text(
              lastMessage.content,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.flickTheme.caption,
            )
          : null,
      trailing: lastMessage != null
          ? Text(
              _formatTime(lastMessage.timestamp),
              style: context.flickTheme.caption,
            )
          : null,
    );
  }

  String _formatTime(DateTime timestamp) {
    final now = DateTime.now();
    final diff = now.difference(timestamp);

    if (diff.inDays > 0) {
      return '${diff.inDays}d';
    } else if (diff.inHours > 0) {
      return '${diff.inHours}h';
    } else if (diff.inMinutes > 0) {
      return '${diff.inMinutes}m';
    }
    return 'now';
  }
}
