import 'package:whisp/authentication/domain/user.dart';
import 'package:whisp/conversations_library/domain/contact.dart';
import 'package:whisp/messaging/domain/message.dart';
import 'package:flutter/material.dart';

/// Pagination result for messages
class MessagePage {
  final List<Message> messages;
  final bool hasMore;
  final DateTime? nextCursor; // timestamp of oldest message for next page

  MessagePage({
    required this.messages,
    required this.hasMore,
    this.nextCursor,
  });
}

abstract class ILocalStorageRepository {
  Future<void> init();
  User? getUser();
  Future<void> setUser(User user);
  ThemeMode getThemeMode();
  Future<void> setThemeMode(ThemeMode themeMode);
  Future<void> addContact(Contact contact);
  Future<void> removeContact(Contact contact);
  Stream<List<Contact>> watchContacts();

  // Message operations with pagination
  Future<void> saveMessage(String conversationId, Message message);
  Future<MessagePage> getMessages(
    String conversationId, {
    int limit = 20,
    DateTime? before, // cursor: get messages before this timestamp
  });
  Stream<List<Message>> watchMessages(String conversationId);
  Future<Message?> getLastMessage(String conversationId);
}
