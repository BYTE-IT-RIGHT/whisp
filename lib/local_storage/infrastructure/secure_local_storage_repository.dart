import 'dart:convert';

import 'package:flick/local_storage/domain/i_secure_local_storage_repository.dart';
import 'package:cryptography/cryptography.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

enum _Key {
  AES_KEY
}

@LazySingleton(as: ISecureLocalStorageRepository)
class SecureLocalStorageRepository implements ISecureLocalStorageRepository {
  final storage = FlutterSecureStorage();

  @override
  Future<SecretKey> getOrCreateAesKey() async {
    String? encodedKey = await storage.read(key: _Key.AES_KEY.name);
    if (encodedKey != null) {
      final keyBytes = base64Decode(encodedKey);
      return SecretKey(keyBytes);
    }

    final algorithm = AesGcm.with256bits();
    final secretKey = await algorithm.newSecretKey();

    final keyBytes = await secretKey.extractBytes();
    await storage.write(key: _Key.AES_KEY.name, value: base64Encode(keyBytes));

    return secretKey;
  }
}
