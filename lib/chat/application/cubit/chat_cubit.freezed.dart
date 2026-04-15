// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChatState {

 List<Message> get messages; bool get hasMore; DateTime? get nextCursor; bool get isSending; String? get errorMessage; ChatErrorType? get errorType; bool get isRecipientOnline;
/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatStateCopyWith<ChatState> get copyWith => _$ChatStateCopyWithImpl<ChatState>(this as ChatState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatState&&const DeepCollectionEquality().equals(other.messages, messages)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.nextCursor, nextCursor) || other.nextCursor == nextCursor)&&(identical(other.isSending, isSending) || other.isSending == isSending)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.errorType, errorType) || other.errorType == errorType)&&(identical(other.isRecipientOnline, isRecipientOnline) || other.isRecipientOnline == isRecipientOnline));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(messages),hasMore,nextCursor,isSending,errorMessage,errorType,isRecipientOnline);

@override
String toString() {
  return 'ChatState(messages: $messages, hasMore: $hasMore, nextCursor: $nextCursor, isSending: $isSending, errorMessage: $errorMessage, errorType: $errorType, isRecipientOnline: $isRecipientOnline)';
}


}

/// @nodoc
abstract mixin class $ChatStateCopyWith<$Res>  {
  factory $ChatStateCopyWith(ChatState value, $Res Function(ChatState) _then) = _$ChatStateCopyWithImpl;
@useResult
$Res call({
 List<Message> messages, bool hasMore, DateTime? nextCursor, bool isSending, String errorMessage, ChatErrorType errorType, bool isRecipientOnline
});




}
/// @nodoc
class _$ChatStateCopyWithImpl<$Res>
    implements $ChatStateCopyWith<$Res> {
  _$ChatStateCopyWithImpl(this._self, this._then);

  final ChatState _self;
  final $Res Function(ChatState) _then;

/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? messages = null,Object? hasMore = null,Object? nextCursor = freezed,Object? isSending = null,Object? errorMessage = null,Object? errorType = null,Object? isRecipientOnline = null,}) {
  return _then(_self.copyWith(
messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as List<Message>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as DateTime?,isSending: null == isSending ? _self.isSending : isSending // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: null == errorMessage ? _self.errorMessage! : errorMessage // ignore: cast_nullable_to_non_nullable
as String,errorType: null == errorType ? _self.errorType! : errorType // ignore: cast_nullable_to_non_nullable
as ChatErrorType,isRecipientOnline: null == isRecipientOnline ? _self.isRecipientOnline : isRecipientOnline // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatState].
extension ChatStatePatterns on ChatState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ChatInitial value)?  initial,TResult Function( ChatLoading value)?  loading,TResult Function( ChatLoaded value)?  loaded,TResult Function( ChatError value)?  error,TResult Function( ChatSendError value)?  sendError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ChatInitial() when initial != null:
return initial(_that);case ChatLoading() when loading != null:
return loading(_that);case ChatLoaded() when loaded != null:
return loaded(_that);case ChatError() when error != null:
return error(_that);case ChatSendError() when sendError != null:
return sendError(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ChatInitial value)  initial,required TResult Function( ChatLoading value)  loading,required TResult Function( ChatLoaded value)  loaded,required TResult Function( ChatError value)  error,required TResult Function( ChatSendError value)  sendError,}){
final _that = this;
switch (_that) {
case ChatInitial():
return initial(_that);case ChatLoading():
return loading(_that);case ChatLoaded():
return loaded(_that);case ChatError():
return error(_that);case ChatSendError():
return sendError(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ChatInitial value)?  initial,TResult? Function( ChatLoading value)?  loading,TResult? Function( ChatLoaded value)?  loaded,TResult? Function( ChatError value)?  error,TResult? Function( ChatSendError value)?  sendError,}){
final _that = this;
switch (_that) {
case ChatInitial() when initial != null:
return initial(_that);case ChatLoading() when loading != null:
return loading(_that);case ChatLoaded() when loaded != null:
return loaded(_that);case ChatError() when error != null:
return error(_that);case ChatSendError() when sendError != null:
return sendError(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( List<Message> messages,  bool hasMore,  DateTime? nextCursor,  bool isSending,  String? errorMessage,  ChatErrorType? errorType,  bool isRecipientOnline)?  initial,TResult Function( List<Message> messages,  bool hasMore,  DateTime? nextCursor,  bool isSending,  String? errorMessage,  ChatErrorType? errorType,  bool isRecipientOnline)?  loading,TResult Function( List<Message> messages,  bool hasMore,  DateTime? nextCursor,  bool isSending,  String? errorMessage,  ChatErrorType? errorType,  bool isRecipientOnline)?  loaded,TResult Function( String errorMessage,  List<Message> messages,  bool hasMore,  DateTime? nextCursor,  bool isSending,  ChatErrorType? errorType,  bool isRecipientOnline)?  error,TResult Function( String errorMessage,  ChatErrorType errorType,  List<Message> messages,  bool hasMore,  DateTime? nextCursor,  bool isSending,  bool isRecipientOnline)?  sendError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ChatInitial() when initial != null:
return initial(_that.messages,_that.hasMore,_that.nextCursor,_that.isSending,_that.errorMessage,_that.errorType,_that.isRecipientOnline);case ChatLoading() when loading != null:
return loading(_that.messages,_that.hasMore,_that.nextCursor,_that.isSending,_that.errorMessage,_that.errorType,_that.isRecipientOnline);case ChatLoaded() when loaded != null:
return loaded(_that.messages,_that.hasMore,_that.nextCursor,_that.isSending,_that.errorMessage,_that.errorType,_that.isRecipientOnline);case ChatError() when error != null:
return error(_that.errorMessage,_that.messages,_that.hasMore,_that.nextCursor,_that.isSending,_that.errorType,_that.isRecipientOnline);case ChatSendError() when sendError != null:
return sendError(_that.errorMessage,_that.errorType,_that.messages,_that.hasMore,_that.nextCursor,_that.isSending,_that.isRecipientOnline);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( List<Message> messages,  bool hasMore,  DateTime? nextCursor,  bool isSending,  String? errorMessage,  ChatErrorType? errorType,  bool isRecipientOnline)  initial,required TResult Function( List<Message> messages,  bool hasMore,  DateTime? nextCursor,  bool isSending,  String? errorMessage,  ChatErrorType? errorType,  bool isRecipientOnline)  loading,required TResult Function( List<Message> messages,  bool hasMore,  DateTime? nextCursor,  bool isSending,  String? errorMessage,  ChatErrorType? errorType,  bool isRecipientOnline)  loaded,required TResult Function( String errorMessage,  List<Message> messages,  bool hasMore,  DateTime? nextCursor,  bool isSending,  ChatErrorType? errorType,  bool isRecipientOnline)  error,required TResult Function( String errorMessage,  ChatErrorType errorType,  List<Message> messages,  bool hasMore,  DateTime? nextCursor,  bool isSending,  bool isRecipientOnline)  sendError,}) {final _that = this;
switch (_that) {
case ChatInitial():
return initial(_that.messages,_that.hasMore,_that.nextCursor,_that.isSending,_that.errorMessage,_that.errorType,_that.isRecipientOnline);case ChatLoading():
return loading(_that.messages,_that.hasMore,_that.nextCursor,_that.isSending,_that.errorMessage,_that.errorType,_that.isRecipientOnline);case ChatLoaded():
return loaded(_that.messages,_that.hasMore,_that.nextCursor,_that.isSending,_that.errorMessage,_that.errorType,_that.isRecipientOnline);case ChatError():
return error(_that.errorMessage,_that.messages,_that.hasMore,_that.nextCursor,_that.isSending,_that.errorType,_that.isRecipientOnline);case ChatSendError():
return sendError(_that.errorMessage,_that.errorType,_that.messages,_that.hasMore,_that.nextCursor,_that.isSending,_that.isRecipientOnline);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( List<Message> messages,  bool hasMore,  DateTime? nextCursor,  bool isSending,  String? errorMessage,  ChatErrorType? errorType,  bool isRecipientOnline)?  initial,TResult? Function( List<Message> messages,  bool hasMore,  DateTime? nextCursor,  bool isSending,  String? errorMessage,  ChatErrorType? errorType,  bool isRecipientOnline)?  loading,TResult? Function( List<Message> messages,  bool hasMore,  DateTime? nextCursor,  bool isSending,  String? errorMessage,  ChatErrorType? errorType,  bool isRecipientOnline)?  loaded,TResult? Function( String errorMessage,  List<Message> messages,  bool hasMore,  DateTime? nextCursor,  bool isSending,  ChatErrorType? errorType,  bool isRecipientOnline)?  error,TResult? Function( String errorMessage,  ChatErrorType errorType,  List<Message> messages,  bool hasMore,  DateTime? nextCursor,  bool isSending,  bool isRecipientOnline)?  sendError,}) {final _that = this;
switch (_that) {
case ChatInitial() when initial != null:
return initial(_that.messages,_that.hasMore,_that.nextCursor,_that.isSending,_that.errorMessage,_that.errorType,_that.isRecipientOnline);case ChatLoading() when loading != null:
return loading(_that.messages,_that.hasMore,_that.nextCursor,_that.isSending,_that.errorMessage,_that.errorType,_that.isRecipientOnline);case ChatLoaded() when loaded != null:
return loaded(_that.messages,_that.hasMore,_that.nextCursor,_that.isSending,_that.errorMessage,_that.errorType,_that.isRecipientOnline);case ChatError() when error != null:
return error(_that.errorMessage,_that.messages,_that.hasMore,_that.nextCursor,_that.isSending,_that.errorType,_that.isRecipientOnline);case ChatSendError() when sendError != null:
return sendError(_that.errorMessage,_that.errorType,_that.messages,_that.hasMore,_that.nextCursor,_that.isSending,_that.isRecipientOnline);case _:
  return null;

}
}

}

/// @nodoc


class ChatInitial implements ChatState {
  const ChatInitial({final  List<Message> messages = const <Message>[], this.hasMore = true, this.nextCursor, this.isSending = false, this.errorMessage, this.errorType, this.isRecipientOnline = false}): _messages = messages;
  

 final  List<Message> _messages;
@override@JsonKey() List<Message> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}

@override@JsonKey() final  bool hasMore;
@override final  DateTime? nextCursor;
@override@JsonKey() final  bool isSending;
@override final  String? errorMessage;
@override final  ChatErrorType? errorType;
@override@JsonKey() final  bool isRecipientOnline;

/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatInitialCopyWith<ChatInitial> get copyWith => _$ChatInitialCopyWithImpl<ChatInitial>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatInitial&&const DeepCollectionEquality().equals(other._messages, _messages)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.nextCursor, nextCursor) || other.nextCursor == nextCursor)&&(identical(other.isSending, isSending) || other.isSending == isSending)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.errorType, errorType) || other.errorType == errorType)&&(identical(other.isRecipientOnline, isRecipientOnline) || other.isRecipientOnline == isRecipientOnline));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_messages),hasMore,nextCursor,isSending,errorMessage,errorType,isRecipientOnline);

@override
String toString() {
  return 'ChatState.initial(messages: $messages, hasMore: $hasMore, nextCursor: $nextCursor, isSending: $isSending, errorMessage: $errorMessage, errorType: $errorType, isRecipientOnline: $isRecipientOnline)';
}


}

/// @nodoc
abstract mixin class $ChatInitialCopyWith<$Res> implements $ChatStateCopyWith<$Res> {
  factory $ChatInitialCopyWith(ChatInitial value, $Res Function(ChatInitial) _then) = _$ChatInitialCopyWithImpl;
@override @useResult
$Res call({
 List<Message> messages, bool hasMore, DateTime? nextCursor, bool isSending, String? errorMessage, ChatErrorType? errorType, bool isRecipientOnline
});




}
/// @nodoc
class _$ChatInitialCopyWithImpl<$Res>
    implements $ChatInitialCopyWith<$Res> {
  _$ChatInitialCopyWithImpl(this._self, this._then);

  final ChatInitial _self;
  final $Res Function(ChatInitial) _then;

/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? messages = null,Object? hasMore = null,Object? nextCursor = freezed,Object? isSending = null,Object? errorMessage = freezed,Object? errorType = freezed,Object? isRecipientOnline = null,}) {
  return _then(ChatInitial(
messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<Message>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as DateTime?,isSending: null == isSending ? _self.isSending : isSending // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,errorType: freezed == errorType ? _self.errorType : errorType // ignore: cast_nullable_to_non_nullable
as ChatErrorType?,isRecipientOnline: null == isRecipientOnline ? _self.isRecipientOnline : isRecipientOnline // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class ChatLoading implements ChatState {
  const ChatLoading({final  List<Message> messages = const <Message>[], this.hasMore = true, this.nextCursor, this.isSending = false, this.errorMessage, this.errorType, this.isRecipientOnline = false}): _messages = messages;
  

 final  List<Message> _messages;
@override@JsonKey() List<Message> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}

@override@JsonKey() final  bool hasMore;
@override final  DateTime? nextCursor;
@override@JsonKey() final  bool isSending;
@override final  String? errorMessage;
@override final  ChatErrorType? errorType;
@override@JsonKey() final  bool isRecipientOnline;

/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatLoadingCopyWith<ChatLoading> get copyWith => _$ChatLoadingCopyWithImpl<ChatLoading>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatLoading&&const DeepCollectionEquality().equals(other._messages, _messages)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.nextCursor, nextCursor) || other.nextCursor == nextCursor)&&(identical(other.isSending, isSending) || other.isSending == isSending)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.errorType, errorType) || other.errorType == errorType)&&(identical(other.isRecipientOnline, isRecipientOnline) || other.isRecipientOnline == isRecipientOnline));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_messages),hasMore,nextCursor,isSending,errorMessage,errorType,isRecipientOnline);

@override
String toString() {
  return 'ChatState.loading(messages: $messages, hasMore: $hasMore, nextCursor: $nextCursor, isSending: $isSending, errorMessage: $errorMessage, errorType: $errorType, isRecipientOnline: $isRecipientOnline)';
}


}

/// @nodoc
abstract mixin class $ChatLoadingCopyWith<$Res> implements $ChatStateCopyWith<$Res> {
  factory $ChatLoadingCopyWith(ChatLoading value, $Res Function(ChatLoading) _then) = _$ChatLoadingCopyWithImpl;
@override @useResult
$Res call({
 List<Message> messages, bool hasMore, DateTime? nextCursor, bool isSending, String? errorMessage, ChatErrorType? errorType, bool isRecipientOnline
});




}
/// @nodoc
class _$ChatLoadingCopyWithImpl<$Res>
    implements $ChatLoadingCopyWith<$Res> {
  _$ChatLoadingCopyWithImpl(this._self, this._then);

  final ChatLoading _self;
  final $Res Function(ChatLoading) _then;

/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? messages = null,Object? hasMore = null,Object? nextCursor = freezed,Object? isSending = null,Object? errorMessage = freezed,Object? errorType = freezed,Object? isRecipientOnline = null,}) {
  return _then(ChatLoading(
messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<Message>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as DateTime?,isSending: null == isSending ? _self.isSending : isSending // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,errorType: freezed == errorType ? _self.errorType : errorType // ignore: cast_nullable_to_non_nullable
as ChatErrorType?,isRecipientOnline: null == isRecipientOnline ? _self.isRecipientOnline : isRecipientOnline // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class ChatLoaded implements ChatState {
  const ChatLoaded({required final  List<Message> messages, required this.hasMore, this.nextCursor, this.isSending = false, this.errorMessage, this.errorType, this.isRecipientOnline = false}): _messages = messages;
  

 final  List<Message> _messages;
@override List<Message> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}

@override final  bool hasMore;
@override final  DateTime? nextCursor;
@override@JsonKey() final  bool isSending;
@override final  String? errorMessage;
@override final  ChatErrorType? errorType;
@override@JsonKey() final  bool isRecipientOnline;

/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatLoadedCopyWith<ChatLoaded> get copyWith => _$ChatLoadedCopyWithImpl<ChatLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatLoaded&&const DeepCollectionEquality().equals(other._messages, _messages)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.nextCursor, nextCursor) || other.nextCursor == nextCursor)&&(identical(other.isSending, isSending) || other.isSending == isSending)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.errorType, errorType) || other.errorType == errorType)&&(identical(other.isRecipientOnline, isRecipientOnline) || other.isRecipientOnline == isRecipientOnline));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_messages),hasMore,nextCursor,isSending,errorMessage,errorType,isRecipientOnline);

@override
String toString() {
  return 'ChatState.loaded(messages: $messages, hasMore: $hasMore, nextCursor: $nextCursor, isSending: $isSending, errorMessage: $errorMessage, errorType: $errorType, isRecipientOnline: $isRecipientOnline)';
}


}

/// @nodoc
abstract mixin class $ChatLoadedCopyWith<$Res> implements $ChatStateCopyWith<$Res> {
  factory $ChatLoadedCopyWith(ChatLoaded value, $Res Function(ChatLoaded) _then) = _$ChatLoadedCopyWithImpl;
@override @useResult
$Res call({
 List<Message> messages, bool hasMore, DateTime? nextCursor, bool isSending, String? errorMessage, ChatErrorType? errorType, bool isRecipientOnline
});




}
/// @nodoc
class _$ChatLoadedCopyWithImpl<$Res>
    implements $ChatLoadedCopyWith<$Res> {
  _$ChatLoadedCopyWithImpl(this._self, this._then);

  final ChatLoaded _self;
  final $Res Function(ChatLoaded) _then;

/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? messages = null,Object? hasMore = null,Object? nextCursor = freezed,Object? isSending = null,Object? errorMessage = freezed,Object? errorType = freezed,Object? isRecipientOnline = null,}) {
  return _then(ChatLoaded(
messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<Message>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as DateTime?,isSending: null == isSending ? _self.isSending : isSending // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,errorType: freezed == errorType ? _self.errorType : errorType // ignore: cast_nullable_to_non_nullable
as ChatErrorType?,isRecipientOnline: null == isRecipientOnline ? _self.isRecipientOnline : isRecipientOnline // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class ChatError implements ChatState {
  const ChatError({required this.errorMessage, final  List<Message> messages = const <Message>[], this.hasMore = true, this.nextCursor, this.isSending = false, this.errorType, this.isRecipientOnline = false}): _messages = messages;
  

@override final  String errorMessage;
 final  List<Message> _messages;
@override@JsonKey() List<Message> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}

@override@JsonKey() final  bool hasMore;
@override final  DateTime? nextCursor;
@override@JsonKey() final  bool isSending;
@override final  ChatErrorType? errorType;
@override@JsonKey() final  bool isRecipientOnline;

/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatErrorCopyWith<ChatError> get copyWith => _$ChatErrorCopyWithImpl<ChatError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatError&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&const DeepCollectionEquality().equals(other._messages, _messages)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.nextCursor, nextCursor) || other.nextCursor == nextCursor)&&(identical(other.isSending, isSending) || other.isSending == isSending)&&(identical(other.errorType, errorType) || other.errorType == errorType)&&(identical(other.isRecipientOnline, isRecipientOnline) || other.isRecipientOnline == isRecipientOnline));
}


@override
int get hashCode => Object.hash(runtimeType,errorMessage,const DeepCollectionEquality().hash(_messages),hasMore,nextCursor,isSending,errorType,isRecipientOnline);

@override
String toString() {
  return 'ChatState.error(errorMessage: $errorMessage, messages: $messages, hasMore: $hasMore, nextCursor: $nextCursor, isSending: $isSending, errorType: $errorType, isRecipientOnline: $isRecipientOnline)';
}


}

/// @nodoc
abstract mixin class $ChatErrorCopyWith<$Res> implements $ChatStateCopyWith<$Res> {
  factory $ChatErrorCopyWith(ChatError value, $Res Function(ChatError) _then) = _$ChatErrorCopyWithImpl;
@override @useResult
$Res call({
 String errorMessage, List<Message> messages, bool hasMore, DateTime? nextCursor, bool isSending, ChatErrorType? errorType, bool isRecipientOnline
});




}
/// @nodoc
class _$ChatErrorCopyWithImpl<$Res>
    implements $ChatErrorCopyWith<$Res> {
  _$ChatErrorCopyWithImpl(this._self, this._then);

  final ChatError _self;
  final $Res Function(ChatError) _then;

/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? errorMessage = null,Object? messages = null,Object? hasMore = null,Object? nextCursor = freezed,Object? isSending = null,Object? errorType = freezed,Object? isRecipientOnline = null,}) {
  return _then(ChatError(
errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<Message>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as DateTime?,isSending: null == isSending ? _self.isSending : isSending // ignore: cast_nullable_to_non_nullable
as bool,errorType: freezed == errorType ? _self.errorType : errorType // ignore: cast_nullable_to_non_nullable
as ChatErrorType?,isRecipientOnline: null == isRecipientOnline ? _self.isRecipientOnline : isRecipientOnline // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class ChatSendError implements ChatState {
  const ChatSendError({required this.errorMessage, required this.errorType, final  List<Message> messages = const <Message>[], this.hasMore = true, this.nextCursor, this.isSending = false, this.isRecipientOnline = false}): _messages = messages;
  

@override final  String errorMessage;
@override final  ChatErrorType errorType;
 final  List<Message> _messages;
@override@JsonKey() List<Message> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}

@override@JsonKey() final  bool hasMore;
@override final  DateTime? nextCursor;
@override@JsonKey() final  bool isSending;
@override@JsonKey() final  bool isRecipientOnline;

/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatSendErrorCopyWith<ChatSendError> get copyWith => _$ChatSendErrorCopyWithImpl<ChatSendError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatSendError&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.errorType, errorType) || other.errorType == errorType)&&const DeepCollectionEquality().equals(other._messages, _messages)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.nextCursor, nextCursor) || other.nextCursor == nextCursor)&&(identical(other.isSending, isSending) || other.isSending == isSending)&&(identical(other.isRecipientOnline, isRecipientOnline) || other.isRecipientOnline == isRecipientOnline));
}


@override
int get hashCode => Object.hash(runtimeType,errorMessage,errorType,const DeepCollectionEquality().hash(_messages),hasMore,nextCursor,isSending,isRecipientOnline);

@override
String toString() {
  return 'ChatState.sendError(errorMessage: $errorMessage, errorType: $errorType, messages: $messages, hasMore: $hasMore, nextCursor: $nextCursor, isSending: $isSending, isRecipientOnline: $isRecipientOnline)';
}


}

/// @nodoc
abstract mixin class $ChatSendErrorCopyWith<$Res> implements $ChatStateCopyWith<$Res> {
  factory $ChatSendErrorCopyWith(ChatSendError value, $Res Function(ChatSendError) _then) = _$ChatSendErrorCopyWithImpl;
@override @useResult
$Res call({
 String errorMessage, ChatErrorType errorType, List<Message> messages, bool hasMore, DateTime? nextCursor, bool isSending, bool isRecipientOnline
});




}
/// @nodoc
class _$ChatSendErrorCopyWithImpl<$Res>
    implements $ChatSendErrorCopyWith<$Res> {
  _$ChatSendErrorCopyWithImpl(this._self, this._then);

  final ChatSendError _self;
  final $Res Function(ChatSendError) _then;

/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? errorMessage = null,Object? errorType = null,Object? messages = null,Object? hasMore = null,Object? nextCursor = freezed,Object? isSending = null,Object? isRecipientOnline = null,}) {
  return _then(ChatSendError(
errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,errorType: null == errorType ? _self.errorType : errorType // ignore: cast_nullable_to_non_nullable
as ChatErrorType,messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<Message>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as DateTime?,isSending: null == isSending ? _self.isSending : isSending // ignore: cast_nullable_to_non_nullable
as bool,isRecipientOnline: null == isRecipientOnline ? _self.isRecipientOnline : isRecipientOnline // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
