// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contact.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Contact {

@HiveField(0) String get onionAddress;@HiveField(1) String get username;@HiveField(2) String get avatarUrl;@HiveField(3) String get identityKeyBase64;@HiveField(4) String? get preKeyBundleBase64;@HiveField(5) String? get mailboxAddress;
/// Create a copy of Contact
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContactCopyWith<Contact> get copyWith => _$ContactCopyWithImpl<Contact>(this as Contact, _$identity);

  /// Serializes this Contact to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Contact&&(identical(other.onionAddress, onionAddress) || other.onionAddress == onionAddress)&&(identical(other.username, username) || other.username == username)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.identityKeyBase64, identityKeyBase64) || other.identityKeyBase64 == identityKeyBase64)&&(identical(other.preKeyBundleBase64, preKeyBundleBase64) || other.preKeyBundleBase64 == preKeyBundleBase64)&&(identical(other.mailboxAddress, mailboxAddress) || other.mailboxAddress == mailboxAddress));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,onionAddress,username,avatarUrl,identityKeyBase64,preKeyBundleBase64,mailboxAddress);

@override
String toString() {
  return 'Contact(onionAddress: $onionAddress, username: $username, avatarUrl: $avatarUrl, identityKeyBase64: $identityKeyBase64, preKeyBundleBase64: $preKeyBundleBase64, mailboxAddress: $mailboxAddress)';
}


}

/// @nodoc
abstract mixin class $ContactCopyWith<$Res>  {
  factory $ContactCopyWith(Contact value, $Res Function(Contact) _then) = _$ContactCopyWithImpl;
@useResult
$Res call({
@HiveField(0) String onionAddress,@HiveField(1) String username,@HiveField(2) String avatarUrl,@HiveField(3) String identityKeyBase64,@HiveField(4) String? preKeyBundleBase64,@HiveField(5) String? mailboxAddress
});




}
/// @nodoc
class _$ContactCopyWithImpl<$Res>
    implements $ContactCopyWith<$Res> {
  _$ContactCopyWithImpl(this._self, this._then);

  final Contact _self;
  final $Res Function(Contact) _then;

/// Create a copy of Contact
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? onionAddress = null,Object? username = null,Object? avatarUrl = null,Object? identityKeyBase64 = null,Object? preKeyBundleBase64 = freezed,Object? mailboxAddress = freezed,}) {
  return _then(_self.copyWith(
onionAddress: null == onionAddress ? _self.onionAddress : onionAddress // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: null == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String,identityKeyBase64: null == identityKeyBase64 ? _self.identityKeyBase64 : identityKeyBase64 // ignore: cast_nullable_to_non_nullable
as String,preKeyBundleBase64: freezed == preKeyBundleBase64 ? _self.preKeyBundleBase64 : preKeyBundleBase64 // ignore: cast_nullable_to_non_nullable
as String?,mailboxAddress: freezed == mailboxAddress ? _self.mailboxAddress : mailboxAddress // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Contact].
extension ContactPatterns on Contact {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Contact value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Contact() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Contact value)  $default,){
final _that = this;
switch (_that) {
case _Contact():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Contact value)?  $default,){
final _that = this;
switch (_that) {
case _Contact() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@HiveField(0)  String onionAddress, @HiveField(1)  String username, @HiveField(2)  String avatarUrl, @HiveField(3)  String identityKeyBase64, @HiveField(4)  String? preKeyBundleBase64, @HiveField(5)  String? mailboxAddress)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Contact() when $default != null:
return $default(_that.onionAddress,_that.username,_that.avatarUrl,_that.identityKeyBase64,_that.preKeyBundleBase64,_that.mailboxAddress);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@HiveField(0)  String onionAddress, @HiveField(1)  String username, @HiveField(2)  String avatarUrl, @HiveField(3)  String identityKeyBase64, @HiveField(4)  String? preKeyBundleBase64, @HiveField(5)  String? mailboxAddress)  $default,) {final _that = this;
switch (_that) {
case _Contact():
return $default(_that.onionAddress,_that.username,_that.avatarUrl,_that.identityKeyBase64,_that.preKeyBundleBase64,_that.mailboxAddress);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@HiveField(0)  String onionAddress, @HiveField(1)  String username, @HiveField(2)  String avatarUrl, @HiveField(3)  String identityKeyBase64, @HiveField(4)  String? preKeyBundleBase64, @HiveField(5)  String? mailboxAddress)?  $default,) {final _that = this;
switch (_that) {
case _Contact() when $default != null:
return $default(_that.onionAddress,_that.username,_that.avatarUrl,_that.identityKeyBase64,_that.preKeyBundleBase64,_that.mailboxAddress);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Contact extends Contact {
  const _Contact({@HiveField(0) required this.onionAddress, @HiveField(1) required this.username, @HiveField(2) required this.avatarUrl, @HiveField(3) required this.identityKeyBase64, @HiveField(4) this.preKeyBundleBase64, @HiveField(5) this.mailboxAddress}): super._();
  factory _Contact.fromJson(Map<String, dynamic> json) => _$ContactFromJson(json);

@override@HiveField(0) final  String onionAddress;
@override@HiveField(1) final  String username;
@override@HiveField(2) final  String avatarUrl;
@override@HiveField(3) final  String identityKeyBase64;
@override@HiveField(4) final  String? preKeyBundleBase64;
@override@HiveField(5) final  String? mailboxAddress;

/// Create a copy of Contact
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContactCopyWith<_Contact> get copyWith => __$ContactCopyWithImpl<_Contact>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContactToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Contact&&(identical(other.onionAddress, onionAddress) || other.onionAddress == onionAddress)&&(identical(other.username, username) || other.username == username)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.identityKeyBase64, identityKeyBase64) || other.identityKeyBase64 == identityKeyBase64)&&(identical(other.preKeyBundleBase64, preKeyBundleBase64) || other.preKeyBundleBase64 == preKeyBundleBase64)&&(identical(other.mailboxAddress, mailboxAddress) || other.mailboxAddress == mailboxAddress));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,onionAddress,username,avatarUrl,identityKeyBase64,preKeyBundleBase64,mailboxAddress);

@override
String toString() {
  return 'Contact(onionAddress: $onionAddress, username: $username, avatarUrl: $avatarUrl, identityKeyBase64: $identityKeyBase64, preKeyBundleBase64: $preKeyBundleBase64, mailboxAddress: $mailboxAddress)';
}


}

/// @nodoc
abstract mixin class _$ContactCopyWith<$Res> implements $ContactCopyWith<$Res> {
  factory _$ContactCopyWith(_Contact value, $Res Function(_Contact) _then) = __$ContactCopyWithImpl;
@override @useResult
$Res call({
@HiveField(0) String onionAddress,@HiveField(1) String username,@HiveField(2) String avatarUrl,@HiveField(3) String identityKeyBase64,@HiveField(4) String? preKeyBundleBase64,@HiveField(5) String? mailboxAddress
});




}
/// @nodoc
class __$ContactCopyWithImpl<$Res>
    implements _$ContactCopyWith<$Res> {
  __$ContactCopyWithImpl(this._self, this._then);

  final _Contact _self;
  final $Res Function(_Contact) _then;

/// Create a copy of Contact
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? onionAddress = null,Object? username = null,Object? avatarUrl = null,Object? identityKeyBase64 = null,Object? preKeyBundleBase64 = freezed,Object? mailboxAddress = freezed,}) {
  return _then(_Contact(
onionAddress: null == onionAddress ? _self.onionAddress : onionAddress // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: null == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String,identityKeyBase64: null == identityKeyBase64 ? _self.identityKeyBase64 : identityKeyBase64 // ignore: cast_nullable_to_non_nullable
as String,preKeyBundleBase64: freezed == preKeyBundleBase64 ? _self.preKeyBundleBase64 : preKeyBundleBase64 // ignore: cast_nullable_to_non_nullable
as String?,mailboxAddress: freezed == mailboxAddress ? _self.mailboxAddress : mailboxAddress // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
