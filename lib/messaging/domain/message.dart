import 'package:whisp/conversations_library/domain/contact.dart';
import 'package:whisp/encryption/domain/i_signal_service.dart';

class Message {
  final String id;
  final Contact sender;
  final String content;
  final DateTime timestamp;
  final MessageType type;
  final EncryptedMessageData? encryptedData;

  Message({
    required this.id,
    required this.sender,
    required this.content,
    required this.timestamp,
    this.type = MessageType.text,
    this.encryptedData,
  });

  static DateTime _timestampFromJson(dynamic value) {
    if (value == null) return DateTime.now();
    if (value is int) return DateTime.fromMillisecondsSinceEpoch(value);
    if (value is String) {
      final parsed = DateTime.tryParse(value);
      if (parsed != null) return parsed;
    }
    return DateTime.now();
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id:
          json['id'] as String? ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      sender: Contact.fromJson(
        Map<String, dynamic>.from(json['sender'] as Map),
      ),
      content: json['content'] as String? ?? '',
      timestamp: _timestampFromJson(json['timestamp']),
      type: MessageType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => MessageType.text,
      ),
      encryptedData: json['encrypted'] != null
          ? EncryptedMessageData.fromJson(
              json['encrypted'] as Map<String, dynamic>,
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sender': sender.toJson(),
      'content': content,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'type': type.name,
      if (encryptedData != null) 'encrypted': encryptedData!.toJson(),
    };
  }

  Message copyWithDecryptedContent(String decryptedContent) {
    return Message(
      id: id,
      sender: sender,
      content: decryptedContent,
      timestamp: timestamp,
      type: type,
      encryptedData: null,
    );
  }

  Message copyWithEncryptedData(EncryptedMessageData encrypted) {
    return Message(
      id: id,
      sender: sender,
      content: '',
      timestamp: timestamp,
      type: type,
      encryptedData: encrypted,
    );
  }
}

enum MessageType {
  text,
  contactRequest,
  contactAccepted,
  contactDeclined,
  ping,
}
