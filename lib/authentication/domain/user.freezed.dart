// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$User {

@HiveField(0) String get username;@HiveField(1) String get onionAddress;@HiveField(2) String get avatarUrl;@HiveField(3) int get registrationId;@HiveField(4) String get identityKeyPairBase64;@HiveField(5) String get identityKeyBase64;@HiveField(6) List<String> get mailboxAddresses;
/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserCopyWith<User> get copyWith => _$UserCopyWithImpl<User>(this as User, _$identity);

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is User&&(identical(other.username, username) || other.username == username)&&(identical(other.onionAddress, onionAddress) || other.onionAddress == onionAddress)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.registrationId, registrationId) || other.registrationId == registrationId)&&(identical(other.identityKeyPairBase64, identityKeyPairBase64) || other.identityKeyPairBase64 == identityKeyPairBase64)&&(identical(other.identityKeyBase64, identityKeyBase64) || other.identityKeyBase64 == identityKeyBase64)&&const DeepCollectionEquality().equals(other.mailboxAddresses, mailboxAddresses));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,username,onionAddress,avatarUrl,registrationId,identityKeyPairBase64,identityKeyBase64,const DeepCollectionEquality().hash(mailboxAddresses));

@override
String toString() {
  return 'User(username: $username, onionAddress: $onionAddress, avatarUrl: $avatarUrl, registrationId: $registrationId, identityKeyPairBase64: $identityKeyPairBase64, identityKeyBase64: $identityKeyBase64, mailboxAddresses: $mailboxAddresses)';
}


}

/// @nodoc
abstract mixin class $UserCopyWith<$Res>  {
  factory $UserCopyWith(User value, $Res Function(User) _then) = _$UserCopyWithImpl;
@useResult
$Res call({
@HiveField(0) String username,@HiveField(1) String onionAddress,@HiveField(2) String avatarUrl,@HiveField(3) int registrationId,@HiveField(4) String identityKeyPairBase64,@HiveField(5) String identityKeyBase64,@HiveField(6) List<String> mailboxAddresses
});




}
/// @nodoc
class _$UserCopyWithImpl<$Res>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._self, this._then);

  final User _self;
  final $Res Function(User) _then;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? username = null,Object? onionAddress = null,Object? avatarUrl = null,Object? registrationId = null,Object? identityKeyPairBase64 = null,Object? identityKeyBase64 = null,Object? mailboxAddresses = null,}) {
  return _then(_self.copyWith(
username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,onionAddress: null == onionAddress ? _self.onionAddress : onionAddress // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: null == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String,registrationId: null == registrationId ? _self.registrationId : registrationId // ignore: cast_nullable_to_non_nullable
as int,identityKeyPairBase64: null == identityKeyPairBase64 ? _self.identityKeyPairBase64 : identityKeyPairBase64 // ignore: cast_nullable_to_non_nullable
as String,identityKeyBase64: null == identityKeyBase64 ? _self.identityKeyBase64 : identityKeyBase64 // ignore: cast_nullable_to_non_nullable
as String,mailboxAddresses: null == mailboxAddresses ? _self.mailboxAddresses : mailboxAddresses // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [User].
extension UserPatterns on User {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _User value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _User value)  $default,){
final _that = this;
switch (_that) {
case _User():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _User value)?  $default,){
final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@HiveField(0)  String username, @HiveField(1)  String onionAddress, @HiveField(2)  String avatarUrl, @HiveField(3)  int registrationId, @HiveField(4)  String identityKeyPairBase64, @HiveField(5)  String identityKeyBase64, @HiveField(6)  List<String> mailboxAddresses)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that.username,_that.onionAddress,_that.avatarUrl,_that.registrationId,_that.identityKeyPairBase64,_that.identityKeyBase64,_that.mailboxAddresses);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@HiveField(0)  String username, @HiveField(1)  String onionAddress, @HiveField(2)  String avatarUrl, @HiveField(3)  int registrationId, @HiveField(4)  String identityKeyPairBase64, @HiveField(5)  String identityKeyBase64, @HiveField(6)  List<String> mailboxAddresses)  $default,) {final _that = this;
switch (_that) {
case _User():
return $default(_that.username,_that.onionAddress,_that.avatarUrl,_that.registrationId,_that.identityKeyPairBase64,_that.identityKeyBase64,_that.mailboxAddresses);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@HiveField(0)  String username, @HiveField(1)  String onionAddress, @HiveField(2)  String avatarUrl, @HiveField(3)  int registrationId, @HiveField(4)  String identityKeyPairBase64, @HiveField(5)  String identityKeyBase64, @HiveField(6)  List<String> mailboxAddresses)?  $default,) {final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that.username,_that.onionAddress,_that.avatarUrl,_that.registrationId,_that.identityKeyPairBase64,_that.identityKeyBase64,_that.mailboxAddresses);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _User extends User {
  const _User({@HiveField(0) required this.username, @HiveField(1) required this.onionAddress, @HiveField(2) required this.avatarUrl, @HiveField(3) required this.registrationId, @HiveField(4) required this.identityKeyPairBase64, @HiveField(5) required this.identityKeyBase64, @HiveField(6) final  List<String> mailboxAddresses = const []}): _mailboxAddresses = mailboxAddresses,super._();
  factory _User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

@override@HiveField(0) final  String username;
@override@HiveField(1) final  String onionAddress;
@override@HiveField(2) final  String avatarUrl;
@override@HiveField(3) final  int registrationId;
@override@HiveField(4) final  String identityKeyPairBase64;
@override@HiveField(5) final  String identityKeyBase64;
 final  List<String> _mailboxAddresses;
@override@JsonKey()@HiveField(6) List<String> get mailboxAddresses {
  if (_mailboxAddresses is EqualUnmodifiableListView) return _mailboxAddresses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_mailboxAddresses);
}


/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserCopyWith<_User> get copyWith => __$UserCopyWithImpl<_User>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _User&&(identical(other.username, username) || other.username == username)&&(identical(other.onionAddress, onionAddress) || other.onionAddress == onionAddress)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.registrationId, registrationId) || other.registrationId == registrationId)&&(identical(other.identityKeyPairBase64, identityKeyPairBase64) || other.identityKeyPairBase64 == identityKeyPairBase64)&&(identical(other.identityKeyBase64, identityKeyBase64) || other.identityKeyBase64 == identityKeyBase64)&&const DeepCollectionEquality().equals(other._mailboxAddresses, _mailboxAddresses));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,username,onionAddress,avatarUrl,registrationId,identityKeyPairBase64,identityKeyBase64,const DeepCollectionEquality().hash(_mailboxAddresses));

@override
String toString() {
  return 'User(username: $username, onionAddress: $onionAddress, avatarUrl: $avatarUrl, registrationId: $registrationId, identityKeyPairBase64: $identityKeyPairBase64, identityKeyBase64: $identityKeyBase64, mailboxAddresses: $mailboxAddresses)';
}


}

/// @nodoc
abstract mixin class _$UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$UserCopyWith(_User value, $Res Function(_User) _then) = __$UserCopyWithImpl;
@override @useResult
$Res call({
@HiveField(0) String username,@HiveField(1) String onionAddress,@HiveField(2) String avatarUrl,@HiveField(3) int registrationId,@HiveField(4) String identityKeyPairBase64,@HiveField(5) String identityKeyBase64,@HiveField(6) List<String> mailboxAddresses
});




}
/// @nodoc
class __$UserCopyWithImpl<$Res>
    implements _$UserCopyWith<$Res> {
  __$UserCopyWithImpl(this._self, this._then);

  final _User _self;
  final $Res Function(_User) _then;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? username = null,Object? onionAddress = null,Object? avatarUrl = null,Object? registrationId = null,Object? identityKeyPairBase64 = null,Object? identityKeyBase64 = null,Object? mailboxAddresses = null,}) {
  return _then(_User(
username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,onionAddress: null == onionAddress ? _self.onionAddress : onionAddress // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: null == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String,registrationId: null == registrationId ? _self.registrationId : registrationId // ignore: cast_nullable_to_non_nullable
as int,identityKeyPairBase64: null == identityKeyPairBase64 ? _self.identityKeyPairBase64 : identityKeyPairBase64 // ignore: cast_nullable_to_non_nullable
as String,identityKeyBase64: null == identityKeyBase64 ? _self.identityKeyBase64 : identityKeyBase64 // ignore: cast_nullable_to_non_nullable
as String,mailboxAddresses: null == mailboxAddresses ? _self._mailboxAddresses : mailboxAddresses // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
