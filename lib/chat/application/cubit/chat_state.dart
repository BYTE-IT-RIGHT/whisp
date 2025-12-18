part of 'chat_cubit.dart';

@immutable
sealed class ChatState {
  final List<Message> messages;
  final bool hasMore;
  final DateTime? nextCursor;
  final bool isSending;
  final String? errorMessage;

  const ChatState({
    this.messages = const [],
    this.hasMore = true,
    this.nextCursor,
    this.isSending = false,
    this.errorMessage,
  });
}

final class ChatInitial extends ChatState {
  const ChatInitial() : super();
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
  });

  ChatLoaded copyWith({
    List<Message>? messages,
    bool? hasMore,
    DateTime? nextCursor,
    bool? isSending,
  }) {
    return ChatLoaded(
      messages: messages ?? this.messages,
      hasMore: hasMore ?? this.hasMore,
      nextCursor: nextCursor ?? this.nextCursor,
      isSending: isSending ?? this.isSending,
    );
  }
}

final class ChatError extends ChatState {
  const ChatError({
    required super.errorMessage,
    super.messages,
    super.hasMore,
    super.nextCursor,
  });
}

