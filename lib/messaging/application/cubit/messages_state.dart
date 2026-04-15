part of 'messages_cubit.dart';

@freezed
sealed class MessagesState with _$MessagesState {
  const factory MessagesState.data({required List<Message> messages}) =
      MessagesData;
}
