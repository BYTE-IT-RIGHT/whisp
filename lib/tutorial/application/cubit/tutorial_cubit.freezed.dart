// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tutorial_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TutorialState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TutorialState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TutorialState()';
}


}

/// @nodoc
class $TutorialStateCopyWith<$Res>  {
$TutorialStateCopyWith(TutorialState _, $Res Function(TutorialState) __);
}


/// Adds pattern-matching-related methods to [TutorialState].
extension TutorialStatePatterns on TutorialState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( TutorialInitial value)?  initial,TResult Function( TutorialCompleted value)?  completed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case TutorialInitial() when initial != null:
return initial(_that);case TutorialCompleted() when completed != null:
return completed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( TutorialInitial value)  initial,required TResult Function( TutorialCompleted value)  completed,}){
final _that = this;
switch (_that) {
case TutorialInitial():
return initial(_that);case TutorialCompleted():
return completed(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( TutorialInitial value)?  initial,TResult? Function( TutorialCompleted value)?  completed,}){
final _that = this;
switch (_that) {
case TutorialInitial() when initial != null:
return initial(_that);case TutorialCompleted() when completed != null:
return completed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  completed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case TutorialInitial() when initial != null:
return initial();case TutorialCompleted() when completed != null:
return completed();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  completed,}) {final _that = this;
switch (_that) {
case TutorialInitial():
return initial();case TutorialCompleted():
return completed();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  completed,}) {final _that = this;
switch (_that) {
case TutorialInitial() when initial != null:
return initial();case TutorialCompleted() when completed != null:
return completed();case _:
  return null;

}
}

}

/// @nodoc


class TutorialInitial implements TutorialState {
  const TutorialInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TutorialInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TutorialState.initial()';
}


}




/// @nodoc


class TutorialCompleted implements TutorialState {
  const TutorialCompleted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TutorialCompleted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TutorialState.completed()';
}


}




// dart format on
