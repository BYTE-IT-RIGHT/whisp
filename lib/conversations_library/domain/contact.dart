import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:hive_ce/hive.dart';

class Contact extends HiveObject {
  final String onionAddress;
  final String username;
  final String avatarUrl;

  /// Base64 encoded public identity key for Signal Protocol (required for E2E encryption)
  final String identityKeyBase64;

  /// Base64 encoded PreKeyBundle for session establishment (temporary, used only during handshake)
  final String? preKeyBundleBase64;

  Contact({
    required this.onionAddress,
    required this.username,
    required this.avatarUrl,
    required this.identityKeyBase64,
    this.preKeyBundleBase64,
  });

  static final _algorithm = AesGcm.with256bits();

  Future<Contact> encrypt(SecretKey key) async {
    final onionBox = await encryptField(onionAddress, key);
    final usernameBox = await encryptField(username, key);
    final identityKeyBox = await encryptField(identityKeyBase64, key);

    return Contact(
      onionAddress: onionBox,
      username: usernameBox,
      avatarUrl: avatarUrl,
      identityKeyBase64: identityKeyBox,
      preKeyBundleBase64: preKeyBundleBase64, // Not stored encrypted as it's temporary
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

    return Contact(
      onionAddress: onion,
      username: username,
      avatarUrl: avatarUrl,
      identityKeyBase64: identityKey,
      preKeyBundleBase64: preKeyBundleBase64,
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

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      onionAddress: json['onion_address'] as String,
      username: json['username'] as String,
      avatarUrl: json['avatar_url'] as String,
      identityKeyBase64: json['identity_key'] as String,
      preKeyBundleBase64: json['pre_key_bundle'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'onion_address': onionAddress,
      'avatar_url': avatarUrl,
      'identity_key': identityKeyBase64,
      if (preKeyBundleBase64 != null) 'pre_key_bundle': preKeyBundleBase64,
    };
  }

  /// Create a copy with updated fields
  Contact copyWith({
    String? onionAddress,
    String? username,
    String? avatarUrl,
    String? identityKeyBase64,
    String? preKeyBundleBase64,
  }) {
    return Contact(
      onionAddress: onionAddress ?? this.onionAddress,
      username: username ?? this.username,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      identityKeyBase64: identityKeyBase64 ?? this.identityKeyBase64,
      preKeyBundleBase64: preKeyBundleBase64 ?? this.preKeyBundleBase64,
    );
  }
}
