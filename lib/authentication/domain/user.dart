import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:whisp/conversations_library/domain/contact.dart';
import 'package:hive_ce/hive.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
@HiveType(typeId: 0)
abstract class User with _$User {
  const User._();
  const factory User({
    @HiveField(0) required String username,
    @HiveField(1) required String onionAddress,
    @HiveField(2) required String avatarUrl,
    @HiveField(3) required int registrationId,
    @HiveField(4) required String identityKeyPairBase64,
    @HiveField(5) required String identityKeyBase64,
    @HiveField(6) @Default([]) List<String> mailboxAddresses,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Contact toContact() => Contact(
    onionAddress: onionAddress,
    username: username,
    avatarUrl: avatarUrl,
    identityKeyBase64: identityKeyBase64,
  );
}
