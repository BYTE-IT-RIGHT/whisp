// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invitation_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InvitationState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvitationState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'InvitationState()';
}


}

/// @nodoc
class $InvitationStateCopyWith<$Res>  {
$InvitationStateCopyWith(InvitationState _, $Res Function(InvitationState) __);
}


/// Adds pattern-matching-related methods to [InvitationState].
extension InvitationStatePatterns on InvitationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( InvitationInitial value)?  initial,TResult Function( InvitationPending value)?  pending,TResult Function( InvitationAccepting value)?  accepting,TResult Function( InvitationAccepted value)?  accepted,TResult Function( InvitationDeclined value)?  declined,TResult Function( InvitationError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case InvitationInitial() when initial != null:
return initial(_that);case InvitationPending() when pending != null:
return pending(_that);case InvitationAccepting() when accepting != null:
return accepting(_that);case InvitationAccepted() when accepted != null:
return accepted(_that);case InvitationDeclined() when declined != null:
return declined(_that);case InvitationError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( InvitationInitial value)  initial,required TResult Function( InvitationPending value)  pending,required TResult Function( InvitationAccepting value)  accepting,required TResult Function( InvitationAccepted value)  accepted,required TResult Function( InvitationDeclined value)  declined,required TResult Function( InvitationError value)  error,}){
final _that = this;
switch (_that) {
case InvitationInitial():
return initial(_that);case InvitationPending():
return pending(_that);case InvitationAccepting():
return accepting(_that);case InvitationAccepted():
return accepted(_that);case InvitationDeclined():
return declined(_that);case InvitationError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( InvitationInitial value)?  initial,TResult? Function( InvitationPending value)?  pending,TResult? Function( InvitationAccepting value)?  accepting,TResult? Function( InvitationAccepted value)?  accepted,TResult? Function( InvitationDeclined value)?  declined,TResult? Function( InvitationError value)?  error,}){
final _that = this;
switch (_that) {
case InvitationInitial() when initial != null:
return initial(_that);case InvitationPending() when pending != null:
return pending(_that);case InvitationAccepting() when accepting != null:
return accepting(_that);case InvitationAccepted() when accepted != null:
return accepted(_that);case InvitationDeclined() when declined != null:
return declined(_that);case InvitationError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( Message invitation)?  pending,TResult Function( Message invitation)?  accepting,TResult Function( Message invitation)?  accepted,TResult Function( Message invitation)?  declined,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case InvitationInitial() when initial != null:
return initial();case InvitationPending() when pending != null:
return pending(_that.invitation);case InvitationAccepting() when accepting != null:
return accepting(_that.invitation);case InvitationAccepted() when accepted != null:
return accepted(_that.invitation);case InvitationDeclined() when declined != null:
return declined(_that.invitation);case InvitationError() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( Message invitation)  pending,required TResult Function( Message invitation)  accepting,required TResult Function( Message invitation)  accepted,required TResult Function( Message invitation)  declined,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case InvitationInitial():
return initial();case InvitationPending():
return pending(_that.invitation);case InvitationAccepting():
return accepting(_that.invitation);case InvitationAccepted():
return accepted(_that.invitation);case InvitationDeclined():
return declined(_that.invitation);case InvitationError():
return error(_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( Message invitation)?  pending,TResult? Function( Message invitation)?  accepting,TResult? Function( Message invitation)?  accepted,TResult? Function( Message invitation)?  declined,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case InvitationInitial() when initial != null:
return initial();case InvitationPending() when pending != null:
return pending(_that.invitation);case InvitationAccepting() when accepting != null:
return accepting(_that.invitation);case InvitationAccepted() when accepted != null:
return accepted(_that.invitation);case InvitationDeclined() when declined != null:
return declined(_that.invitation);case InvitationError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class InvitationInitial implements InvitationState {
  const InvitationInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvitationInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'InvitationState.initial()';
}


}




/// @nodoc


class InvitationPending implements InvitationState {
  const InvitationPending({required this.invitation});
  

 final  Message invitation;

/// Create a copy of InvitationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvitationPendingCopyWith<InvitationPending> get copyWith => _$InvitationPendingCopyWithImpl<InvitationPending>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvitationPending&&(identical(other.invitation, invitation) || other.invitation == invitation));
}


@override
int get hashCode => Object.hash(runtimeType,invitation);

@override
String toString() {
  return 'InvitationState.pending(invitation: $invitation)';
}


}

/// @nodoc
abstract mixin class $InvitationPendingCopyWith<$Res> implements $InvitationStateCopyWith<$Res> {
  factory $InvitationPendingCopyWith(InvitationPending value, $Res Function(InvitationPending) _then) = _$InvitationPendingCopyWithImpl;
@useResult
$Res call({
 Message invitation
});




}
/// @nodoc
class _$InvitationPendingCopyWithImpl<$Res>
    implements $InvitationPendingCopyWith<$Res> {
  _$InvitationPendingCopyWithImpl(this._self, this._then);

  final InvitationPending _self;
  final $Res Function(InvitationPending) _then;

/// Create a copy of InvitationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? invitation = null,}) {
  return _then(InvitationPending(
invitation: null == invitation ? _self.invitation : invitation // ignore: cast_nullable_to_non_nullable
as Message,
  ));
}


}

/// @nodoc


class InvitationAccepting implements InvitationState {
  const InvitationAccepting({required this.invitation});
  

 final  Message invitation;

/// Create a copy of InvitationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvitationAcceptingCopyWith<InvitationAccepting> get copyWith => _$InvitationAcceptingCopyWithImpl<InvitationAccepting>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvitationAccepting&&(identical(other.invitation, invitation) || other.invitation == invitation));
}


@override
int get hashCode => Object.hash(runtimeType,invitation);

@override
String toString() {
  return 'InvitationState.accepting(invitation: $invitation)';
}


}

/// @nodoc
abstract mixin class $InvitationAcceptingCopyWith<$Res> implements $InvitationStateCopyWith<$Res> {
  factory $InvitationAcceptingCopyWith(InvitationAccepting value, $Res Function(InvitationAccepting) _then) = _$InvitationAcceptingCopyWithImpl;
@useResult
$Res call({
 Message invitation
});




}
/// @nodoc
class _$InvitationAcceptingCopyWithImpl<$Res>
    implements $InvitationAcceptingCopyWith<$Res> {
  _$InvitationAcceptingCopyWithImpl(this._self, this._then);

  final InvitationAccepting _self;
  final $Res Function(InvitationAccepting) _then;

/// Create a copy of InvitationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? invitation = null,}) {
  return _then(InvitationAccepting(
invitation: null == invitation ? _self.invitation : invitation // ignore: cast_nullable_to_non_nullable
as Message,
  ));
}


}

/// @nodoc


class InvitationAccepted implements InvitationState {
  const InvitationAccepted({required this.invitation});
  

 final  Message invitation;

/// Create a copy of InvitationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvitationAcceptedCopyWith<InvitationAccepted> get copyWith => _$InvitationAcceptedCopyWithImpl<InvitationAccepted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvitationAccepted&&(identical(other.invitation, invitation) || other.invitation == invitation));
}


@override
int get hashCode => Object.hash(runtimeType,invitation);

@override
String toString() {
  return 'InvitationState.accepted(invitation: $invitation)';
}


}

/// @nodoc
abstract mixin class $InvitationAcceptedCopyWith<$Res> implements $InvitationStateCopyWith<$Res> {
  factory $InvitationAcceptedCopyWith(InvitationAccepted value, $Res Function(InvitationAccepted) _then) = _$InvitationAcceptedCopyWithImpl;
@useResult
$Res call({
 Message invitation
});




}
/// @nodoc
class _$InvitationAcceptedCopyWithImpl<$Res>
    implements $InvitationAcceptedCopyWith<$Res> {
  _$InvitationAcceptedCopyWithImpl(this._self, this._then);

  final InvitationAccepted _self;
  final $Res Function(InvitationAccepted) _then;

/// Create a copy of InvitationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? invitation = null,}) {
  return _then(InvitationAccepted(
invitation: null == invitation ? _self.invitation : invitation // ignore: cast_nullable_to_non_nullable
as Message,
  ));
}


}

/// @nodoc


class InvitationDeclined implements InvitationState {
  const InvitationDeclined({required this.invitation});
  

 final  Message invitation;

/// Create a copy of InvitationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvitationDeclinedCopyWith<InvitationDeclined> get copyWith => _$InvitationDeclinedCopyWithImpl<InvitationDeclined>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvitationDeclined&&(identical(other.invitation, invitation) || other.invitation == invitation));
}


@override
int get hashCode => Object.hash(runtimeType,invitation);

@override
String toString() {
  return 'InvitationState.declined(invitation: $invitation)';
}


}

/// @nodoc
abstract mixin class $InvitationDeclinedCopyWith<$Res> implements $InvitationStateCopyWith<$Res> {
  factory $InvitationDeclinedCopyWith(InvitationDeclined value, $Res Function(InvitationDeclined) _then) = _$InvitationDeclinedCopyWithImpl;
@useResult
$Res call({
 Message invitation
});




}
/// @nodoc
class _$InvitationDeclinedCopyWithImpl<$Res>
    implements $InvitationDeclinedCopyWith<$Res> {
  _$InvitationDeclinedCopyWithImpl(this._self, this._then);

  final InvitationDeclined _self;
  final $Res Function(InvitationDeclined) _then;

/// Create a copy of InvitationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? invitation = null,}) {
  return _then(InvitationDeclined(
invitation: null == invitation ? _self.invitation : invitation // ignore: cast_nullable_to_non_nullable
as Message,
  ));
}


}

/// @nodoc


class InvitationError implements InvitationState {
  const InvitationError({required this.message});
  

 final  String message;

/// Create a copy of InvitationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvitationErrorCopyWith<InvitationError> get copyWith => _$InvitationErrorCopyWithImpl<InvitationError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvitationError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'InvitationState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $InvitationErrorCopyWith<$Res> implements $InvitationStateCopyWith<$Res> {
  factory $InvitationErrorCopyWith(InvitationError value, $Res Function(InvitationError) _then) = _$InvitationErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$InvitationErrorCopyWithImpl<$Res>
    implements $InvitationErrorCopyWith<$Res> {
  _$InvitationErrorCopyWithImpl(this._self, this._then);

  final InvitationError _self;
  final $Res Function(InvitationError) _then;

/// Create a copy of InvitationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(InvitationError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
