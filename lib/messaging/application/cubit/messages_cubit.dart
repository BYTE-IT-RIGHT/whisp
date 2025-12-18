import 'dart:async';
import 'dart:developer';

import 'package:whisp/messaging/domain/i_messages_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whisp/messaging/domain/message.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'messages_state.dart';

@Injectable()
class MessagesCubit extends Cubit<MessagesState> {
  final IMessagesRepository _messagesRepository;
  MessagesCubit(this._messagesRepository) : super(MessagesData(messages: []));
  StreamSubscription<Message>? _messageSubscription;

  Future<void> init() async {
    if (!_messagesRepository.isRunning) {
      final result = await _messagesRepository.startListener();
      result.fold(
        (failure) => log('Failed to start message listener: $failure'),
        (_) => log('Message listener started successfully'),
      );
    }

    _messageSubscription = _messagesRepository.incomingMessages.listen((event) {
      final messages = switch (state) {
        MessagesData(:final messages) => [...messages, event],
      };

      emit(MessagesData(messages: messages));
    });
  }

  @override
  Future<void> close() {
    _messageSubscription?.cancel();
    _messagesRepository.stopListener();
    return super.close();
  }
}
