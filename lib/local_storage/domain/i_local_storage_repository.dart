import 'package:whisp/authentication/domain/user.dart';
import 'package:whisp/conversations_library/domain/contact.dart';
import 'package:whisp/messaging/domain/message.dart';
import 'package:flutter/material.dart';

class MessagePage {
  final List<Message> messages;
  final bool hasMore;
  final DateTime? nextCursor;

  MessagePage({required this.messages, required this.hasMore, this.nextCursor});
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
  Future<Contact?> getContactByOnionAddress(String onionAddress);
  bool getLocalAuthEnabled();
  Future<void> setLocalAuthEnabled(bool enabled);
  bool getRequireAuthenticationOnPause();
  Future<void> setRequireAuthenticationOnPause(
    bool requireAuthenticationOnPause,
  );

  Future<void> saveMessage(String conversationId, Message message);
  Future<MessagePage> getMessages(
    String conversationId, {
    int limit = 20,
    DateTime? before,
  });
  Stream<List<Message>> watchMessages(String conversationId);
  Future<Message?> getLastMessage(String conversationId);

  bool isTutorialCompleted();
  Future<void> setTutorialCompleted(bool completed);

  bool areNotificationsEnabled();
  Future<void> setNotificationsEnabled(bool enabled);
  bool isForegroundServiceEnabled();
  Future<void> setForegroundServiceEnabled(bool enabled);
  Future<void> updateUserProfile({String? username, String? avatarUrl});
  
  // PIN operations
  Future<bool> hasPin();
  Future<void> setPin(String pin);
  Future<bool> verifyPin(String pin);
}
