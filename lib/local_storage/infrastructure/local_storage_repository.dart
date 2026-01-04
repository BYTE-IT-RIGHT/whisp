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

enum _Key {
  AES_KEY,
  USER,
  THEME,
  CONTACTS,
  TUTORIAL_COMPLETED,
  NOTIFICATIONS_ENABLED,
  FOREGROUND_SERVICE_ENABLED,
  LOCAL_AUTH_ENABLED,
  REQUIRE_AUTHENTICATION_ON_PAUSE,
  PIN_HASH,
}

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
    final contacts = await _decryptContacts();
    final existingIndex = contacts.indexWhere(
      (e) => e.onionAddress == contact.onionAddress,
    );

    if (existingIndex != -1) {
      final existing = contacts[existingIndex];
      contacts[existingIndex] = Contact(
        onionAddress: existing.onionAddress,
        username: contact.username,
        avatarUrl: contact.avatarUrl,
        identityKeyBase64: existing.identityKeyBase64,
        preKeyBundleBase64: existing.preKeyBundleBase64,
      );
    } else {
      contacts.add(contact);
    }

    await _box.put(_Key.CONTACTS.name, await _encryptContacts(contacts));
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
    yield await _decryptContacts();

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

  Future<MessagesCompanion> _toDriftMessage(
    String conversationId,
    domain.Message message,
  ) async {
    final encryptedContent = await Contact.encryptField(
      message.content,
      _secretKey,
    );
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

  Future<domain.Message> _fromDriftMessage(Message dbMessage) async {
    final decryptedContent = await Contact.decryptField(
      dbMessage.content,
      _secretKey,
    );
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
  Future<void> saveMessage(
    String conversationId,
    domain.Message message,
  ) async {
    final driftMessage = await _toDriftMessage(conversationId, message);
    await _messagesDb.upsertMessage(driftMessage);
  }

  @override
  Future<MessagePage> getMessages(
    String conversationId, {
    int limit = 20,
    DateTime? before,
  }) async {
    final dbMessages = await _messagesDb.getMessagesForConversation(
      conversationId,
      limit: limit + 1,
      before: before,
    );

    final hasMore = dbMessages.length > limit;
    final messagesToReturn = hasMore
        ? dbMessages.take(limit).toList()
        : dbMessages;

    final decrypted = await Future.wait(
      messagesToReturn.map(_fromDriftMessage),
    );

    final nextCursor = decrypted.isNotEmpty ? decrypted.last.timestamp : null;

    return MessagePage(
      messages: decrypted,
      hasMore: hasMore,
      nextCursor: hasMore ? nextCursor : null,
    );
  }

  @override
  Stream<List<domain.Message>> watchMessages(String conversationId) {
    return _messagesDb.watchMessages(conversationId).asyncMap((
      dbMessages,
    ) async {
      return Future.wait(dbMessages.map(_fromDriftMessage));
    });
  }

  @override
  Future<domain.Message?> getLastMessage(String conversationId) async {
    final dbMessage = await _messagesDb.getLastMessage(conversationId);
    if (dbMessage == null) return null;
    return _fromDriftMessage(dbMessage);
  }

  @override
  bool isTutorialCompleted() =>
      _box.get(_Key.TUTORIAL_COMPLETED.name, defaultValue: false);

  @override
  Future<void> setTutorialCompleted(bool completed) =>
      _box.put(_Key.TUTORIAL_COMPLETED.name, completed);

  // ============ SETTINGS OPERATIONS ============

  @override
  bool areNotificationsEnabled() =>
      _box.get(_Key.NOTIFICATIONS_ENABLED.name, defaultValue: true);

  @override
  Future<void> setNotificationsEnabled(bool enabled) =>
      _box.put(_Key.NOTIFICATIONS_ENABLED.name, enabled);

  @override
  bool isForegroundServiceEnabled() =>
      _box.get(_Key.FOREGROUND_SERVICE_ENABLED.name, defaultValue: true);

  @override
  Future<void> setForegroundServiceEnabled(bool enabled) =>
      _box.put(_Key.FOREGROUND_SERVICE_ENABLED.name, enabled);

  @override
  Future<void> updateUserProfile({String? username, String? avatarUrl}) async {
    final currentUser = getUser();
    if (currentUser == null) return;

    final updatedUser = User(
      username: username ?? currentUser.username,
      onionAddress: currentUser.onionAddress,
      avatarUrl: avatarUrl ?? currentUser.avatarUrl,
      registrationId: currentUser.registrationId,
      identityKeyPairBase64: currentUser.identityKeyPairBase64,
      identityKeyBase64: currentUser.identityKeyBase64,
    );

    await setUser(updatedUser);
  }

  @override
  bool getLocalAuthEnabled() =>
      _box.get(_Key.LOCAL_AUTH_ENABLED.name, defaultValue: false);

  @override
  Future<void> setLocalAuthEnabled(bool enabled) =>
      _box.put(_Key.LOCAL_AUTH_ENABLED.name, enabled);
  @override
  bool getRequireAuthenticationOnPause() =>
      _box.get(_Key.REQUIRE_AUTHENTICATION_ON_PAUSE.name, defaultValue: false);

  @override
  Future<void> setRequireAuthenticationOnPause(
    bool requireAuthenticationOnPause,
  ) => _box.put(
    _Key.REQUIRE_AUTHENTICATION_ON_PAUSE.name,
    requireAuthenticationOnPause,
  );

  // ============ PIN OPERATIONS ============

  Future<Uint8List> _hashPin(String pin) async {
    final algorithm = Sha256();
    final hash = await algorithm.hash(pin.codeUnits);
    return Uint8List.fromList(hash.bytes);
  }

  @override
  Future<bool> hasPin() async {
    final hash = await _secureStorage.read(key: _Key.PIN_HASH.name);
    return hash != null;
  }

  @override
  Future<void> setPin(String pin) async {
    final hash = await _hashPin(pin);
    await _secureStorage.write(
      key: _Key.PIN_HASH.name,
      value: base64Encode(hash),
    );
  }

  @override
  Future<bool> verifyPin(String pin) async {
    final storedHash = await _secureStorage.read(key: _Key.PIN_HASH.name);
    if (storedHash == null) return false;

    final inputHash = await _hashPin(pin);
    final storedHashBytes = base64Decode(storedHash);

    // Constant-time comparison to prevent timing attacks
    if (inputHash.length != storedHashBytes.length) return false;
    
    int result = 0;
    for (int i = 0; i < inputHash.length; i++) {
      result |= inputHash[i] ^ storedHashBytes[i];
    }
    return result == 0;
  }
}
