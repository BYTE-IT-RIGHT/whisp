part of 'messages_cubit.dart';

@immutable
sealed class MessagesState {}

final class MessagesData extends MessagesState {
  final List<Message> messages;
  MessagesData({required this.messages});
}
