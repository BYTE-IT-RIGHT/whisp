// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ContactAdapter extends TypeAdapter<Contact> {
  @override
  final typeId = 1;

  @override
  Contact read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Contact(
      onionAddress: fields[0] as String,
      username: fields[1] as String,
      avatarUrl: fields[2] as String,
      identityKeyBase64: fields[3] as String,
      preKeyBundleBase64: fields[4] as String?,
      mailboxAddress: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Contact obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.onionAddress)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.avatarUrl)
      ..writeByte(3)
      ..write(obj.identityKeyBase64)
      ..writeByte(4)
      ..write(obj.preKeyBundleBase64)
      ..writeByte(5)
      ..write(obj.mailboxAddress);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContactAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Contact _$ContactFromJson(Map<String, dynamic> json) => _Contact(
  onionAddress: json['onionAddress'] as String,
  username: json['username'] as String,
  avatarUrl: json['avatarUrl'] as String,
  identityKeyBase64: json['identityKeyBase64'] as String,
  preKeyBundleBase64: json['preKeyBundleBase64'] as String?,
  mailboxAddress: json['mailboxAddress'] as String?,
);

Map<String, dynamic> _$ContactToJson(_Contact instance) => <String, dynamic>{
  'onionAddress': instance.onionAddress,
  'username': instance.username,
  'avatarUrl': instance.avatarUrl,
  'identityKeyBase64': instance.identityKeyBase64,
  'preKeyBundleBase64': instance.preKeyBundleBase64,
  'mailboxAddress': instance.mailboxAddress,
};
