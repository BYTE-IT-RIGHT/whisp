import 'package:whisp/conversations_library/domain/conversation.dart';
import 'package:whisp/conversations_library/presentation/widgets/conversation_tile.dart';
import 'package:whisp/theme/domain/whisp_theme.dart';
import 'package:flutter/material.dart';

class ConversationsList extends StatelessWidget {
  final List<Conversation> conversations;
  const ConversationsList({super.key, required this.conversations});

  @override
  Widget build(BuildContext context) {
    if (conversations.isEmpty) {
      return Center(
        child: Text('No conversations yet', style: context.whispTheme.body),
      );
    }

    return ListView.separated(
      separatorBuilder: (context, index) =>
          Divider(color: context.whispTheme.stroke),
      itemCount: conversations.length,
      itemBuilder: (context, index) =>
          ConversationTile(conversation: conversations[index]),
    );
  }
}
