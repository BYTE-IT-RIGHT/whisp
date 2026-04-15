// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'conversations_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ConversationsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConversationsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ConversationsState()';
}


}

/// @nodoc
class $ConversationsStateCopyWith<$Res>  {
$ConversationsStateCopyWith(ConversationsState _, $Res Function(ConversationsState) __);
}


/// Adds pattern-matching-related methods to [ConversationsState].
extension ConversationsStatePatterns on ConversationsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ConversationsData value)?  data,TResult Function( ConversationsLoading value)?  loading,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ConversationsData() when data != null:
return data(_that);case ConversationsLoading() when loading != null:
return loading(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ConversationsData value)  data,required TResult Function( ConversationsLoading value)  loading,}){
final _that = this;
switch (_that) {
case ConversationsData():
return data(_that);case ConversationsLoading():
return loading(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ConversationsData value)?  data,TResult? Function( ConversationsLoading value)?  loading,}){
final _that = this;
switch (_that) {
case ConversationsData() when data != null:
return data(_that);case ConversationsLoading() when loading != null:
return loading(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( List<Conversation> conversations)?  data,TResult Function()?  loading,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ConversationsData() when data != null:
return data(_that.conversations);case ConversationsLoading() when loading != null:
return loading();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( List<Conversation> conversations)  data,required TResult Function()  loading,}) {final _that = this;
switch (_that) {
case ConversationsData():
return data(_that.conversations);case ConversationsLoading():
return loading();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( List<Conversation> conversations)?  data,TResult? Function()?  loading,}) {final _that = this;
switch (_that) {
case ConversationsData() when data != null:
return data(_that.conversations);case ConversationsLoading() when loading != null:
return loading();case _:
  return null;

}
}

}

/// @nodoc


class ConversationsData implements ConversationsState {
  const ConversationsData({required final  List<Conversation> conversations}): _conversations = conversations;
  

 final  List<Conversation> _conversations;
 List<Conversation> get conversations {
  if (_conversations is EqualUnmodifiableListView) return _conversations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_conversations);
}


/// Create a copy of ConversationsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConversationsDataCopyWith<ConversationsData> get copyWith => _$ConversationsDataCopyWithImpl<ConversationsData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConversationsData&&const DeepCollectionEquality().equals(other._conversations, _conversations));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_conversations));

@override
String toString() {
  return 'ConversationsState.data(conversations: $conversations)';
}


}

/// @nodoc
abstract mixin class $ConversationsDataCopyWith<$Res> implements $ConversationsStateCopyWith<$Res> {
  factory $ConversationsDataCopyWith(ConversationsData value, $Res Function(ConversationsData) _then) = _$ConversationsDataCopyWithImpl;
@useResult
$Res call({
 List<Conversation> conversations
});




}
/// @nodoc
class _$ConversationsDataCopyWithImpl<$Res>
    implements $ConversationsDataCopyWith<$Res> {
  _$ConversationsDataCopyWithImpl(this._self, this._then);

  final ConversationsData _self;
  final $Res Function(ConversationsData) _then;

/// Create a copy of ConversationsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? conversations = null,}) {
  return _then(ConversationsData(
conversations: null == conversations ? _self._conversations : conversations // ignore: cast_nullable_to_non_nullable
as List<Conversation>,
  ));
}


}

/// @nodoc


class ConversationsLoading implements ConversationsState {
  const ConversationsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConversationsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ConversationsState.loading()';
}


}




// dart format on
