import 'dart:async';
import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:drift/drift.dart';
import 'package:whisp/authentication/domain/user.dart';
import 'package:whisp/conversations_library/domain/contact.dart';
import 'package:whisp/local_storage/domain/hive_registrar.g.dart';
import 'package:whisp/local_storage/domain/i_local_storage_repository.dart';
import 'package:whisp/local_storage/infrastructure/messages_database.dart';
import 'package:whisp/messaging/domain/message.dart' as domain;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

enum _Key { AES_KEY, USER, THEME, CONTACTS }

@LazySingleton(as: ILocalStorageRepository)
class LocalStorageRepository implements ILocalStorageRepository {
  final _secureStorage = FlutterSecureStorage();
  late final Box _box;
  late final MessagesDatabase _messagesDb;
  late final SecretKey _secretKey;

  @override
  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapters();
    
    _messagesDb = MessagesDatabase();
    
    final results = await Future.wait([
      _getOrCreateAesKey(),
      Hive.openBox('flick'),
    ]);
    _secretKey = results[0] as SecretKey;
    _box = results[1] as Box;
  }

  Future<SecretKey> _getOrCreateAesKey() async {
    String? encodedKey = await _secureStorage.read(key: _Key.AES_KEY.name);
    if (encodedKey != null) {
      final keyBytes = base64Decode(encodedKey);
      return SecretKey(keyBytes);
    }

    final algorithm = AesGcm.with256bits();
    final secretKey = await algorithm.newSecretKey();

    final keyBytes = await secretKey.extractBytes();
    await _secureStorage.write(
      key: _Key.AES_KEY.name,
      value: base64Encode(keyBytes),
    );

    return secretKey;
  }

  @override
  User? getUser() => _box.get(_Key.USER.name);

  @override
  Future<void> setUser(User user) => _box.put(_Key.USER.name, user);

  @override
  ThemeMode getThemeMode() =>
      _box.get(_Key.THEME.name, defaultValue: ThemeMode.light);

  @override
  Future<void> setThemeMode(ThemeMode themeMode) =>
      _box.put(_Key.THEME.name, themeMode);

  @override
  Future<void> addContact(Contact contact) async {
    final data = (_box.get(_Key.CONTACTS.name) as List?) ?? [];
    final contacts = data.cast<Contact>();
    final encryptedContact = await contact.encrypt(_secretKey);
    contacts.add(encryptedContact);

    await _box.put(_Key.CONTACTS.name, contacts);
  }

  Future<List<Contact>> _decryptContacts() async {
    final data = (_box.get(_Key.CONTACTS.name) as List?) ?? [];
    final contacts = data.cast<Contact>();
    return Future.wait(contacts.map((e) => e.decrypt(_secretKey)));
  }

  Future<List<Contact>> _encryptContacts(List<Contact> contacts) {
    return Future.wait(contacts.map((e) => e.encrypt(_secretKey)));
  }

  @override
  Stream<List<Contact>> watchContacts() async* {
    // Emit initial value
    yield await _decryptContacts();

    // Watch for changes on the CONTACTS key
    await for (final _ in _box.watch(key: _Key.CONTACTS.name)) {
      yield await _decryptContacts();
    }
  }

  @override
  Future<void> removeContact(Contact contact) async {
    final contacts = await _decryptContacts();
    contacts.removeWhere((e) => e.onionAddress == contact.onionAddress);
    await _box.put(_Key.CONTACTS.name, await _encryptContacts(contacts));
  }

  @override
  Future<Contact?> getContactByOnionAddress(String onionAddress) async {
    final contacts = await _decryptContacts();
    try {
      return contacts.firstWhere((c) => c.onionAddress == onionAddress);
    } catch (_) {
      return null;
    }
  }

  // ============ MESSAGE OPERATIONS (using Drift/SQLite) ============

  /// Encrypt message content and sender for storage
  Future<MessagesCompanion> _toDriftMessage(
    String conversationId,
    domain.Message message,
  ) async {
    final encryptedContent = await Contact.encryptField(message.content, _secretKey);
    final encryptedSender = await message.sender.encrypt(_secretKey);

    return MessagesCompanion(
      id: Value(message.id),
      conversationId: Value(conversationId),
      content: Value(encryptedContent),
      senderJson: Value(jsonEncode(encryptedSender.toJson())),
      timestamp: Value(message.timestamp),
      messageType: Value(message.type.name),
    );
  }

  /// Convert drift Message to domain Message with decryption
  Future<domain.Message> _fromDriftMessage(Message dbMessage) async {
    final decryptedContent = await Contact.decryptField(dbMessage.content, _secretKey);
    final senderJson = jsonDecode(dbMessage.senderJson) as Map<String, dynamic>;
    final encryptedSender = Contact.fromJson(senderJson);
    final decryptedSender = await encryptedSender.decrypt(_secretKey);

    return domain.Message(
      id: dbMessage.id,
      sender: decryptedSender,
      content: decryptedContent,
      timestamp: dbMessage.timestamp,
      type: domain.MessageType.values.firstWhere(
        (e) => e.name == dbMessage.messageType,
        orElse: () => domain.MessageType.text,
      ),
    );
  }

  @override
  Future<void> saveMessage(String conversationId, domain.Message message) async {
    final driftMessage = await _toDriftMessage(conversationId, message);
    await _messagesDb.upsertMessage(driftMessage);
  }

  @override
  Future<MessagePage> getMessages(
    String conversationId, {
    int limit = 20,
    DateTime? before,
  }) async {
    // Fetch one extra to check if there are more
    final dbMessages = await _messagesDb.getMessagesForConversation(
      conversationId,
      limit: limit + 1,
      before: before,
    );

    final hasMore = dbMessages.length > limit;
    final messagesToReturn = hasMore ? dbMessages.take(limit).toList() : dbMessages;

    // Decrypt all messages
    final decrypted = await Future.wait(messagesToReturn.map(_fromDriftMessage));

    // Next cursor is the timestamp of the oldest message in this page
    final nextCursor = decrypted.isNotEmpty ? decrypted.last.timestamp : null;

    return MessagePage(
      messages: decrypted,
      hasMore: hasMore,
      nextCursor: hasMore ? nextCursor : null,
    );
  }

  @override
  Stream<List<domain.Message>> watchMessages(String conversationId) {
    return _messagesDb.watchMessages(conversationId).asyncMap((dbMessages) async {
      return Future.wait(dbMessages.map(_fromDriftMessage));
    });
  }

  @override
  Future<domain.Message?> getLastMessage(String conversationId) async {
    final dbMessage = await _messagesDb.getLastMessage(conversationId);
    if (dbMessage == null) return null;
    return _fromDriftMessage(dbMessage);
  }
}
