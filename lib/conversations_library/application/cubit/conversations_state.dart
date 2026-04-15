part of 'conversations_cubit.dart';

@freezed
sealed class ConversationsState with _$ConversationsState {
  const factory ConversationsState.data({
    required List<Conversation> conversations,
  }) = ConversationsData;
  const factory ConversationsState.loading() = ConversationsLoading;
}
