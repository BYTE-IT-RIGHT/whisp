import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';

part 'contact.freezed.dart';
part 'contact.g.dart';

@freezed
@HiveType(typeId: 1)
abstract class Contact with _$Contact {
  const Contact._();
  const factory Contact({
    @HiveField(0) required String onionAddress,
    @HiveField(1) required String username,
    @HiveField(2) required String avatarUrl,
    @HiveField(3) required String identityKeyBase64,
    @HiveField(4) String? preKeyBundleBase64,
    @HiveField(5) String? mailboxAddress,
  }) = _Contact;

  static final _algorithm = AesGcm.with256bits();

  factory Contact.fromJson(Map<String, dynamic> json) =>
      _$ContactFromJson(json);

  Future<Contact> encrypt(SecretKey key) async {
    final onionBox = await encryptField(onionAddress, key);
    final usernameBox = await encryptField(username, key);
    final identityKeyBox = await encryptField(identityKeyBase64, key);
    final mailboxBox =
        mailboxAddress != null && mailboxAddress!.isNotEmpty
        ? await encryptField(mailboxAddress!, key)
        : null;

    return Contact(
      onionAddress: onionBox,
      username: usernameBox,
      avatarUrl: avatarUrl,
      identityKeyBase64: identityKeyBox,
      preKeyBundleBase64: preKeyBundleBase64,
      mailboxAddress: mailboxBox,
    );
  }

  /// Encrypts a string field using AES-GCM
  static Future<String> encryptField(String value, SecretKey key) async {
    final nonce = _algorithm.newNonce();

    final box = await _algorithm.encrypt(
      utf8.encode(value),
      secretKey: key,
      nonce: nonce,
    );

    return [
      base64Encode(nonce),
      base64Encode(box.cipherText),
      base64Encode(box.mac.bytes),
    ].join(':');
  }

  Future<Contact> decrypt(SecretKey key) async {
    final onion = await decryptField(onionAddress, key);
    final username = await decryptField(this.username, key);
    final identityKey = await decryptField(identityKeyBase64, key);
    final mailboxClear =
        mailboxAddress != null && mailboxAddress!.isNotEmpty
        ? await decryptField(mailboxAddress!, key)
        : null;

    return Contact(
      onionAddress: onion,
      username: username,
      avatarUrl: avatarUrl,
      identityKeyBase64: identityKey,
      preKeyBundleBase64: preKeyBundleBase64,
      mailboxAddress: mailboxClear,
    );
  }

  /// Decrypts a string field encrypted with AES-GCM
  static Future<String> decryptField(String encrypted, SecretKey key) async {
    final parts = encrypted.split(':');
    if (parts.length != 3) {
      throw const FormatException('Invalid encrypted format');
    }

    final nonce = base64Decode(parts[0]);
    final cipherText = base64Decode(parts[1]);
    final mac = Mac(base64Decode(parts[2]));

    final box = SecretBox(cipherText, nonce: nonce, mac: mac);

    final clearText = await _algorithm.decrypt(box, secretKey: key);

    return utf8.decode(clearText);
  }
}
