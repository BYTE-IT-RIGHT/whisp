import 'package:flick/authentication/domain/user.dart';
import 'package:flutter/material.dart';

abstract class ILocalStorageRepository {
  Future<void> init();
  User? getUser();
  Future<void> setUser(User user);
  ThemeMode getThemeMode();
  Future<void> setThemeMode(ThemeMode themeMode);
}
