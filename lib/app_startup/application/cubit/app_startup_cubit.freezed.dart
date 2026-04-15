// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_startup_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppStartupState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppStartupState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppStartupState()';
}


}

/// @nodoc
class $AppStartupStateCopyWith<$Res>  {
$AppStartupStateCopyWith(AppStartupState _, $Res Function(AppStartupState) __);
}


/// Adds pattern-matching-related methods to [AppStartupState].
extension AppStartupStatePatterns on AppStartupState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AppStartupLoading value)?  loading,TResult Function( AppStartupAuthenticated value)?  authenticated,TResult Function( AppStartupTutorialPending value)?  tutorialPending,TResult Function( AppLocalAuthRequired value)?  localAuthRequired,TResult Function( AppStartupUnauthenticated value)?  unauthenticated,TResult Function( AppStartupError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AppStartupLoading() when loading != null:
return loading(_that);case AppStartupAuthenticated() when authenticated != null:
return authenticated(_that);case AppStartupTutorialPending() when tutorialPending != null:
return tutorialPending(_that);case AppLocalAuthRequired() when localAuthRequired != null:
return localAuthRequired(_that);case AppStartupUnauthenticated() when unauthenticated != null:
return unauthenticated(_that);case AppStartupError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AppStartupLoading value)  loading,required TResult Function( AppStartupAuthenticated value)  authenticated,required TResult Function( AppStartupTutorialPending value)  tutorialPending,required TResult Function( AppLocalAuthRequired value)  localAuthRequired,required TResult Function( AppStartupUnauthenticated value)  unauthenticated,required TResult Function( AppStartupError value)  error,}){
final _that = this;
switch (_that) {
case AppStartupLoading():
return loading(_that);case AppStartupAuthenticated():
return authenticated(_that);case AppStartupTutorialPending():
return tutorialPending(_that);case AppLocalAuthRequired():
return localAuthRequired(_that);case AppStartupUnauthenticated():
return unauthenticated(_that);case AppStartupError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AppStartupLoading value)?  loading,TResult? Function( AppStartupAuthenticated value)?  authenticated,TResult? Function( AppStartupTutorialPending value)?  tutorialPending,TResult? Function( AppLocalAuthRequired value)?  localAuthRequired,TResult? Function( AppStartupUnauthenticated value)?  unauthenticated,TResult? Function( AppStartupError value)?  error,}){
final _that = this;
switch (_that) {
case AppStartupLoading() when loading != null:
return loading(_that);case AppStartupAuthenticated() when authenticated != null:
return authenticated(_that);case AppStartupTutorialPending() when tutorialPending != null:
return tutorialPending(_that);case AppLocalAuthRequired() when localAuthRequired != null:
return localAuthRequired(_that);case AppStartupUnauthenticated() when unauthenticated != null:
return unauthenticated(_that);case AppStartupError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( double progress,  String statusMessage)?  loading,TResult Function( String onionAddress)?  authenticated,TResult Function( String onionAddress)?  tutorialPending,TResult Function( String onionAddress)?  localAuthRequired,TResult Function( String onionAddress)?  unauthenticated,TResult Function( Failure failure,  String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AppStartupLoading() when loading != null:
return loading(_that.progress,_that.statusMessage);case AppStartupAuthenticated() when authenticated != null:
return authenticated(_that.onionAddress);case AppStartupTutorialPending() when tutorialPending != null:
return tutorialPending(_that.onionAddress);case AppLocalAuthRequired() when localAuthRequired != null:
return localAuthRequired(_that.onionAddress);case AppStartupUnauthenticated() when unauthenticated != null:
return unauthenticated(_that.onionAddress);case AppStartupError() when error != null:
return error(_that.failure,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( double progress,  String statusMessage)  loading,required TResult Function( String onionAddress)  authenticated,required TResult Function( String onionAddress)  tutorialPending,required TResult Function( String onionAddress)  localAuthRequired,required TResult Function( String onionAddress)  unauthenticated,required TResult Function( Failure failure,  String message)  error,}) {final _that = this;
switch (_that) {
case AppStartupLoading():
return loading(_that.progress,_that.statusMessage);case AppStartupAuthenticated():
return authenticated(_that.onionAddress);case AppStartupTutorialPending():
return tutorialPending(_that.onionAddress);case AppLocalAuthRequired():
return localAuthRequired(_that.onionAddress);case AppStartupUnauthenticated():
return unauthenticated(_that.onionAddress);case AppStartupError():
return error(_that.failure,_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( double progress,  String statusMessage)?  loading,TResult? Function( String onionAddress)?  authenticated,TResult? Function( String onionAddress)?  tutorialPending,TResult? Function( String onionAddress)?  localAuthRequired,TResult? Function( String onionAddress)?  unauthenticated,TResult? Function( Failure failure,  String message)?  error,}) {final _that = this;
switch (_that) {
case AppStartupLoading() when loading != null:
return loading(_that.progress,_that.statusMessage);case AppStartupAuthenticated() when authenticated != null:
return authenticated(_that.onionAddress);case AppStartupTutorialPending() when tutorialPending != null:
return tutorialPending(_that.onionAddress);case AppLocalAuthRequired() when localAuthRequired != null:
return localAuthRequired(_that.onionAddress);case AppStartupUnauthenticated() when unauthenticated != null:
return unauthenticated(_that.onionAddress);case AppStartupError() when error != null:
return error(_that.failure,_that.message);case _:
  return null;

}
}

}

/// @nodoc


class AppStartupLoading implements AppStartupState {
  const AppStartupLoading({required this.progress, required this.statusMessage});
  

 final  double progress;
 final  String statusMessage;

/// Create a copy of AppStartupState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppStartupLoadingCopyWith<AppStartupLoading> get copyWith => _$AppStartupLoadingCopyWithImpl<AppStartupLoading>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppStartupLoading&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.statusMessage, statusMessage) || other.statusMessage == statusMessage));
}


@override
int get hashCode => Object.hash(runtimeType,progress,statusMessage);

@override
String toString() {
  return 'AppStartupState.loading(progress: $progress, statusMessage: $statusMessage)';
}


}

/// @nodoc
abstract mixin class $AppStartupLoadingCopyWith<$Res> implements $AppStartupStateCopyWith<$Res> {
  factory $AppStartupLoadingCopyWith(AppStartupLoading value, $Res Function(AppStartupLoading) _then) = _$AppStartupLoadingCopyWithImpl;
@useResult
$Res call({
 double progress, String statusMessage
});




}
/// @nodoc
class _$AppStartupLoadingCopyWithImpl<$Res>
    implements $AppStartupLoadingCopyWith<$Res> {
  _$AppStartupLoadingCopyWithImpl(this._self, this._then);

  final AppStartupLoading _self;
  final $Res Function(AppStartupLoading) _then;

/// Create a copy of AppStartupState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? progress = null,Object? statusMessage = null,}) {
  return _then(AppStartupLoading(
progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,statusMessage: null == statusMessage ? _self.statusMessage : statusMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AppStartupAuthenticated implements AppStartupState {
  const AppStartupAuthenticated({required this.onionAddress});
  

 final  String onionAddress;

/// Create a copy of AppStartupState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppStartupAuthenticatedCopyWith<AppStartupAuthenticated> get copyWith => _$AppStartupAuthenticatedCopyWithImpl<AppStartupAuthenticated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppStartupAuthenticated&&(identical(other.onionAddress, onionAddress) || other.onionAddress == onionAddress));
}


@override
int get hashCode => Object.hash(runtimeType,onionAddress);

@override
String toString() {
  return 'AppStartupState.authenticated(onionAddress: $onionAddress)';
}


}

/// @nodoc
abstract mixin class $AppStartupAuthenticatedCopyWith<$Res> implements $AppStartupStateCopyWith<$Res> {
  factory $AppStartupAuthenticatedCopyWith(AppStartupAuthenticated value, $Res Function(AppStartupAuthenticated) _then) = _$AppStartupAuthenticatedCopyWithImpl;
@useResult
$Res call({
 String onionAddress
});




}
/// @nodoc
class _$AppStartupAuthenticatedCopyWithImpl<$Res>
    implements $AppStartupAuthenticatedCopyWith<$Res> {
  _$AppStartupAuthenticatedCopyWithImpl(this._self, this._then);

  final AppStartupAuthenticated _self;
  final $Res Function(AppStartupAuthenticated) _then;

/// Create a copy of AppStartupState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? onionAddress = null,}) {
  return _then(AppStartupAuthenticated(
onionAddress: null == onionAddress ? _self.onionAddress : onionAddress // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AppStartupTutorialPending implements AppStartupState {
  const AppStartupTutorialPending(this.onionAddress);
  

 final  String onionAddress;

/// Create a copy of AppStartupState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppStartupTutorialPendingCopyWith<AppStartupTutorialPending> get copyWith => _$AppStartupTutorialPendingCopyWithImpl<AppStartupTutorialPending>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppStartupTutorialPending&&(identical(other.onionAddress, onionAddress) || other.onionAddress == onionAddress));
}


@override
int get hashCode => Object.hash(runtimeType,onionAddress);

@override
String toString() {
  return 'AppStartupState.tutorialPending(onionAddress: $onionAddress)';
}


}

/// @nodoc
abstract mixin class $AppStartupTutorialPendingCopyWith<$Res> implements $AppStartupStateCopyWith<$Res> {
  factory $AppStartupTutorialPendingCopyWith(AppStartupTutorialPending value, $Res Function(AppStartupTutorialPending) _then) = _$AppStartupTutorialPendingCopyWithImpl;
@useResult
$Res call({
 String onionAddress
});




}
/// @nodoc
class _$AppStartupTutorialPendingCopyWithImpl<$Res>
    implements $AppStartupTutorialPendingCopyWith<$Res> {
  _$AppStartupTutorialPendingCopyWithImpl(this._self, this._then);

  final AppStartupTutorialPending _self;
  final $Res Function(AppStartupTutorialPending) _then;

/// Create a copy of AppStartupState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? onionAddress = null,}) {
  return _then(AppStartupTutorialPending(
null == onionAddress ? _self.onionAddress : onionAddress // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AppLocalAuthRequired implements AppStartupState {
  const AppLocalAuthRequired(this.onionAddress);
  

 final  String onionAddress;

/// Create a copy of AppStartupState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppLocalAuthRequiredCopyWith<AppLocalAuthRequired> get copyWith => _$AppLocalAuthRequiredCopyWithImpl<AppLocalAuthRequired>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppLocalAuthRequired&&(identical(other.onionAddress, onionAddress) || other.onionAddress == onionAddress));
}


@override
int get hashCode => Object.hash(runtimeType,onionAddress);

@override
String toString() {
  return 'AppStartupState.localAuthRequired(onionAddress: $onionAddress)';
}


}

/// @nodoc
abstract mixin class $AppLocalAuthRequiredCopyWith<$Res> implements $AppStartupStateCopyWith<$Res> {
  factory $AppLocalAuthRequiredCopyWith(AppLocalAuthRequired value, $Res Function(AppLocalAuthRequired) _then) = _$AppLocalAuthRequiredCopyWithImpl;
@useResult
$Res call({
 String onionAddress
});




}
/// @nodoc
class _$AppLocalAuthRequiredCopyWithImpl<$Res>
    implements $AppLocalAuthRequiredCopyWith<$Res> {
  _$AppLocalAuthRequiredCopyWithImpl(this._self, this._then);

  final AppLocalAuthRequired _self;
  final $Res Function(AppLocalAuthRequired) _then;

/// Create a copy of AppStartupState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? onionAddress = null,}) {
  return _then(AppLocalAuthRequired(
null == onionAddress ? _self.onionAddress : onionAddress // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AppStartupUnauthenticated implements AppStartupState {
  const AppStartupUnauthenticated(this.onionAddress);
  

 final  String onionAddress;

/// Create a copy of AppStartupState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppStartupUnauthenticatedCopyWith<AppStartupUnauthenticated> get copyWith => _$AppStartupUnauthenticatedCopyWithImpl<AppStartupUnauthenticated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppStartupUnauthenticated&&(identical(other.onionAddress, onionAddress) || other.onionAddress == onionAddress));
}


@override
int get hashCode => Object.hash(runtimeType,onionAddress);

@override
String toString() {
  return 'AppStartupState.unauthenticated(onionAddress: $onionAddress)';
}


}

/// @nodoc
abstract mixin class $AppStartupUnauthenticatedCopyWith<$Res> implements $AppStartupStateCopyWith<$Res> {
  factory $AppStartupUnauthenticatedCopyWith(AppStartupUnauthenticated value, $Res Function(AppStartupUnauthenticated) _then) = _$AppStartupUnauthenticatedCopyWithImpl;
@useResult
$Res call({
 String onionAddress
});




}
/// @nodoc
class _$AppStartupUnauthenticatedCopyWithImpl<$Res>
    implements $AppStartupUnauthenticatedCopyWith<$Res> {
  _$AppStartupUnauthenticatedCopyWithImpl(this._self, this._then);

  final AppStartupUnauthenticated _self;
  final $Res Function(AppStartupUnauthenticated) _then;

/// Create a copy of AppStartupState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? onionAddress = null,}) {
  return _then(AppStartupUnauthenticated(
null == onionAddress ? _self.onionAddress : onionAddress // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AppStartupError implements AppStartupState {
  const AppStartupError(this.failure, [this.message = '']);
  

 final  Failure failure;
@JsonKey() final  String message;

/// Create a copy of AppStartupState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppStartupErrorCopyWith<AppStartupError> get copyWith => _$AppStartupErrorCopyWithImpl<AppStartupError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppStartupError&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,failure,message);

@override
String toString() {
  return 'AppStartupState.error(failure: $failure, message: $message)';
}


}

/// @nodoc
abstract mixin class $AppStartupErrorCopyWith<$Res> implements $AppStartupStateCopyWith<$Res> {
  factory $AppStartupErrorCopyWith(AppStartupError value, $Res Function(AppStartupError) _then) = _$AppStartupErrorCopyWithImpl;
@useResult
$Res call({
 Failure failure, String message
});




}
/// @nodoc
class _$AppStartupErrorCopyWithImpl<$Res>
    implements $AppStartupErrorCopyWith<$Res> {
  _$AppStartupErrorCopyWithImpl(this._self, this._then);

  final AppStartupError _self;
  final $Res Function(AppStartupError) _then;

/// Create a copy of AppStartupState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,Object? message = null,}) {
  return _then(AppStartupError(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
