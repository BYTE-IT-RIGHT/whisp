// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mailbox_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MailboxState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MailboxState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MailboxState()';
}


}

/// @nodoc
class $MailboxStateCopyWith<$Res>  {
$MailboxStateCopyWith(MailboxState _, $Res Function(MailboxState) __);
}


/// Adds pattern-matching-related methods to [MailboxState].
extension MailboxStatePatterns on MailboxState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( MailboxInitial value)?  initial,TResult Function( MailboxLoading value)?  loading,TResult Function( MailboxLoaded value)?  loaded,TResult Function( MailboxAddSuccess value)?  addSuccess,TResult Function( MailboxAddError value)?  addError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case MailboxInitial() when initial != null:
return initial(_that);case MailboxLoading() when loading != null:
return loading(_that);case MailboxLoaded() when loaded != null:
return loaded(_that);case MailboxAddSuccess() when addSuccess != null:
return addSuccess(_that);case MailboxAddError() when addError != null:
return addError(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( MailboxInitial value)  initial,required TResult Function( MailboxLoading value)  loading,required TResult Function( MailboxLoaded value)  loaded,required TResult Function( MailboxAddSuccess value)  addSuccess,required TResult Function( MailboxAddError value)  addError,}){
final _that = this;
switch (_that) {
case MailboxInitial():
return initial(_that);case MailboxLoading():
return loading(_that);case MailboxLoaded():
return loaded(_that);case MailboxAddSuccess():
return addSuccess(_that);case MailboxAddError():
return addError(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( MailboxInitial value)?  initial,TResult? Function( MailboxLoading value)?  loading,TResult? Function( MailboxLoaded value)?  loaded,TResult? Function( MailboxAddSuccess value)?  addSuccess,TResult? Function( MailboxAddError value)?  addError,}){
final _that = this;
switch (_that) {
case MailboxInitial() when initial != null:
return initial(_that);case MailboxLoading() when loading != null:
return loading(_that);case MailboxLoaded() when loaded != null:
return loaded(_that);case MailboxAddSuccess() when addSuccess != null:
return addSuccess(_that);case MailboxAddError() when addError != null:
return addError(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<Mailbox> mailboxes)?  loaded,TResult Function()?  addSuccess,TResult Function( Failure failure,  String onionAddress)?  addError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case MailboxInitial() when initial != null:
return initial();case MailboxLoading() when loading != null:
return loading();case MailboxLoaded() when loaded != null:
return loaded(_that.mailboxes);case MailboxAddSuccess() when addSuccess != null:
return addSuccess();case MailboxAddError() when addError != null:
return addError(_that.failure,_that.onionAddress);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<Mailbox> mailboxes)  loaded,required TResult Function()  addSuccess,required TResult Function( Failure failure,  String onionAddress)  addError,}) {final _that = this;
switch (_that) {
case MailboxInitial():
return initial();case MailboxLoading():
return loading();case MailboxLoaded():
return loaded(_that.mailboxes);case MailboxAddSuccess():
return addSuccess();case MailboxAddError():
return addError(_that.failure,_that.onionAddress);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<Mailbox> mailboxes)?  loaded,TResult? Function()?  addSuccess,TResult? Function( Failure failure,  String onionAddress)?  addError,}) {final _that = this;
switch (_that) {
case MailboxInitial() when initial != null:
return initial();case MailboxLoading() when loading != null:
return loading();case MailboxLoaded() when loaded != null:
return loaded(_that.mailboxes);case MailboxAddSuccess() when addSuccess != null:
return addSuccess();case MailboxAddError() when addError != null:
return addError(_that.failure,_that.onionAddress);case _:
  return null;

}
}

}

/// @nodoc


class MailboxInitial implements MailboxState {
  const MailboxInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MailboxInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MailboxState.initial()';
}


}




/// @nodoc


class MailboxLoading implements MailboxState {
  const MailboxLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MailboxLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MailboxState.loading()';
}


}




/// @nodoc


class MailboxLoaded implements MailboxState {
  const MailboxLoaded({required final  List<Mailbox> mailboxes}): _mailboxes = mailboxes;
  

 final  List<Mailbox> _mailboxes;
 List<Mailbox> get mailboxes {
  if (_mailboxes is EqualUnmodifiableListView) return _mailboxes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_mailboxes);
}


/// Create a copy of MailboxState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MailboxLoadedCopyWith<MailboxLoaded> get copyWith => _$MailboxLoadedCopyWithImpl<MailboxLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MailboxLoaded&&const DeepCollectionEquality().equals(other._mailboxes, _mailboxes));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_mailboxes));

@override
String toString() {
  return 'MailboxState.loaded(mailboxes: $mailboxes)';
}


}

/// @nodoc
abstract mixin class $MailboxLoadedCopyWith<$Res> implements $MailboxStateCopyWith<$Res> {
  factory $MailboxLoadedCopyWith(MailboxLoaded value, $Res Function(MailboxLoaded) _then) = _$MailboxLoadedCopyWithImpl;
@useResult
$Res call({
 List<Mailbox> mailboxes
});




}
/// @nodoc
class _$MailboxLoadedCopyWithImpl<$Res>
    implements $MailboxLoadedCopyWith<$Res> {
  _$MailboxLoadedCopyWithImpl(this._self, this._then);

  final MailboxLoaded _self;
  final $Res Function(MailboxLoaded) _then;

/// Create a copy of MailboxState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? mailboxes = null,}) {
  return _then(MailboxLoaded(
mailboxes: null == mailboxes ? _self._mailboxes : mailboxes // ignore: cast_nullable_to_non_nullable
as List<Mailbox>,
  ));
}


}

/// @nodoc


class MailboxAddSuccess implements MailboxState {
  const MailboxAddSuccess();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MailboxAddSuccess);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MailboxState.addSuccess()';
}


}




/// @nodoc


class MailboxAddError implements MailboxState {
  const MailboxAddError(this.failure, {required this.onionAddress});
  

 final  Failure failure;
 final  String onionAddress;

/// Create a copy of MailboxState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MailboxAddErrorCopyWith<MailboxAddError> get copyWith => _$MailboxAddErrorCopyWithImpl<MailboxAddError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MailboxAddError&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.onionAddress, onionAddress) || other.onionAddress == onionAddress));
}


@override
int get hashCode => Object.hash(runtimeType,failure,onionAddress);

@override
String toString() {
  return 'MailboxState.addError(failure: $failure, onionAddress: $onionAddress)';
}


}

/// @nodoc
abstract mixin class $MailboxAddErrorCopyWith<$Res> implements $MailboxStateCopyWith<$Res> {
  factory $MailboxAddErrorCopyWith(MailboxAddError value, $Res Function(MailboxAddError) _then) = _$MailboxAddErrorCopyWithImpl;
@useResult
$Res call({
 Failure failure, String onionAddress
});




}
/// @nodoc
class _$MailboxAddErrorCopyWithImpl<$Res>
    implements $MailboxAddErrorCopyWith<$Res> {
  _$MailboxAddErrorCopyWithImpl(this._self, this._then);

  final MailboxAddError _self;
  final $Res Function(MailboxAddError) _then;

/// Create a copy of MailboxState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,Object? onionAddress = null,}) {
  return _then(MailboxAddError(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,onionAddress: null == onionAddress ? _self.onionAddress : onionAddress // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
