import 'package:flick/authentication/domain/user.dart';
import 'package:flick/contacts_library/domain/contact.dart';
import 'package:flutter/material.dart';

abstract class ILocalStorageRepository {
  Future<void> init();
  User? getUser();
  Future<void> setUser(User user);
  ThemeMode getThemeMode();
  Future<void> setThemeMode(ThemeMode themeMode);
  Future<void> addContact(Contact contact);
  Future<void> removeContact(Contact contact);
  Future<List<Contact>> getContacts();
}
