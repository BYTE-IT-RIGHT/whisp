part of 'chat_cubit.dart';

enum ChatErrorType { generic, recipientOffline, connectionError }

@freezed
sealed class ChatState with _$ChatState {
  const factory ChatState.initial({
    @Default(<Message>[]) List<Message> messages,
    @Default(true) bool hasMore,
    DateTime? nextCursor,
    @Default(false) bool isSending,
    String? errorMessage,
    ChatErrorType? errorType,
    @Default(false) bool isRecipientOnline,
  }) = ChatInitial;

  const factory ChatState.loading({
    @Default(<Message>[]) List<Message> messages,
    @Default(true) bool hasMore,
    DateTime? nextCursor,
    @Default(false) bool isSending,
    String? errorMessage,
    ChatErrorType? errorType,
    @Default(false) bool isRecipientOnline,
  }) = ChatLoading;

  const factory ChatState.loaded({
    required List<Message> messages,
    required bool hasMore,
    DateTime? nextCursor,
    @Default(false) bool isSending,
    String? errorMessage,
    ChatErrorType? errorType,
    @Default(false) bool isRecipientOnline,
  }) = ChatLoaded;

  const factory ChatState.error({
    required String errorMessage,
    @Default(<Message>[]) List<Message> messages,
    @Default(true) bool hasMore,
    DateTime? nextCursor,
    @Default(false) bool isSending,
    ChatErrorType? errorType,
    @Default(false) bool isRecipientOnline,
  }) = ChatError;

  const factory ChatState.sendError({
    required String errorMessage,
    required ChatErrorType errorType,
    @Default(<Message>[]) List<Message> messages,
    @Default(true) bool hasMore,
    DateTime? nextCursor,
    @Default(false) bool isSending,
    @Default(false) bool isRecipientOnline,
  }) = ChatSendError;
}
