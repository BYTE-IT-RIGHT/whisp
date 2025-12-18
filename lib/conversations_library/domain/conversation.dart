import 'package:flick/conversations_library/domain/contact.dart';
import 'package:flick/messaging/domain/message.dart';

class Conversation {
  final Contact contact;
  final Message? lastMessage;

  Conversation({required this.contact, this.lastMessage});

  /// Returns the timestamp of the last message, or null if no messages
  DateTime? get lastActivityAt => lastMessage?.timestamp;
}
