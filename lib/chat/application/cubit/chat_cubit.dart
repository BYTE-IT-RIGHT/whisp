import 'dart:async';
import 'dart:developer';

import 'package:whisp/chat/domain/i_chat_repository.dart';
import 'package:whisp/common/domain/failure.dart';
import 'package:whisp/local_storage/domain/i_local_storage_repository.dart';
import 'package:whisp/messaging/domain/message.dart';
import 'package:whisp/notifications/domain/i_notification_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'chat_state.dart';
part 'chat_cubit.freezed.dart';

@injectable
class ChatCubit extends Cubit<ChatState> {
  final IChatRepository _chatRepository;
  final ILocalStorageRepository _localStorageRepository;
  final INotificationService _notificationService;

  StreamSubscription<List<Message>>? _messagesSubscription;
  String? _conversationId;
  String? _currentUserOnionAddress;
  bool _isPinging = false;
  bool _shouldContinuePinging = true;

  ChatCubit(
    this._chatRepository,
    this._localStorageRepository,
    this._notificationService,
  ) : super(const ChatState.initial());

  /// Initialize chat with a specific conversation
  Future<void> init(String conversationId) async {
    _conversationId = conversationId;
    _currentUserOnionAddress = _localStorageRepository.getUser()?.onionAddress;

    // Set active chat to suppress notifications from this contact
    _notificationService.setActiveChat(conversationId);

    emit(const ChatState.loading());

    // Load initial messages
    await _loadMessages();

    // Start ping loop to check recipient's online status (pings immediately, then loops)
    _startPingLoop();

    // Subscribe to real-time message updates
    _messagesSubscription = _chatRepository
        .watchMessages(conversationId)
        .listen(
          (messages) {
            state.maybeMap(
              loaded: (currentState) {
                // Merge new messages, avoiding duplicates
                final existingIds = currentState.messages
                    .map((m) => m.id)
                    .toSet();
                final newMessages = messages.where(
                  (m) => !existingIds.contains(m.id),
                );

                if (newMessages.isNotEmpty) {
                  final updatedMessages = [
                    ...currentState.messages,
                    ...newMessages,
                  ];
                  updatedMessages.sort(
                    (a, b) => a.timestamp.compareTo(b.timestamp),
                  );

                  emit(currentState.copyWith(messages: updatedMessages));
                }
              },
              orElse: () {},
            );
          },
          onError: (error) {
            log('Messages stream error: $error');
          },
        );
  }

  /// Start ping loop: ping -> wait for response -> wait interval -> ping again
  void _startPingLoop() {
    _shouldContinuePinging = true;
    _pingLoop();
  }

  /// Stop the ping loop
  void _stopPingLoop() {
    _shouldContinuePinging = false;
  }

  /// Recursive ping loop: ping -> wait -> ping again
  Future<void> _pingLoop() async {
    if (!_shouldContinuePinging || _conversationId == null) return;

    await _checkOnlineStatus();

    if (!_shouldContinuePinging) return;
    // delay to avoid spamming
    await Future.delayed(const Duration(seconds: 2));

    // Continue loop
    _pingLoop();
  }

  /// Check if recipient is online
  Future<void> _checkOnlineStatus() async {
    if (_conversationId == null || _isPinging) return;

    _isPinging = true;

    final result = await _chatRepository.pingUser(_conversationId!);

    _isPinging = false;

    result.fold(
      (failure) {
        // On failure, assume offline
        _updateOnlineStatus(false);
      },
      (isOnline) {
        _updateOnlineStatus(isOnline);
      },
    );
  }

  /// Update online status in current state
  void _updateOnlineStatus(bool isOnline) {
    state.maybeMap(
      loaded: (currentState) {
        if (currentState.isRecipientOnline != isOnline) {
          emit(currentState.copyWith(isRecipientOnline: isOnline));
        }
      },
      orElse: () {},
    );
  }

  /// Load messages with pagination support
  Future<void> _loadMessages({bool loadMore = false}) async {
    if (_conversationId == null) return;

    DateTime? cursor;
    cursor = state.maybeMap(
      loaded: (s) => loadMore ? s.nextCursor : null,
      orElse: () => null,
    );

    final result = await _chatRepository.getMessages(
      _conversationId!,
      before: cursor,
    );

    result.fold(
      (failure) {
        emit(
          ChatState.error(
            errorMessage: 'Failed to load messages',
            messages: state.messages,
            hasMore: state.hasMore,
            nextCursor: state.nextCursor,
          ),
        );
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

        emit(
          ChatState.loaded(
            messages: allMessages,
            hasMore: page.hasMore,
            nextCursor: page.nextCursor,
          ),
        );
      },
    );
  }

  /// Load more messages for pagination
  Future<void> loadMore() async {
    final currentState = state.maybeMap(loaded: (s) => s, orElse: () => null);
    if (currentState == null) return;

    if (!currentState.hasMore) return;

    await _loadMessages(loadMore: true);
  }

  /// Send a message
  Future<void> sendMessage(String content) async {
    if (_conversationId == null || content.trim().isEmpty) return;
    final currentState = state.maybeMap(loaded: (s) => s, orElse: () => null);
    if (currentState == null) return;
    emit(currentState.copyWith(isSending: true));

    final result = await _chatRepository.sendMessage(
      recipientOnionAddress: _conversationId!,
      content: content.trim(),
    );

    result.fold(
      (failure) {
        // Determine error type based on failure
        final ChatErrorType errorType;
        final String errorMessage;

        if (failure is TorConnectionError || failure is RecipientOfflineError) {
          errorType = ChatErrorType.recipientOffline;
          errorMessage = 'Recipient is offline';
          // Update online status to offline
          _updateOnlineStatus(false);
        } else if (failure is MessageSendError) {
          errorType = ChatErrorType.connectionError;
          errorMessage = 'Failed to send message';
        } else {
          errorType = ChatErrorType.generic;
          errorMessage = 'Something went wrong';
        }

        // Emit send error state
        emit(
          ChatState.sendError(
            errorMessage: errorMessage,
            errorType: errorType,
            messages: currentState.messages,
            hasMore: currentState.hasMore,
            nextCursor: currentState.nextCursor,
            isRecipientOnline: false,
          ),
        );

        // Recover to loaded state after error
        emit(currentState.copyWith(isSending: false, isRecipientOnline: false));
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
    // Clear active chat when leaving
    _notificationService.setActiveChat(null);
    _messagesSubscription?.cancel();
    _stopPingLoop();
    return super.close();
  }
}
