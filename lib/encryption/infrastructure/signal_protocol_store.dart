import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:libsignal_protocol_dart/libsignal_protocol_dart.dart';
import 'package:whisp/encryption/domain/i_signal_protocol_store.dart';
import 'package:whisp/encryption/domain/pre_key_bundle_dto.dart';

/// Keys used for secure storage
class _StorageKeys {
  static const identityKeyPair = 'signal_identity_key_pair';
  static const registrationId = 'signal_registration_id';
  static const signedPreKey = 'signal_signed_pre_key';
  static const preKeyPrefix = 'signal_pre_key_';
  static const sessionPrefix = 'signal_session_';
  static const identityPrefix = 'signal_identity_';
  static const currentPreKeyId = 'signal_current_pre_key_id';
}

@LazySingleton(as: ISignalProtocolStore)
class SignalProtocolStore implements ISignalProtocolStore {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  
  // Device ID is always 1 for single-device implementation
  static const int deviceId = 1;

  // ============ INITIALIZATION ============

  @override
  Future<void> initialize({
    required IdentityKeyPair identityKeyPair,
    required int registrationId,
    required List<PreKeyRecord> preKeys,
    required SignedPreKeyRecord signedPreKey,
  }) async {
    // Store identity key pair
    await _secureStorage.write(
      key: _StorageKeys.identityKeyPair,
      value: base64Encode(identityKeyPair.serialize()),
    );

    // Store registration ID
    await _secureStorage.write(
      key: _StorageKeys.registrationId,
      value: registrationId.toString(),
    );

    // Store signed pre key
    await _secureStorage.write(
      key: _StorageKeys.signedPreKey,
      value: base64Encode(signedPreKey.serialize()),
    );

    // Store all pre keys
    for (final preKey in preKeys) {
      await storePreKey(preKey.id, preKey);
    }

    // Store current pre key ID (we'll use the first one initially)
    await _secureStorage.write(
      key: _StorageKeys.currentPreKeyId,
      value: preKeys.first.id.toString(),
    );

    log('Signal Protocol store initialized with ${preKeys.length} pre keys');
  }

  @override
  Future<bool> isInitialized() async {
    final identityKey = await _secureStorage.read(key: _StorageKeys.identityKeyPair);
    return identityKey != null;
  }

  @override
  Future<PreKeyBundleDto> getPreKeyBundle() async {
    final identityKeyPair = await getIdentityKeyPair();
    final registrationId = await getLocalRegistrationId();
    
    // Get current pre key
    final currentPreKeyIdStr = await _secureStorage.read(key: _StorageKeys.currentPreKeyId);
    final currentPreKeyId = int.parse(currentPreKeyIdStr ?? '0');
    final preKey = await loadPreKey(currentPreKeyId);
    
    // Get signed pre key
    final signedPreKeyData = await _secureStorage.read(key: _StorageKeys.signedPreKey);
    final signedPreKey = SignedPreKeyRecord.fromSerialized(
      Uint8List.fromList(base64Decode(signedPreKeyData!)),
    );

    final bundle = PreKeyBundle(
      registrationId,
      deviceId,
      preKey.id,
      preKey.getKeyPair().publicKey,
      signedPreKey.id,
      signedPreKey.getKeyPair().publicKey,
      signedPreKey.signature,
      identityKeyPair.getPublicKey(),
    );

    return PreKeyBundleDto.fromPreKeyBundle(bundle);
  }

  @override
  Future<void> consumePreKey(int preKeyId) async {
    // Remove the used pre key
    await removePreKey(preKeyId);
    
    // Find next available pre key
    for (int i = preKeyId + 1; i < preKeyId + 100; i++) {
      if (await containsPreKey(i)) {
        await _secureStorage.write(
          key: _StorageKeys.currentPreKeyId,
          value: i.toString(),
        );
        return;
      }
    }
    
    log('Warning: Running low on pre keys, should generate more');
  }

  // ============ IDENTITY KEY STORE ============

  @override
  Future<IdentityKeyPair> getIdentityKeyPair() async {
    final data = await _secureStorage.read(key: _StorageKeys.identityKeyPair);
    if (data == null) {
      throw StateError('Identity key pair not initialized');
    }
    return IdentityKeyPair.fromSerialized(Uint8List.fromList(base64Decode(data)));
  }

  @override
  Future<int> getLocalRegistrationId() async {
    final data = await _secureStorage.read(key: _StorageKeys.registrationId);
    if (data == null) {
      throw StateError('Registration ID not initialized');
    }
    return int.parse(data);
  }

  @override
  Future<bool> saveIdentity(SignalProtocolAddress address, IdentityKey? identityKey) async {
    if (identityKey == null) return false;
    
    final key = '${_StorageKeys.identityPrefix}${address.getName()}_${address.getDeviceId()}';
    final existing = await _secureStorage.read(key: key);
    
    await _secureStorage.write(
      key: key,
      value: base64Encode(identityKey.serialize()),
    );
    
    // Return true if this is a new identity (first time seeing this address)
    return existing == null;
  }

  @override
  Future<bool> isTrustedIdentity(
    SignalProtocolAddress address,
    IdentityKey? identityKey,
    Direction direction,
  ) async {
    if (identityKey == null) return false;
    
    final key = '${_StorageKeys.identityPrefix}${address.getName()}_${address.getDeviceId()}';
    final existing = await _secureStorage.read(key: key);
    
    if (existing == null) {
      // First time seeing this identity - trust on first use (TOFU)
      return true;
    }
    
    // Check if identity matches what we have stored
    final storedIdentity = IdentityKey(
      Curve.decodePoint(Uint8List.fromList(base64Decode(existing)), 0),
    );
    return identityKey.serialize().toString() == storedIdentity.serialize().toString();
  }

  @override
  Future<IdentityKey?> getIdentity(SignalProtocolAddress address) async {
    final key = '${_StorageKeys.identityPrefix}${address.getName()}_${address.getDeviceId()}';
    final data = await _secureStorage.read(key: key);
    
    if (data == null) return null;
    
    return IdentityKey(
      Curve.decodePoint(Uint8List.fromList(base64Decode(data)), 0),
    );
  }

  // ============ PRE KEY STORE ============

  @override
  Future<PreKeyRecord> loadPreKey(int preKeyId) async {
    final key = '${_StorageKeys.preKeyPrefix}$preKeyId';
    final data = await _secureStorage.read(key: key);
    
    if (data == null) {
      throw InvalidKeyIdException('No pre key found for ID: $preKeyId');
    }
    
    return PreKeyRecord.fromBuffer(Uint8List.fromList(base64Decode(data)));
  }

  @override
  Future<void> storePreKey(int preKeyId, PreKeyRecord record) async {
    final key = '${_StorageKeys.preKeyPrefix}$preKeyId';
    await _secureStorage.write(
      key: key,
      value: base64Encode(record.serialize()),
    );
  }

  @override
  Future<bool> containsPreKey(int preKeyId) async {
    final key = '${_StorageKeys.preKeyPrefix}$preKeyId';
    final data = await _secureStorage.read(key: key);
    return data != null;
  }

  @override
  Future<void> removePreKey(int preKeyId) async {
    final key = '${_StorageKeys.preKeyPrefix}$preKeyId';
    await _secureStorage.delete(key: key);
  }

  // ============ SIGNED PRE KEY STORE ============

  @override
  Future<SignedPreKeyRecord> loadSignedPreKey(int signedPreKeyId) async {
    final data = await _secureStorage.read(key: _StorageKeys.signedPreKey);
    
    if (data == null) {
      throw InvalidKeyIdException('No signed pre key found');
    }
    
    return SignedPreKeyRecord.fromSerialized(Uint8List.fromList(base64Decode(data)));
  }

  @override
  Future<List<SignedPreKeyRecord>> loadSignedPreKeys() async {
    final data = await _secureStorage.read(key: _StorageKeys.signedPreKey);
    
    if (data == null) return [];
    
    return [SignedPreKeyRecord.fromSerialized(Uint8List.fromList(base64Decode(data)))];
  }

  @override
  Future<void> storeSignedPreKey(int signedPreKeyId, SignedPreKeyRecord record) async {
    await _secureStorage.write(
      key: _StorageKeys.signedPreKey,
      value: base64Encode(record.serialize()),
    );
  }

  @override
  Future<bool> containsSignedPreKey(int signedPreKeyId) async {
    final data = await _secureStorage.read(key: _StorageKeys.signedPreKey);
    return data != null;
  }

  @override
  Future<void> removeSignedPreKey(int signedPreKeyId) async {
    await _secureStorage.delete(key: _StorageKeys.signedPreKey);
  }

  // ============ SESSION STORE ============

  @override
  Future<SessionRecord> loadSession(SignalProtocolAddress address) async {
    final key = '${_StorageKeys.sessionPrefix}${address.getName()}_${address.getDeviceId()}';
    final data = await _secureStorage.read(key: key);
    
    if (data == null) {
      return SessionRecord();
    }
    
    return SessionRecord.fromSerialized(Uint8List.fromList(base64Decode(data)));
  }

  @override
  Future<List<int>> getSubDeviceSessions(String name) async {
    // For single-device implementation, we only have device ID 1
    final key = '${_StorageKeys.sessionPrefix}${name}_$deviceId';
    final data = await _secureStorage.read(key: key);
    
    if (data != null) {
      return [deviceId];
    }
    return [];
  }

  @override
  Future<void> storeSession(SignalProtocolAddress address, SessionRecord record) async {
    final key = '${_StorageKeys.sessionPrefix}${address.getName()}_${address.getDeviceId()}';
    await _secureStorage.write(
      key: key,
      value: base64Encode(record.serialize()),
    );
  }

  @override
  Future<bool> containsSession(SignalProtocolAddress address) async {
    final key = '${_StorageKeys.sessionPrefix}${address.getName()}_${address.getDeviceId()}';
    final data = await _secureStorage.read(key: key);
    return data != null;
  }

  @override
  Future<void> deleteSession(SignalProtocolAddress address) async {
    final key = '${_StorageKeys.sessionPrefix}${address.getName()}_${address.getDeviceId()}';
    await _secureStorage.delete(key: key);
  }

  @override
  Future<void> deleteAllSessions(String name) async {
    // Delete session for all known device IDs (we only use 1)
    final key = '${_StorageKeys.sessionPrefix}${name}_$deviceId';
    await _secureStorage.delete(key: key);
  }
}
