import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:libsignal_protocol_dart/libsignal_protocol_dart.dart';
import 'package:whisp/common/domain/failure.dart';
import 'package:whisp/encryption/domain/i_signal_protocol_store.dart';
import 'package:whisp/encryption/domain/i_signal_service.dart';
import 'package:whisp/encryption/domain/pre_key_bundle_dto.dart';

@LazySingleton(as: ISignalService)
class SignalService implements ISignalService {
  final ISignalProtocolStore _store;

  // Device ID is always 1 for single-device implementation
  static const int _deviceId = 1;
  
  // Number of pre keys to generate
  static const int _preKeyCount = 100;

  SignalService(this._store);

  @override
  Future<Either<Failure, SignalKeyData>> generateKeys() async {
    try {
      // Generate identity key pair
      final identityKeyPair = generateIdentityKeyPair();
      
      // Generate registration ID
      final registrationId = generateRegistrationId(false);
      
      // Generate pre keys (for Perfect Forward Secrecy)
      final preKeys = generatePreKeys(0, _preKeyCount);
      
      // Generate signed pre key
      final signedPreKey = generateSignedPreKey(identityKeyPair, 0);
      
      // Initialize the store with all keys
      await _store.initialize(
        identityKeyPair: identityKeyPair,
        registrationId: registrationId,
        preKeys: preKeys,
        signedPreKey: signedPreKey,
      );
      
      log('Signal Protocol keys generated successfully');
      
      return right(SignalKeyData(
        identityKeyPairBase64: base64Encode(identityKeyPair.serialize()),
        identityKeyBase64: base64Encode(identityKeyPair.getPublicKey().serialize()),
        registrationId: registrationId,
      ));
    } catch (e) {
      log('Error generating Signal Protocol keys: $e');
      return left(SignalProtocolError('Failed to generate keys: $e'));
    }
  }

  @override
  Future<Either<Failure, PreKeyBundleDto>> getPreKeyBundle() async {
    try {
      final bundle = await _store.getPreKeyBundle();
      return right(bundle);
    } catch (e) {
      log('Error getting PreKeyBundle: $e');
      return left(SignalProtocolError('Failed to get PreKeyBundle: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> establishSession({
    required String remoteOnionAddress,
    required PreKeyBundleDto remotePreKeyBundle,
  }) async {
    try {
      final remoteAddress = SignalProtocolAddress(remoteOnionAddress, _deviceId);
      
      // Create session builder
      final sessionBuilder = SessionBuilder(
        _store, // SessionStore
        _store, // PreKeyStore
        _store, // SignedPreKeyStore
        _store, // IdentityKeyStore
        remoteAddress,
      );
      
      // Process the pre key bundle to establish session
      await sessionBuilder.processPreKeyBundle(remotePreKeyBundle.toPreKeyBundle());
      
      log('Session established with $remoteOnionAddress');
      
      return right(unit);
    } catch (e) {
      log('Error establishing session: $e');
      return left(SignalProtocolError('Failed to establish session: $e'));
    }
  }

  @override
  Future<bool> hasSession(String remoteOnionAddress) async {
    final remoteAddress = SignalProtocolAddress(remoteOnionAddress, _deviceId);
    return await _store.containsSession(remoteAddress);
  }

  @override
  Future<Either<Failure, EncryptedMessageData>> encryptMessage({
    required String recipientOnionAddress,
    required String plaintext,
  }) async {
    try {
      final remoteAddress = SignalProtocolAddress(recipientOnionAddress, _deviceId);
      
      // Create session cipher
      final sessionCipher = SessionCipher(
        _store, // SessionStore
        _store, // PreKeyStore
        _store, // SignedPreKeyStore
        _store, // IdentityKeyStore
        remoteAddress,
      );
      
      // Encrypt the message
      final ciphertext = await sessionCipher.encrypt(
        Uint8List.fromList(utf8.encode(plaintext)),
      );
      
      // Determine message type
      final messageType = ciphertext.getType() == CiphertextMessage.prekeyType 
          ? 'prekey' 
          : 'whisper';
      
      return right(EncryptedMessageData(
        ciphertextBase64: base64Encode(ciphertext.serialize()),
        messageType: messageType,
      ));
    } catch (e) {
      log('Error encrypting message: $e');
      return left(SignalProtocolError('Failed to encrypt message: $e'));
    }
  }

  @override
  Future<Either<Failure, String>> decryptMessage({
    required String senderOnionAddress,
    required EncryptedMessageData encryptedData,
  }) async {
    try {
      final remoteAddress = SignalProtocolAddress(senderOnionAddress, _deviceId);
      
      // Create session cipher
      final sessionCipher = SessionCipher(
        _store, // SessionStore
        _store, // PreKeyStore
        _store, // SignedPreKeyStore
        _store, // IdentityKeyStore
        remoteAddress,
      );
      
      final ciphertextBytes = base64Decode(encryptedData.ciphertextBase64);
      
      Uint8List plaintext;
      
      if (encryptedData.messageType == 'prekey') {
        // This is an initial message that includes key exchange data
        final preKeyMessage = PreKeySignalMessage(Uint8List.fromList(ciphertextBytes));
        plaintext = await sessionCipher.decrypt(preKeyMessage);
        
        // Consume the pre key that was used
        final preKeyId = preKeyMessage.preKeyId;
        if (preKeyId.isPresent) {
          await _store.consumePreKey(preKeyId.value);
        }
      } else {
        // This is a regular message within an established session
        final signalMessage = SignalMessage.fromSerialized(Uint8List.fromList(ciphertextBytes));
        plaintext = await sessionCipher.decryptFromSignal(signalMessage);
      }
      
      return right(utf8.decode(plaintext));
    } catch (e) {
      log('Error decrypting message: $e');
      return left(SignalProtocolError('Failed to decrypt message: $e'));
    }
  }
}
