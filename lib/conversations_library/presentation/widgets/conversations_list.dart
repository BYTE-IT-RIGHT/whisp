import 'package:flick/conversations_library/domain/conversation.dart';
import 'package:flick/conversations_library/presentation/widgets/conversation_tile.dart';
import 'package:flick/theme/domain/flick_theme.dart';
import 'package:flutter/material.dart';

class ConversationsList extends StatelessWidget {
  final List<Conversation> conversations;
  const ConversationsList({super.key, required this.conversations});

  @override
  Widget build(BuildContext context) {
    if (conversations.isEmpty) {
      return Center(
        child: Text('No conversations yet', style: context.flickTheme.body),
      );
    }

    return ListView.separated(
      separatorBuilder: (context, index) =>
          Divider(color: context.flickTheme.stroke),
      itemCount: conversations.length,
      itemBuilder: (context, index) =>
          ConversationTile(conversation: conversations[index]),
    );
  }
}
