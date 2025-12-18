part of 'conversations_cubit.dart';

@immutable
sealed class ConversationsState {}

final class ConversationsData extends ConversationsState {
  final List<Conversation> conversations;
  ConversationsData({required this.conversations});
}
