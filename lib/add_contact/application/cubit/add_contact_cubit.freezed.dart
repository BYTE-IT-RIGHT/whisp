// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_contact_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AddContactState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddContactState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AddContactState()';
}


}

/// @nodoc
class $AddContactStateCopyWith<$Res>  {
$AddContactStateCopyWith(AddContactState _, $Res Function(AddContactState) __);
}


/// Adds pattern-matching-related methods to [AddContactState].
extension AddContactStatePatterns on AddContactState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AddContactLoading value)?  loading,TResult Function( AddContactData value)?  data,TResult Function( AddContactWaiting value)?  waiting,TResult Function( AddContactSuccess value)?  success,TResult Function( AddContactDeclined value)?  declined,TResult Function( AddContactError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AddContactLoading() when loading != null:
return loading(_that);case AddContactData() when data != null:
return data(_that);case AddContactWaiting() when waiting != null:
return waiting(_that);case AddContactSuccess() when success != null:
return success(_that);case AddContactDeclined() when declined != null:
return declined(_that);case AddContactError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AddContactLoading value)  loading,required TResult Function( AddContactData value)  data,required TResult Function( AddContactWaiting value)  waiting,required TResult Function( AddContactSuccess value)  success,required TResult Function( AddContactDeclined value)  declined,required TResult Function( AddContactError value)  error,}){
final _that = this;
switch (_that) {
case AddContactLoading():
return loading(_that);case AddContactData():
return data(_that);case AddContactWaiting():
return waiting(_that);case AddContactSuccess():
return success(_that);case AddContactDeclined():
return declined(_that);case AddContactError():
return error(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AddContactLoading value)?  loading,TResult? Function( AddContactData value)?  data,TResult? Function( AddContactWaiting value)?  waiting,TResult? Function( AddContactSuccess value)?  success,TResult? Function( AddContactDeclined value)?  declined,TResult? Function( AddContactError value)?  error,}){
final _that = this;
switch (_that) {
case AddContactLoading() when loading != null:
return loading(_that);case AddContactData() when data != null:
return data(_that);case AddContactWaiting() when waiting != null:
return waiting(_that);case AddContactSuccess() when success != null:
return success(_that);case AddContactDeclined() when declined != null:
return declined(_that);case AddContactError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( String onionAddress)?  data,TResult Function( String onionAddress)?  waiting,TResult Function( String username)?  success,TResult Function( String onionAddress)?  declined,TResult Function( Failure failure,  String onionAddress)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AddContactLoading() when loading != null:
return loading();case AddContactData() when data != null:
return data(_that.onionAddress);case AddContactWaiting() when waiting != null:
return waiting(_that.onionAddress);case AddContactSuccess() when success != null:
return success(_that.username);case AddContactDeclined() when declined != null:
return declined(_that.onionAddress);case AddContactError() when error != null:
return error(_that.failure,_that.onionAddress);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( String onionAddress)  data,required TResult Function( String onionAddress)  waiting,required TResult Function( String username)  success,required TResult Function( String onionAddress)  declined,required TResult Function( Failure failure,  String onionAddress)  error,}) {final _that = this;
switch (_that) {
case AddContactLoading():
return loading();case AddContactData():
return data(_that.onionAddress);case AddContactWaiting():
return waiting(_that.onionAddress);case AddContactSuccess():
return success(_that.username);case AddContactDeclined():
return declined(_that.onionAddress);case AddContactError():
return error(_that.failure,_that.onionAddress);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( String onionAddress)?  data,TResult? Function( String onionAddress)?  waiting,TResult? Function( String username)?  success,TResult? Function( String onionAddress)?  declined,TResult? Function( Failure failure,  String onionAddress)?  error,}) {final _that = this;
switch (_that) {
case AddContactLoading() when loading != null:
return loading();case AddContactData() when data != null:
return data(_that.onionAddress);case AddContactWaiting() when waiting != null:
return waiting(_that.onionAddress);case AddContactSuccess() when success != null:
return success(_that.username);case AddContactDeclined() when declined != null:
return declined(_that.onionAddress);case AddContactError() when error != null:
return error(_that.failure,_that.onionAddress);case _:
  return null;

}
}

}

/// @nodoc


class AddContactLoading implements AddContactState {
  const AddContactLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddContactLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AddContactState.loading()';
}


}




/// @nodoc


class AddContactData implements AddContactState {
  const AddContactData({required this.onionAddress});
  

 final  String onionAddress;

/// Create a copy of AddContactState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddContactDataCopyWith<AddContactData> get copyWith => _$AddContactDataCopyWithImpl<AddContactData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddContactData&&(identical(other.onionAddress, onionAddress) || other.onionAddress == onionAddress));
}


@override
int get hashCode => Object.hash(runtimeType,onionAddress);

@override
String toString() {
  return 'AddContactState.data(onionAddress: $onionAddress)';
}


}

/// @nodoc
abstract mixin class $AddContactDataCopyWith<$Res> implements $AddContactStateCopyWith<$Res> {
  factory $AddContactDataCopyWith(AddContactData value, $Res Function(AddContactData) _then) = _$AddContactDataCopyWithImpl;
@useResult
$Res call({
 String onionAddress
});




}
/// @nodoc
class _$AddContactDataCopyWithImpl<$Res>
    implements $AddContactDataCopyWith<$Res> {
  _$AddContactDataCopyWithImpl(this._self, this._then);

  final AddContactData _self;
  final $Res Function(AddContactData) _then;

/// Create a copy of AddContactState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? onionAddress = null,}) {
  return _then(AddContactData(
onionAddress: null == onionAddress ? _self.onionAddress : onionAddress // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AddContactWaiting implements AddContactState {
  const AddContactWaiting({required this.onionAddress});
  

 final  String onionAddress;

/// Create a copy of AddContactState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddContactWaitingCopyWith<AddContactWaiting> get copyWith => _$AddContactWaitingCopyWithImpl<AddContactWaiting>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddContactWaiting&&(identical(other.onionAddress, onionAddress) || other.onionAddress == onionAddress));
}


@override
int get hashCode => Object.hash(runtimeType,onionAddress);

@override
String toString() {
  return 'AddContactState.waiting(onionAddress: $onionAddress)';
}


}

/// @nodoc
abstract mixin class $AddContactWaitingCopyWith<$Res> implements $AddContactStateCopyWith<$Res> {
  factory $AddContactWaitingCopyWith(AddContactWaiting value, $Res Function(AddContactWaiting) _then) = _$AddContactWaitingCopyWithImpl;
@useResult
$Res call({
 String onionAddress
});




}
/// @nodoc
class _$AddContactWaitingCopyWithImpl<$Res>
    implements $AddContactWaitingCopyWith<$Res> {
  _$AddContactWaitingCopyWithImpl(this._self, this._then);

  final AddContactWaiting _self;
  final $Res Function(AddContactWaiting) _then;

/// Create a copy of AddContactState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? onionAddress = null,}) {
  return _then(AddContactWaiting(
onionAddress: null == onionAddress ? _self.onionAddress : onionAddress // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AddContactSuccess implements AddContactState {
  const AddContactSuccess({required this.username});
  

 final  String username;

/// Create a copy of AddContactState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddContactSuccessCopyWith<AddContactSuccess> get copyWith => _$AddContactSuccessCopyWithImpl<AddContactSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddContactSuccess&&(identical(other.username, username) || other.username == username));
}


@override
int get hashCode => Object.hash(runtimeType,username);

@override
String toString() {
  return 'AddContactState.success(username: $username)';
}


}

/// @nodoc
abstract mixin class $AddContactSuccessCopyWith<$Res> implements $AddContactStateCopyWith<$Res> {
  factory $AddContactSuccessCopyWith(AddContactSuccess value, $Res Function(AddContactSuccess) _then) = _$AddContactSuccessCopyWithImpl;
@useResult
$Res call({
 String username
});




}
/// @nodoc
class _$AddContactSuccessCopyWithImpl<$Res>
    implements $AddContactSuccessCopyWith<$Res> {
  _$AddContactSuccessCopyWithImpl(this._self, this._then);

  final AddContactSuccess _self;
  final $Res Function(AddContactSuccess) _then;

/// Create a copy of AddContactState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? username = null,}) {
  return _then(AddContactSuccess(
username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AddContactDeclined implements AddContactState {
  const AddContactDeclined({required this.onionAddress});
  

 final  String onionAddress;

/// Create a copy of AddContactState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddContactDeclinedCopyWith<AddContactDeclined> get copyWith => _$AddContactDeclinedCopyWithImpl<AddContactDeclined>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddContactDeclined&&(identical(other.onionAddress, onionAddress) || other.onionAddress == onionAddress));
}


@override
int get hashCode => Object.hash(runtimeType,onionAddress);

@override
String toString() {
  return 'AddContactState.declined(onionAddress: $onionAddress)';
}


}

/// @nodoc
abstract mixin class $AddContactDeclinedCopyWith<$Res> implements $AddContactStateCopyWith<$Res> {
  factory $AddContactDeclinedCopyWith(AddContactDeclined value, $Res Function(AddContactDeclined) _then) = _$AddContactDeclinedCopyWithImpl;
@useResult
$Res call({
 String onionAddress
});




}
/// @nodoc
class _$AddContactDeclinedCopyWithImpl<$Res>
    implements $AddContactDeclinedCopyWith<$Res> {
  _$AddContactDeclinedCopyWithImpl(this._self, this._then);

  final AddContactDeclined _self;
  final $Res Function(AddContactDeclined) _then;

/// Create a copy of AddContactState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? onionAddress = null,}) {
  return _then(AddContactDeclined(
onionAddress: null == onionAddress ? _self.onionAddress : onionAddress // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AddContactError implements AddContactState {
  const AddContactError(this.failure, {required this.onionAddress});
  

 final  Failure failure;
 final  String onionAddress;

/// Create a copy of AddContactState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddContactErrorCopyWith<AddContactError> get copyWith => _$AddContactErrorCopyWithImpl<AddContactError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddContactError&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.onionAddress, onionAddress) || other.onionAddress == onionAddress));
}


@override
int get hashCode => Object.hash(runtimeType,failure,onionAddress);

@override
String toString() {
  return 'AddContactState.error(failure: $failure, onionAddress: $onionAddress)';
}


}

/// @nodoc
abstract mixin class $AddContactErrorCopyWith<$Res> implements $AddContactStateCopyWith<$Res> {
  factory $AddContactErrorCopyWith(AddContactError value, $Res Function(AddContactError) _then) = _$AddContactErrorCopyWithImpl;
@useResult
$Res call({
 Failure failure, String onionAddress
});




}
/// @nodoc
class _$AddContactErrorCopyWithImpl<$Res>
    implements $AddContactErrorCopyWith<$Res> {
  _$AddContactErrorCopyWithImpl(this._self, this._then);

  final AddContactError _self;
  final $Res Function(AddContactError) _then;

/// Create a copy of AddContactState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,Object? onionAddress = null,}) {
  return _then(AddContactError(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,onionAddress: null == onionAddress ? _self.onionAddress : onionAddress // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
