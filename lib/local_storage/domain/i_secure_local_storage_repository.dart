import 'package:cryptography/cryptography.dart';

abstract class ISecureLocalStorageRepository {
  Future<SecretKey> getOrCreateAesKey();
}
