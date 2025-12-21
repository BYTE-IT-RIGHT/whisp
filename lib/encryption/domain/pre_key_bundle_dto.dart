import 'dart:convert';
import 'dart:typed_data';

import 'package:libsignal_protocol_dart/libsignal_protocol_dart.dart';

/// Data Transfer Object for exchanging PreKeyBundle over HTTP
/// 
/// This contains all the public key material needed to establish
/// a Signal Protocol session with a remote user.
class PreKeyBundleDto {
  final int registrationId;
  final int deviceId;
  final int preKeyId;
  final String preKeyPublicBase64;
  final int signedPreKeyId;
  final String signedPreKeyPublicBase64;
  final String signedPreKeySignatureBase64;
  final String identityKeyBase64;

  PreKeyBundleDto({
    required this.registrationId,
    required this.deviceId,
    required this.preKeyId,
    required this.preKeyPublicBase64,
    required this.signedPreKeyId,
    required this.signedPreKeyPublicBase64,
    required this.signedPreKeySignatureBase64,
    required this.identityKeyBase64,
  });

  /// Create from Signal Protocol PreKeyBundle
  factory PreKeyBundleDto.fromPreKeyBundle(PreKeyBundle bundle) {
    final preKey = bundle.getPreKey();
    if (preKey == null) {
      throw StateError('PreKeyBundle must have a preKey');
    }
    
    final signedPreKey = bundle.getSignedPreKey();
    final signedPreKeyBytes = signedPreKey!.serialize();
    final signatureBytes = bundle.getSignedPreKeySignature();
    
    if (signatureBytes == null) {
      throw StateError('PreKeyBundle must have a signature');
    }
    
    return PreKeyBundleDto(
      registrationId: bundle.getRegistrationId(),
      deviceId: bundle.getDeviceId(),
      preKeyId: bundle.getPreKeyId() ?? 0,
      preKeyPublicBase64: base64Encode(preKey.serialize()),
      signedPreKeyId: bundle.getSignedPreKeyId(),
      signedPreKeyPublicBase64: base64Encode(signedPreKeyBytes),
      signedPreKeySignatureBase64: base64Encode(signatureBytes),
      identityKeyBase64: base64Encode(bundle.getIdentityKey().serialize()),
    );
  }

  /// Convert to Signal Protocol PreKeyBundle
  PreKeyBundle toPreKeyBundle() {
    return PreKeyBundle(
      registrationId,
      deviceId,
      preKeyId,
      Curve.decodePoint(Uint8List.fromList(base64Decode(preKeyPublicBase64)), 0),
      signedPreKeyId,
      Curve.decodePoint(Uint8List.fromList(base64Decode(signedPreKeyPublicBase64)), 0),
      Uint8List.fromList(base64Decode(signedPreKeySignatureBase64)),
      IdentityKey(Curve.decodePoint(Uint8List.fromList(base64Decode(identityKeyBase64)), 0)),
    );
  }

  factory PreKeyBundleDto.fromJson(Map<String, dynamic> json) {
    return PreKeyBundleDto(
      registrationId: json['registration_id'] as int,
      deviceId: json['device_id'] as int,
      preKeyId: json['pre_key_id'] as int,
      preKeyPublicBase64: json['pre_key_public'] as String,
      signedPreKeyId: json['signed_pre_key_id'] as int,
      signedPreKeyPublicBase64: json['signed_pre_key_public'] as String,
      signedPreKeySignatureBase64: json['signed_pre_key_signature'] as String,
      identityKeyBase64: json['identity_key'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'registration_id': registrationId,
      'device_id': deviceId,
      'pre_key_id': preKeyId,
      'pre_key_public': preKeyPublicBase64,
      'signed_pre_key_id': signedPreKeyId,
      'signed_pre_key_public': signedPreKeyPublicBase64,
      'signed_pre_key_signature': signedPreKeySignatureBase64,
      'identity_key': identityKeyBase64,
    };
  }

  String toBase64() => base64Encode(utf8.encode(jsonEncode(toJson())));

  factory PreKeyBundleDto.fromBase64(String encoded) {
    final json = jsonDecode(utf8.decode(base64Decode(encoded))) as Map<String, dynamic>;
    return PreKeyBundleDto.fromJson(json);
  }
}
