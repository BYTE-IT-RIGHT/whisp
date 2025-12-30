import 'dart:convert';
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

  static const int _deviceId = 1;
  static const int _preKeyCount = 100;

  SignalService(this._store);

  @override
  Future<Either<Failure, SignalKeyData>> generateKeys() async {
    try {
      final identityKeyPair = generateIdentityKeyPair();
      final registrationId = generateRegistrationId(false);
      final preKeys = generatePreKeys(0, _preKeyCount);
      final signedPreKey = generateSignedPreKey(identityKeyPair, 0);
      
      await _store.initialize(
        identityKeyPair: identityKeyPair,
        registrationId: registrationId,
        preKeys: preKeys,
        signedPreKey: signedPreKey,
      );
      
      return right(SignalKeyData(
        identityKeyPairBase64: base64Encode(identityKeyPair.serialize()),
        identityKeyBase64: base64Encode(identityKeyPair.getPublicKey().serialize()),
        registrationId: registrationId,
      ));
    } catch (e) {
      return left(SignalProtocolError('Failed to generate keys: $e'));
    }
  }

  @override
  Future<Either<Failure, PreKeyBundleDto>> getPreKeyBundle() async {
    try {
      final bundle = await _store.getPreKeyBundle();
      return right(bundle);
    } catch (e) {
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
      
      final sessionBuilder = SessionBuilder(
        _store,
        _store,
        _store,
        _store,
        remoteAddress,
      );
      
      await sessionBuilder.processPreKeyBundle(remotePreKeyBundle.toPreKeyBundle());
      
      return right(unit);
    } catch (e) {
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
      
      final sessionCipher = SessionCipher(
        _store,
        _store,
        _store,
        _store,
        remoteAddress,
      );
      
      final ciphertext = await sessionCipher.encrypt(
        Uint8List.fromList(utf8.encode(plaintext)),
      );
      
      final messageType = ciphertext.getType() == CiphertextMessage.prekeyType 
          ? 'prekey' 
          : 'whisper';
      
      return right(EncryptedMessageData(
        ciphertextBase64: base64Encode(ciphertext.serialize()),
        messageType: messageType,
      ));
    } catch (e) {
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
      
      final sessionCipher = SessionCipher(
        _store,
        _store,
        _store,
        _store,
        remoteAddress,
      );
      
      final ciphertextBytes = base64Decode(encryptedData.ciphertextBase64);
      
      Uint8List plaintext;
      
      if (encryptedData.messageType == 'prekey') {
        final preKeyMessage = PreKeySignalMessage(Uint8List.fromList(ciphertextBytes));
        plaintext = await sessionCipher.decrypt(preKeyMessage);
        
        final preKeyId = preKeyMessage.preKeyId;
        if (preKeyId.isPresent) {
          await _store.consumePreKey(preKeyId.value);
        }
      } else {
        final signalMessage = SignalMessage.fromSerialized(Uint8List.fromList(ciphertextBytes));
        plaintext = await sessionCipher.decryptFromSignal(signalMessage);
      }
      
      return right(utf8.decode(plaintext));
    } catch (e) {
      return left(SignalProtocolError('Failed to decrypt message: $e'));
    }
  }
}
