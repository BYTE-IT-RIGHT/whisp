import 'package:flick/authentication/domain/user.dart';

abstract class ILocalStorageRepository {
  Future<void> init();
  User? getUser();
  Future<void> setUser(User user);
}
