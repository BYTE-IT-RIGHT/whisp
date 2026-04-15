// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final typeId = 0;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      username: fields[0] as String,
      onionAddress: fields[1] as String,
      avatarUrl: fields[2] as String,
      registrationId: (fields[3] as num).toInt(),
      identityKeyPairBase64: fields[4] as String,
      identityKeyBase64: fields[5] as String,
      mailboxAddresses: fields[6] == null
          ? []
          : (fields[6] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.username)
      ..writeByte(1)
      ..write(obj.onionAddress)
      ..writeByte(2)
      ..write(obj.avatarUrl)
      ..writeByte(3)
      ..write(obj.registrationId)
      ..writeByte(4)
      ..write(obj.identityKeyPairBase64)
      ..writeByte(5)
      ..write(obj.identityKeyBase64)
      ..writeByte(6)
      ..write(obj.mailboxAddresses);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
  username: json['username'] as String,
  onionAddress: json['onionAddress'] as String,
  avatarUrl: json['avatarUrl'] as String,
  registrationId: (json['registrationId'] as num).toInt(),
  identityKeyPairBase64: json['identityKeyPairBase64'] as String,
  identityKeyBase64: json['identityKeyBase64'] as String,
  mailboxAddresses:
      (json['mailboxAddresses'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
);

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'username': instance.username,
  'onionAddress': instance.onionAddress,
  'avatarUrl': instance.avatarUrl,
  'registrationId': instance.registrationId,
  'identityKeyPairBase64': instance.identityKeyPairBase64,
  'identityKeyBase64': instance.identityKeyBase64,
  'mailboxAddresses': instance.mailboxAddresses,
};
