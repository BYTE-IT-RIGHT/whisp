// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'local_auth_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LocalAuthState {

 bool get isEnabled; bool get requireAuthenticationOnPause; bool get isDeviceSupported; bool get hasPin; LocalAuthStatus get status;
/// Create a copy of LocalAuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocalAuthStateCopyWith<LocalAuthState> get copyWith => _$LocalAuthStateCopyWithImpl<LocalAuthState>(this as LocalAuthState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocalAuthState&&(identical(other.isEnabled, isEnabled) || other.isEnabled == isEnabled)&&(identical(other.requireAuthenticationOnPause, requireAuthenticationOnPause) || other.requireAuthenticationOnPause == requireAuthenticationOnPause)&&(identical(other.isDeviceSupported, isDeviceSupported) || other.isDeviceSupported == isDeviceSupported)&&(identical(other.hasPin, hasPin) || other.hasPin == hasPin)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,isEnabled,requireAuthenticationOnPause,isDeviceSupported,hasPin,status);

@override
String toString() {
  return 'LocalAuthState(isEnabled: $isEnabled, requireAuthenticationOnPause: $requireAuthenticationOnPause, isDeviceSupported: $isDeviceSupported, hasPin: $hasPin, status: $status)';
}


}

/// @nodoc
abstract mixin class $LocalAuthStateCopyWith<$Res>  {
  factory $LocalAuthStateCopyWith(LocalAuthState value, $Res Function(LocalAuthState) _then) = _$LocalAuthStateCopyWithImpl;
@useResult
$Res call({
 bool isEnabled, bool requireAuthenticationOnPause, bool isDeviceSupported, bool hasPin, LocalAuthStatus status
});




}
/// @nodoc
class _$LocalAuthStateCopyWithImpl<$Res>
    implements $LocalAuthStateCopyWith<$Res> {
  _$LocalAuthStateCopyWithImpl(this._self, this._then);

  final LocalAuthState _self;
  final $Res Function(LocalAuthState) _then;

/// Create a copy of LocalAuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isEnabled = null,Object? requireAuthenticationOnPause = null,Object? isDeviceSupported = null,Object? hasPin = null,Object? status = null,}) {
  return _then(_self.copyWith(
isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,requireAuthenticationOnPause: null == requireAuthenticationOnPause ? _self.requireAuthenticationOnPause : requireAuthenticationOnPause // ignore: cast_nullable_to_non_nullable
as bool,isDeviceSupported: null == isDeviceSupported ? _self.isDeviceSupported : isDeviceSupported // ignore: cast_nullable_to_non_nullable
as bool,hasPin: null == hasPin ? _self.hasPin : hasPin // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LocalAuthStatus,
  ));
}

}


/// Adds pattern-matching-related methods to [LocalAuthState].
extension LocalAuthStatePatterns on LocalAuthState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LocalAuthState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LocalAuthState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LocalAuthState value)  $default,){
final _that = this;
switch (_that) {
case _LocalAuthState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LocalAuthState value)?  $default,){
final _that = this;
switch (_that) {
case _LocalAuthState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isEnabled,  bool requireAuthenticationOnPause,  bool isDeviceSupported,  bool hasPin,  LocalAuthStatus status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LocalAuthState() when $default != null:
return $default(_that.isEnabled,_that.requireAuthenticationOnPause,_that.isDeviceSupported,_that.hasPin,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isEnabled,  bool requireAuthenticationOnPause,  bool isDeviceSupported,  bool hasPin,  LocalAuthStatus status)  $default,) {final _that = this;
switch (_that) {
case _LocalAuthState():
return $default(_that.isEnabled,_that.requireAuthenticationOnPause,_that.isDeviceSupported,_that.hasPin,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isEnabled,  bool requireAuthenticationOnPause,  bool isDeviceSupported,  bool hasPin,  LocalAuthStatus status)?  $default,) {final _that = this;
switch (_that) {
case _LocalAuthState() when $default != null:
return $default(_that.isEnabled,_that.requireAuthenticationOnPause,_that.isDeviceSupported,_that.hasPin,_that.status);case _:
  return null;

}
}

}

/// @nodoc


class _LocalAuthState implements LocalAuthState {
  const _LocalAuthState({this.isEnabled = false, this.requireAuthenticationOnPause = false, this.isDeviceSupported = false, this.hasPin = false, this.status = LocalAuthStatus.initial});
  

@override@JsonKey() final  bool isEnabled;
@override@JsonKey() final  bool requireAuthenticationOnPause;
@override@JsonKey() final  bool isDeviceSupported;
@override@JsonKey() final  bool hasPin;
@override@JsonKey() final  LocalAuthStatus status;

/// Create a copy of LocalAuthState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocalAuthStateCopyWith<_LocalAuthState> get copyWith => __$LocalAuthStateCopyWithImpl<_LocalAuthState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocalAuthState&&(identical(other.isEnabled, isEnabled) || other.isEnabled == isEnabled)&&(identical(other.requireAuthenticationOnPause, requireAuthenticationOnPause) || other.requireAuthenticationOnPause == requireAuthenticationOnPause)&&(identical(other.isDeviceSupported, isDeviceSupported) || other.isDeviceSupported == isDeviceSupported)&&(identical(other.hasPin, hasPin) || other.hasPin == hasPin)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,isEnabled,requireAuthenticationOnPause,isDeviceSupported,hasPin,status);

@override
String toString() {
  return 'LocalAuthState(isEnabled: $isEnabled, requireAuthenticationOnPause: $requireAuthenticationOnPause, isDeviceSupported: $isDeviceSupported, hasPin: $hasPin, status: $status)';
}


}

/// @nodoc
abstract mixin class _$LocalAuthStateCopyWith<$Res> implements $LocalAuthStateCopyWith<$Res> {
  factory _$LocalAuthStateCopyWith(_LocalAuthState value, $Res Function(_LocalAuthState) _then) = __$LocalAuthStateCopyWithImpl;
@override @useResult
$Res call({
 bool isEnabled, bool requireAuthenticationOnPause, bool isDeviceSupported, bool hasPin, LocalAuthStatus status
});




}
/// @nodoc
class __$LocalAuthStateCopyWithImpl<$Res>
    implements _$LocalAuthStateCopyWith<$Res> {
  __$LocalAuthStateCopyWithImpl(this._self, this._then);

  final _LocalAuthState _self;
  final $Res Function(_LocalAuthState) _then;

/// Create a copy of LocalAuthState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isEnabled = null,Object? requireAuthenticationOnPause = null,Object? isDeviceSupported = null,Object? hasPin = null,Object? status = null,}) {
  return _then(_LocalAuthState(
isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,requireAuthenticationOnPause: null == requireAuthenticationOnPause ? _self.requireAuthenticationOnPause : requireAuthenticationOnPause // ignore: cast_nullable_to_non_nullable
as bool,isDeviceSupported: null == isDeviceSupported ? _self.isDeviceSupported : isDeviceSupported // ignore: cast_nullable_to_non_nullable
as bool,hasPin: null == hasPin ? _self.hasPin : hasPin // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LocalAuthStatus,
  ));
}


}

// dart format on
