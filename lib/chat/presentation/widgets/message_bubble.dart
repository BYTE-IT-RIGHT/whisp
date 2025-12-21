import 'package:whisp/messaging/domain/message.dart';
import 'package:whisp/theme/domain/whisp_theme.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final Message message;
  final bool isOwnMessage;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isOwnMessage,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.whispTheme;

    return Align(
      alignment: isOwnMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        margin: EdgeInsets.only(
          left: isOwnMessage ? 48 : 12,
          right: isOwnMessage ? 12 : 48,
          top: 4,
          bottom: 4,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isOwnMessage ? theme.primary : theme.secondary,
          borderRadius: BorderRadius.only(
            bottomLeft: const Radius.circular(18),
            bottomRight: const Radius.circular(18),
            topLeft: Radius.circular(isOwnMessage ? 18 : 4),
            topRight: Radius.circular(isOwnMessage ? 4 : 18),
          ),
        ),
        child: Column(
          crossAxisAlignment: isOwnMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(message.content, style: theme.body),
            const SizedBox(height: 4),
            Text(_formatTime(message.timestamp), style: theme.caption),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime timestamp) {
    final hour = timestamp.hour.toString().padLeft(2, '0');
    final minute = timestamp.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
