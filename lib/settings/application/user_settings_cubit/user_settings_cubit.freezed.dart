// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_settings_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserSettingsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserSettingsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UserSettingsState()';
}


}

/// @nodoc
class $UserSettingsStateCopyWith<$Res>  {
$UserSettingsStateCopyWith(UserSettingsState _, $Res Function(UserSettingsState) __);
}


/// Adds pattern-matching-related methods to [UserSettingsState].
extension UserSettingsStatePatterns on UserSettingsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( UserSettingsInitial value)?  initial,TResult Function( UserSettingsData value)?  data,required TResult orElse(),}){
final _that = this;
switch (_that) {
case UserSettingsInitial() when initial != null:
return initial(_that);case UserSettingsData() when data != null:
return data(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( UserSettingsInitial value)  initial,required TResult Function( UserSettingsData value)  data,}){
final _that = this;
switch (_that) {
case UserSettingsInitial():
return initial(_that);case UserSettingsData():
return data(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( UserSettingsInitial value)?  initial,TResult? Function( UserSettingsData value)?  data,}){
final _that = this;
switch (_that) {
case UserSettingsInitial() when initial != null:
return initial(_that);case UserSettingsData() when data != null:
return data(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( String username,  String avatarUrl)?  data,required TResult orElse(),}) {final _that = this;
switch (_that) {
case UserSettingsInitial() when initial != null:
return initial();case UserSettingsData() when data != null:
return data(_that.username,_that.avatarUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( String username,  String avatarUrl)  data,}) {final _that = this;
switch (_that) {
case UserSettingsInitial():
return initial();case UserSettingsData():
return data(_that.username,_that.avatarUrl);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( String username,  String avatarUrl)?  data,}) {final _that = this;
switch (_that) {
case UserSettingsInitial() when initial != null:
return initial();case UserSettingsData() when data != null:
return data(_that.username,_that.avatarUrl);case _:
  return null;

}
}

}

/// @nodoc


class UserSettingsInitial implements UserSettingsState {
  const UserSettingsInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserSettingsInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UserSettingsState.initial()';
}


}




/// @nodoc


class UserSettingsData implements UserSettingsState {
  const UserSettingsData({required this.username, required this.avatarUrl});
  

 final  String username;
 final  String avatarUrl;

/// Create a copy of UserSettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserSettingsDataCopyWith<UserSettingsData> get copyWith => _$UserSettingsDataCopyWithImpl<UserSettingsData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserSettingsData&&(identical(other.username, username) || other.username == username)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}


@override
int get hashCode => Object.hash(runtimeType,username,avatarUrl);

@override
String toString() {
  return 'UserSettingsState.data(username: $username, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class $UserSettingsDataCopyWith<$Res> implements $UserSettingsStateCopyWith<$Res> {
  factory $UserSettingsDataCopyWith(UserSettingsData value, $Res Function(UserSettingsData) _then) = _$UserSettingsDataCopyWithImpl;
@useResult
$Res call({
 String username, String avatarUrl
});




}
/// @nodoc
class _$UserSettingsDataCopyWithImpl<$Res>
    implements $UserSettingsDataCopyWith<$Res> {
  _$UserSettingsDataCopyWithImpl(this._self, this._then);

  final UserSettingsData _self;
  final $Res Function(UserSettingsData) _then;

/// Create a copy of UserSettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? username = null,Object? avatarUrl = null,}) {
  return _then(UserSettingsData(
username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: null == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
