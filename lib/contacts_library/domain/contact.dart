import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:hive_ce/hive.dart';

class Contact extends HiveObject {
  final String onionAddress;
  final String username;

  Contact({required this.onionAddress, required this.username});

  static final _algorithm = AesGcm.with256bits();

  Future<Contact> encrypt(SecretKey key) async {
    final onionBox = await _encryptField(onionAddress, key);
    final usernameBox = await _encryptField(username, key);

    return Contact(onionAddress: onionBox, username: usernameBox);
  }

  static Future<String> _encryptField(String value, SecretKey key) async {
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
    final onion = await _decryptField(onionAddress, key);
    final username = await _decryptField(this.username, key);

    return Contact(onionAddress: onion, username: username);
  }

  static Future<String> _decryptField(String encrypted, SecretKey key) async {
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
      onionAddress: json['onion_address'],
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'username': username, 'onion_address': onionAddress};
  }
}
