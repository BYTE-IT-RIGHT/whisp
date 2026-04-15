// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_adapters.dart';

// **************************************************************************
// AdaptersGenerator
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
      mailboxAddress: fields[7] as String?,
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
      ..writeByte(7)
      ..write(obj.mailboxAddress);
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
      onionAddress: fields[5] as String,
      username: fields[6] as String,
      avatarUrl: fields[7] as String,
      identityKeyBase64: fields[8] as String,
      preKeyBundleBase64: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Contact obj) {
    writer
      ..writeByte(5)
      ..writeByte(5)
      ..write(obj.onionAddress)
      ..writeByte(6)
      ..write(obj.username)
      ..writeByte(7)
      ..write(obj.avatarUrl)
      ..writeByte(8)
      ..write(obj.identityKeyBase64)
      ..writeByte(9)
      ..write(obj.preKeyBundleBase64);
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
