part of 'chat_cubit.dart';

enum ChatErrorType {
  generic,
  recipientOffline,
  connectionError,
}

@immutable
sealed class ChatState {
  final List<Message> messages;
  final bool hasMore;
  final DateTime? nextCursor;
  final bool isSending;
  final String? errorMessage;
  final ChatErrorType? errorType;
  final bool isRecipientOnline;

  const ChatState({
    this.messages = const [],
    this.hasMore = true,
    this.nextCursor,
    this.isSending = false,
    this.errorMessage,
    this.errorType,
    this.isRecipientOnline = false,
  });
}

final class ChatInitial extends ChatState {
  const ChatInitial() : super();
}

final class ChatSendError extends ChatState {
  const ChatSendError({
    required super.errorMessage,
    required super.errorType,
    super.messages,
    super.hasMore,
    super.nextCursor,
    super.isRecipientOnline,
  });
}

final class ChatLoading extends ChatState {
  const ChatLoading({
    super.messages,
    super.hasMore,
    super.nextCursor,
  });
}

final class ChatLoaded extends ChatState {
  const ChatLoaded({
    required super.messages,
    required super.hasMore,
    super.nextCursor,
    super.isSending,
    super.isRecipientOnline,
  });

  ChatLoaded copyWith({
    List<Message>? messages,
    bool? hasMore,
    DateTime? nextCursor,
    bool? isSending,
    bool? isRecipientOnline,
  }) {
    return ChatLoaded(
      messages: messages ?? this.messages,
      hasMore: hasMore ?? this.hasMore,
      nextCursor: nextCursor ?? this.nextCursor,
      isSending: isSending ?? this.isSending,
      isRecipientOnline: isRecipientOnline ?? this.isRecipientOnline,
    );
  }
}

final class ChatError extends ChatState {
  const ChatError({
    required super.errorMessage,
    super.messages,
    super.hasMore,
    super.nextCursor,
    super.isRecipientOnline,
  });
}

