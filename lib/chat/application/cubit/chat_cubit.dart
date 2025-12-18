import 'dart:async';
import 'dart:developer';

import 'package:flick/chat/domain/i_chat_repository.dart';
import 'package:flick/local_storage/domain/i_local_storage_repository.dart';
import 'package:flick/messaging/domain/message.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

@injectable
class ChatCubit extends Cubit<ChatState> {
  final IChatRepository _chatRepository;
  final ILocalStorageRepository _localStorageRepository;

  StreamSubscription<List<Message>>? _messagesSubscription;
  String? _conversationId;
  String? _currentUserOnionAddress;

  ChatCubit(this._chatRepository, this._localStorageRepository)
      : super(const ChatInitial());

  /// Initialize chat with a specific conversation
  Future<void> init(String conversationId) async {
    _conversationId = conversationId;
    _currentUserOnionAddress = _localStorageRepository.getUser()?.onionAddress;

    emit(const ChatLoading());

    // Load initial messages
    await _loadMessages();

    // Subscribe to real-time message updates
    _messagesSubscription = _chatRepository.watchMessages(conversationId).listen(
      (messages) {
        if (state is ChatLoaded) {
          final currentState = state as ChatLoaded;
          // Merge new messages, avoiding duplicates
          final existingIds = currentState.messages.map((m) => m.id).toSet();
          final newMessages = messages.where((m) => !existingIds.contains(m.id));

          if (newMessages.isNotEmpty) {
            final updatedMessages = [...currentState.messages, ...newMessages];
            updatedMessages.sort((a, b) => a.timestamp.compareTo(b.timestamp));

            emit(currentState.copyWith(messages: updatedMessages));
          }
        }
      },
      onError: (error) {
        log('Messages stream error: $error');
      },
    );
  }

  /// Load messages with pagination support
  Future<void> _loadMessages({bool loadMore = false}) async {
    if (_conversationId == null) return;

    DateTime? cursor;
    if (loadMore && state is ChatLoaded) {
      cursor = (state as ChatLoaded).nextCursor;
    }

    final result = await _chatRepository.getMessages(
      _conversationId!,
      before: cursor,
    );

    result.fold(
      (failure) {
        emit(ChatError(
          errorMessage: 'Failed to load messages',
          messages: state.messages,
          hasMore: state.hasMore,
          nextCursor: state.nextCursor,
        ));
      },
      (page) {
        List<Message> allMessages;
        if (loadMore) {
          // Prepend older messages (they come sorted newest first from DB)
          allMessages = [...page.messages.reversed, ...state.messages];
        } else {
          // Initial load - reverse to show oldest first
          allMessages = page.messages.reversed.toList();
        }

        emit(ChatLoaded(
          messages: allMessages,
          hasMore: page.hasMore,
          nextCursor: page.nextCursor,
        ));
      },
    );
  }

  /// Load more messages for pagination
  Future<void> loadMore() async {
    if (state is! ChatLoaded) return;
    final currentState = state as ChatLoaded;

    if (!currentState.hasMore) return;

    await _loadMessages(loadMore: true);
  }

  /// Send a message
  Future<void> sendMessage(String content) async {
    if (_conversationId == null || content.trim().isEmpty) return;
    if (state is! ChatLoaded) return;

    final currentState = state as ChatLoaded;
    emit(currentState.copyWith(isSending: true));

    final result = await _chatRepository.sendMessage(
      recipientOnionAddress: _conversationId!,
      content: content.trim(),
    );

    result.fold(
      (failure) {
        emit(ChatError(
          errorMessage: 'Failed to send message',
          messages: currentState.messages,
          hasMore: currentState.hasMore,
          nextCursor: currentState.nextCursor,
        ));
        // Recover to loaded state after error
        emit(currentState.copyWith(isSending: false));
      },
      (_) {
        // Message was sent and saved - reload to get the new message
        _loadMessages();
      },
    );
  }

  /// Check if a message is from the current user
  bool isOwnMessage(Message message) {
    return message.sender.onionAddress == _currentUserOnionAddress;
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    return super.close();
  }
}

