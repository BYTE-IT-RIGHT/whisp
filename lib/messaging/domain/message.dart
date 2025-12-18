import 'package:flick/contacts_library/domain/contact.dart';

class Message {
  final String id;
  final Contact sender;
  final String content;
  final DateTime timestamp;
  final MessageType type;

  Message({
    required this.id,
    required this.sender,
    required this.content,
    required this.timestamp,
    this.type = MessageType.text,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id:
          json['id'] as String? ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      sender: Contact.fromJson(json['sender']),
      content: json['content'] as String,
      timestamp: json['timestamp'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['timestamp'] as int)
          : DateTime.now(),
      type: MessageType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => MessageType.text,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sender': sender.toJson(),
      'content': content,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'type': type.name,
    };
  }
}

enum MessageType { text, contactRequest, contactAccepted, ping }
