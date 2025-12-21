import 'package:dartz/dartz.dart';
import 'package:whisp/common/domain/failure.dart';
import 'package:whisp/encryption/domain/pre_key_bundle_dto.dart';

/// High-level interface for Signal Protocol encryption operations
abstract class ISignalService {
  /// Initialize Signal Protocol keys during user registration
  /// Returns the base64 encoded identity key pair and public key
  Future<Either<Failure, SignalKeyData>> generateKeys();

  /// Get the current PreKeyBundle to share with contacts
  Future<Either<Failure, PreKeyBundleDto>> getPreKeyBundle();

  /// Establish a session with a remote user using their PreKeyBundle
  Future<Either<Failure, Unit>> establishSession({
    required String remoteOnionAddress,
    required PreKeyBundleDto remotePreKeyBundle,
  });

  /// Check if we have an established session with a user
  Future<bool> hasSession(String remoteOnionAddress);

  /// Encrypt a message for a specific recipient
  /// Returns base64 encoded ciphertext
  Future<Either<Failure, EncryptedMessageData>> encryptMessage({
    required String recipientOnionAddress,
    required String plaintext,
  });

  /// Decrypt an incoming message from a sender
  /// Returns the decrypted plaintext
  Future<Either<Failure, String>> decryptMessage({
    required String senderOnionAddress,
    required EncryptedMessageData encryptedData,
  });
}

/// Data class containing generated Signal Protocol keys
class SignalKeyData {
  /// Base64 encoded serialized IdentityKeyPair (contains private key)
  final String identityKeyPairBase64;

  /// Base64 encoded public identity key only (safe to share)
  final String identityKeyBase64;

  /// Registration ID for this device
  final int registrationId;

  SignalKeyData({
    required this.identityKeyPairBase64,
    required this.identityKeyBase64,
    required this.registrationId,
  });
}

/// Data class for encrypted message transport
class EncryptedMessageData {
  /// Base64 encoded ciphertext
  final String ciphertextBase64;

  /// Message type: 'prekey' for initial message, 'whisper' for subsequent
  final String messageType;

  EncryptedMessageData({
    required this.ciphertextBase64,
    required this.messageType,
  });

  factory EncryptedMessageData.fromJson(Map<String, dynamic> json) {
    return EncryptedMessageData(
      ciphertextBase64: json['ciphertext'] as String,
      messageType: json['message_type'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ciphertext': ciphertextBase64,
      'message_type': messageType,
    };
  }
}



