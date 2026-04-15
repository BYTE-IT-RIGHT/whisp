// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'messages_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MessagesState {

 List<Message> get messages;
/// Create a copy of MessagesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessagesStateCopyWith<MessagesState> get copyWith => _$MessagesStateCopyWithImpl<MessagesState>(this as MessagesState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MessagesState&&const DeepCollectionEquality().equals(other.messages, messages));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(messages));

@override
String toString() {
  return 'MessagesState(messages: $messages)';
}


}

/// @nodoc
abstract mixin class $MessagesStateCopyWith<$Res>  {
  factory $MessagesStateCopyWith(MessagesState value, $Res Function(MessagesState) _then) = _$MessagesStateCopyWithImpl;
@useResult
$Res call({
 List<Message> messages
});




}
/// @nodoc
class _$MessagesStateCopyWithImpl<$Res>
    implements $MessagesStateCopyWith<$Res> {
  _$MessagesStateCopyWithImpl(this._self, this._then);

  final MessagesState _self;
  final $Res Function(MessagesState) _then;

/// Create a copy of MessagesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? messages = null,}) {
  return _then(_self.copyWith(
messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as List<Message>,
  ));
}

}


/// Adds pattern-matching-related methods to [MessagesState].
extension MessagesStatePatterns on MessagesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( MessagesData value)?  data,required TResult orElse(),}){
final _that = this;
switch (_that) {
case MessagesData() when data != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( MessagesData value)  data,}){
final _that = this;
switch (_that) {
case MessagesData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( MessagesData value)?  data,}){
final _that = this;
switch (_that) {
case MessagesData() when data != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( List<Message> messages)?  data,required TResult orElse(),}) {final _that = this;
switch (_that) {
case MessagesData() when data != null:
return data(_that.messages);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( List<Message> messages)  data,}) {final _that = this;
switch (_that) {
case MessagesData():
return data(_that.messages);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( List<Message> messages)?  data,}) {final _that = this;
switch (_that) {
case MessagesData() when data != null:
return data(_that.messages);case _:
  return null;

}
}

}

/// @nodoc


class MessagesData implements MessagesState {
  const MessagesData({required final  List<Message> messages}): _messages = messages;
  

 final  List<Message> _messages;
@override List<Message> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}


/// Create a copy of MessagesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessagesDataCopyWith<MessagesData> get copyWith => _$MessagesDataCopyWithImpl<MessagesData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MessagesData&&const DeepCollectionEquality().equals(other._messages, _messages));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_messages));

@override
String toString() {
  return 'MessagesState.data(messages: $messages)';
}


}

/// @nodoc
abstract mixin class $MessagesDataCopyWith<$Res> implements $MessagesStateCopyWith<$Res> {
  factory $MessagesDataCopyWith(MessagesData value, $Res Function(MessagesData) _then) = _$MessagesDataCopyWithImpl;
@override @useResult
$Res call({
 List<Message> messages
});




}
/// @nodoc
class _$MessagesDataCopyWithImpl<$Res>
    implements $MessagesDataCopyWith<$Res> {
  _$MessagesDataCopyWithImpl(this._self, this._then);

  final MessagesData _self;
  final $Res Function(MessagesData) _then;

/// Create a copy of MessagesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? messages = null,}) {
  return _then(MessagesData(
messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<Message>,
  ));
}


}

// dart format on
