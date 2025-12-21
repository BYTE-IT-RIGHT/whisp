import 'package:whisp/conversations_library/domain/contact.dart';
import 'package:whisp/encryption/domain/i_signal_service.dart';

class Message {
  final String id;
  final Contact sender;
  final String content;
  final DateTime timestamp;
  final MessageType type;
  
  /// Encrypted message data for E2E encryption
  /// When sending: this is populated before transmission
  /// When receiving: this contains the encrypted content to decrypt
  final EncryptedMessageData? encryptedData;

  Message({
    required this.id,
    required this.sender,
    required this.content,
    required this.timestamp,
    this.type = MessageType.text,
    this.encryptedData,
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
      encryptedData: json['encrypted'] != null 
          ? EncryptedMessageData.fromJson(json['encrypted'] as Map<String, dynamic>)
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

  /// Create a copy with decrypted content
  Message copyWithDecryptedContent(String decryptedContent) {
    return Message(
      id: id,
      sender: sender,
      content: decryptedContent,
      timestamp: timestamp,
      type: type,
      encryptedData: null, // Clear encrypted data after decryption
    );
  }

  /// Create a copy with encrypted data for transmission
  Message copyWithEncryptedData(EncryptedMessageData encrypted) {
    return Message(
      id: id,
      sender: sender,
      content: '', // Don't send plaintext over the wire
      timestamp: timestamp,
      type: type,
      encryptedData: encrypted,
    );
  }
}

enum MessageType { text, contactRequest, contactAccepted, contactDeclined, ping }
