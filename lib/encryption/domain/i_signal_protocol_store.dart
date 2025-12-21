import 'package:libsignal_protocol_dart/libsignal_protocol_dart.dart';
import 'package:whisp/encryption/domain/pre_key_bundle_dto.dart';

/// Abstract interface for Signal Protocol key and session storage
/// 
/// Combines all four required Signal Protocol stores into one interface
/// for easier dependency injection and management.
abstract class ISignalProtocolStore 
    implements IdentityKeyStore, PreKeyStore, SignedPreKeyStore, SessionStore {
  
  /// Initialize the store with generated keys during user registration
  Future<void> initialize({
    required IdentityKeyPair identityKeyPair,
    required int registrationId,
    required List<PreKeyRecord> preKeys,
    required SignedPreKeyRecord signedPreKey,
  });

  /// Check if the store has been initialized
  Future<bool> isInitialized();

  /// Get the current PreKeyBundle for sharing with contacts
  Future<PreKeyBundleDto> getPreKeyBundle();

  /// Consume a PreKey after it's been used (for Perfect Forward Secrecy)
  Future<void> consumePreKey(int preKeyId);
}



