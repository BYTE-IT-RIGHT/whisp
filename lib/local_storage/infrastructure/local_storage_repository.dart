import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:flick/authentication/domain/user.dart';
import 'package:flick/contacts_library/domain/contact.dart';
import 'package:flick/local_storage/domain/hive_registrar.g.dart';
import 'package:flick/local_storage/domain/i_local_storage_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

enum _Key { AES_KEY, USER, THEME, CONTACTS }

@LazySingleton(as: ILocalStorageRepository)
class LocalStorageRepository implements ILocalStorageRepository {
  final _secureStorage = FlutterSecureStorage();
  late final Box _box;
  late final SecretKey _secretKey;

  @override
  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapters();
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
}
