// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mailbox.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Mailbox {

 String get onionAddress; String get pin; bool get isOnline;
/// Create a copy of Mailbox
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MailboxCopyWith<Mailbox> get copyWith => _$MailboxCopyWithImpl<Mailbox>(this as Mailbox, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Mailbox&&(identical(other.onionAddress, onionAddress) || other.onionAddress == onionAddress)&&(identical(other.pin, pin) || other.pin == pin)&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline));
}


@override
int get hashCode => Object.hash(runtimeType,onionAddress,pin,isOnline);

@override
String toString() {
  return 'Mailbox(onionAddress: $onionAddress, pin: $pin, isOnline: $isOnline)';
}


}

/// @nodoc
abstract mixin class $MailboxCopyWith<$Res>  {
  factory $MailboxCopyWith(Mailbox value, $Res Function(Mailbox) _then) = _$MailboxCopyWithImpl;
@useResult
$Res call({
 String onionAddress, String pin, bool isOnline
});




}
/// @nodoc
class _$MailboxCopyWithImpl<$Res>
    implements $MailboxCopyWith<$Res> {
  _$MailboxCopyWithImpl(this._self, this._then);

  final Mailbox _self;
  final $Res Function(Mailbox) _then;

/// Create a copy of Mailbox
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? onionAddress = null,Object? pin = null,Object? isOnline = null,}) {
  return _then(_self.copyWith(
onionAddress: null == onionAddress ? _self.onionAddress : onionAddress // ignore: cast_nullable_to_non_nullable
as String,pin: null == pin ? _self.pin : pin // ignore: cast_nullable_to_non_nullable
as String,isOnline: null == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Mailbox].
extension MailboxPatterns on Mailbox {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Mailbox value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Mailbox() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Mailbox value)  $default,){
final _that = this;
switch (_that) {
case _Mailbox():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Mailbox value)?  $default,){
final _that = this;
switch (_that) {
case _Mailbox() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String onionAddress,  String pin,  bool isOnline)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Mailbox() when $default != null:
return $default(_that.onionAddress,_that.pin,_that.isOnline);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String onionAddress,  String pin,  bool isOnline)  $default,) {final _that = this;
switch (_that) {
case _Mailbox():
return $default(_that.onionAddress,_that.pin,_that.isOnline);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String onionAddress,  String pin,  bool isOnline)?  $default,) {final _that = this;
switch (_that) {
case _Mailbox() when $default != null:
return $default(_that.onionAddress,_that.pin,_that.isOnline);case _:
  return null;

}
}

}

/// @nodoc


class _Mailbox extends Mailbox {
  const _Mailbox({required this.onionAddress, required this.pin, required this.isOnline}): super._();
  

@override final  String onionAddress;
@override final  String pin;
@override final  bool isOnline;

/// Create a copy of Mailbox
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MailboxCopyWith<_Mailbox> get copyWith => __$MailboxCopyWithImpl<_Mailbox>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Mailbox&&(identical(other.onionAddress, onionAddress) || other.onionAddress == onionAddress)&&(identical(other.pin, pin) || other.pin == pin)&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline));
}


@override
int get hashCode => Object.hash(runtimeType,onionAddress,pin,isOnline);

@override
String toString() {
  return 'Mailbox(onionAddress: $onionAddress, pin: $pin, isOnline: $isOnline)';
}


}

/// @nodoc
abstract mixin class _$MailboxCopyWith<$Res> implements $MailboxCopyWith<$Res> {
  factory _$MailboxCopyWith(_Mailbox value, $Res Function(_Mailbox) _then) = __$MailboxCopyWithImpl;
@override @useResult
$Res call({
 String onionAddress, String pin, bool isOnline
});




}
/// @nodoc
class __$MailboxCopyWithImpl<$Res>
    implements _$MailboxCopyWith<$Res> {
  __$MailboxCopyWithImpl(this._self, this._then);

  final _Mailbox _self;
  final $Res Function(_Mailbox) _then;

/// Create a copy of Mailbox
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? onionAddress = null,Object? pin = null,Object? isOnline = null,}) {
  return _then(_Mailbox(
onionAddress: null == onionAddress ? _self.onionAddress : onionAddress // ignore: cast_nullable_to_non_nullable
as String,pin: null == pin ? _self.pin : pin // ignore: cast_nullable_to_non_nullable
as String,isOnline: null == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
