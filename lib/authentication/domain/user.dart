import 'package:whisp/conversations_library/domain/contact.dart';
import 'package:hive_ce/hive.dart';

class User extends HiveObject {
  final String username;
  final String onionAddress;
  final String avatarUrl;

  /// Signal Protocol registration ID (unique per device)
  final int registrationId;

  /// Base64 encoded serialized IdentityKeyPair (public + private)
  final String identityKeyPairBase64;

  /// Base64 encoded public identity key only (for sharing)
  final String identityKeyBase64;

  /// List of mailbox onion addresses
  final List<String> mailboxAddresses;

  User({
    required this.username,
    required this.onionAddress,
    required this.avatarUrl,
    required this.registrationId,
    required this.identityKeyPairBase64,
    required this.identityKeyBase64,
    this.mailboxAddresses = const [],
  });

  User copyWith({
    String? username,
    String? onionAddress,
    String? avatarUrl,
    int? registrationId,
    String? identityKeyPairBase64,
    String? identityKeyBase64,
    List<String>? mailboxAddresses,
  }) {
    return User(
      username: username ?? this.username,
      onionAddress: onionAddress ?? this.onionAddress,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      registrationId: registrationId ?? this.registrationId,
      identityKeyPairBase64:
          identityKeyPairBase64 ?? this.identityKeyPairBase64,
      identityKeyBase64: identityKeyBase64 ?? this.identityKeyBase64,
      mailboxAddresses: mailboxAddresses ?? this.mailboxAddresses,
    );
  }

  Contact toContact() => Contact(
    onionAddress: onionAddress,
    username: username,
    avatarUrl: avatarUrl,
    identityKeyBase64: identityKeyBase64,
  );

  Map<String, dynamic> toJson() => {
    'username': username,
    'onion_address': onionAddress,
    'avatar_url': avatarUrl,
    'registration_id': registrationId,
    'identity_key': identityKeyBase64,
    'mailbox_addresses': mailboxAddresses,
  };

  factory User.fromJson(Map<String, dynamic> json) => User(
    username: json['username'] as String,
    onionAddress: json['onion_address'] as String,
    avatarUrl: json['avatar_url'] as String,
    registrationId: json['registration_id'] as int,
    identityKeyPairBase64: '', // Private key not sent over network
    identityKeyBase64: json['identity_key'] as String,
    mailboxAddresses:
        (json['mailbox_addresses'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList() ??
        [],
  );
}
