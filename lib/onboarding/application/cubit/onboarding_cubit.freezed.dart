// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OnboardingState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnboardingState()';
}


}

/// @nodoc
class $OnboardingStateCopyWith<$Res>  {
$OnboardingStateCopyWith(OnboardingState _, $Res Function(OnboardingState) __);
}


/// Adds pattern-matching-related methods to [OnboardingState].
extension OnboardingStatePatterns on OnboardingState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( OnboardingInitial value)?  initial,TResult Function( OnboardingLoading value)?  loading,TResult Function( OnboardingSuccess value)?  success,TResult Function( OnboardingError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case OnboardingInitial() when initial != null:
return initial(_that);case OnboardingLoading() when loading != null:
return loading(_that);case OnboardingSuccess() when success != null:
return success(_that);case OnboardingError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( OnboardingInitial value)  initial,required TResult Function( OnboardingLoading value)  loading,required TResult Function( OnboardingSuccess value)  success,required TResult Function( OnboardingError value)  error,}){
final _that = this;
switch (_that) {
case OnboardingInitial():
return initial(_that);case OnboardingLoading():
return loading(_that);case OnboardingSuccess():
return success(_that);case OnboardingError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( OnboardingInitial value)?  initial,TResult? Function( OnboardingLoading value)?  loading,TResult? Function( OnboardingSuccess value)?  success,TResult? Function( OnboardingError value)?  error,}){
final _that = this;
switch (_that) {
case OnboardingInitial() when initial != null:
return initial(_that);case OnboardingLoading() when loading != null:
return loading(_that);case OnboardingSuccess() when success != null:
return success(_that);case OnboardingError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function()?  success,TResult Function( Failure failure)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case OnboardingInitial() when initial != null:
return initial();case OnboardingLoading() when loading != null:
return loading();case OnboardingSuccess() when success != null:
return success();case OnboardingError() when error != null:
return error(_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function()  success,required TResult Function( Failure failure)  error,}) {final _that = this;
switch (_that) {
case OnboardingInitial():
return initial();case OnboardingLoading():
return loading();case OnboardingSuccess():
return success();case OnboardingError():
return error(_that.failure);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function()?  success,TResult? Function( Failure failure)?  error,}) {final _that = this;
switch (_that) {
case OnboardingInitial() when initial != null:
return initial();case OnboardingLoading() when loading != null:
return loading();case OnboardingSuccess() when success != null:
return success();case OnboardingError() when error != null:
return error(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class OnboardingInitial implements OnboardingState {
  const OnboardingInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnboardingState.initial()';
}


}




/// @nodoc


class OnboardingLoading implements OnboardingState {
  const OnboardingLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnboardingState.loading()';
}


}




/// @nodoc


class OnboardingSuccess implements OnboardingState {
  const OnboardingSuccess();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingSuccess);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnboardingState.success()';
}


}




/// @nodoc


class OnboardingError implements OnboardingState {
  const OnboardingError(this.failure);
  

 final  Failure failure;

/// Create a copy of OnboardingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingErrorCopyWith<OnboardingError> get copyWith => _$OnboardingErrorCopyWithImpl<OnboardingError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingError&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'OnboardingState.error(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $OnboardingErrorCopyWith<$Res> implements $OnboardingStateCopyWith<$Res> {
  factory $OnboardingErrorCopyWith(OnboardingError value, $Res Function(OnboardingError) _then) = _$OnboardingErrorCopyWithImpl;
@useResult
$Res call({
 Failure failure
});




}
/// @nodoc
class _$OnboardingErrorCopyWithImpl<$Res>
    implements $OnboardingErrorCopyWith<$Res> {
  _$OnboardingErrorCopyWithImpl(this._self, this._then);

  final OnboardingError _self;
  final $Res Function(OnboardingError) _then;

/// Create a copy of OnboardingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(OnboardingError(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}


}

// dart format on
