import 'dart:async';

import 'package:flick/conversations_library/domain/contact.dart';
import 'package:flick/conversations_library/domain/conversation.dart';
import 'package:flick/local_storage/domain/i_local_storage_repository.dart';
import 'package:flick/messaging/domain/i_messages_repository.dart';
import 'package:flick/messaging/domain/message.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'conversations_state.dart';

@Injectable()
class ConversationsCubit extends Cubit<ConversationsState> {
  final ILocalStorageRepository _localStorageRepository;
  final IMessagesRepository _messagesRepository;
  
  StreamSubscription<List<Contact>>? _contactsSubscription;
  StreamSubscription<Message>? _messagesSubscription;
  
  // Cache contacts to rebuild conversations when new messages arrive
  List<Contact> _contacts = [];

  ConversationsCubit(this._localStorageRepository, this._messagesRepository)
    : super(ConversationsData(conversations: []));

  void init() {
    // Watch contacts changes
    _contactsSubscription = _localStorageRepository.watchContacts().listen((contacts) async {
      _contacts = contacts;
      await _refreshConversations();
    });

    // Watch incoming messages to refresh conversation order
    _messagesSubscription = _messagesRepository.incomingMessages.listen((_) async {
      await _refreshConversations();
    });
  }

  Future<void> _refreshConversations() async {
    final conversations = await _buildConversations(_contacts);
    emit(ConversationsData(conversations: conversations));
  }

  /// Builds conversations list with last messages for each contact
  Future<List<Conversation>> _buildConversations(List<Contact> contacts) async {
    final conversations = await Future.wait(
      contacts.map((contact) async {
        final lastMessage = await _localStorageRepository.getLastMessage(contact.onionAddress);
        return Conversation(contact: contact, lastMessage: lastMessage);
      }),
    );

    // Sort: conversations with messages first (by most recent), then without messages
    conversations.sort((a, b) {
      if (a.lastMessage == null && b.lastMessage == null) return 0;
      if (a.lastMessage == null) return 1; // Push contacts without messages to bottom
      if (b.lastMessage == null) return -1;
      return b.lastMessage!.timestamp.compareTo(a.lastMessage!.timestamp);
    });
    
    return conversations;
  }

  /// Get paginated messages for a specific conversation
  Future<MessagePage> getMessages(
    String conversationId, {
    int limit = 20,
    DateTime? before,
  }) {
    return _localStorageRepository.getMessages(
      conversationId,
      limit: limit,
      before: before,
    );
  }

  /// Save a new message to a conversation (for outgoing messages)
  Future<void> saveMessage(String conversationId, Message message) async {
    await _localStorageRepository.saveMessage(conversationId, message);
    await _refreshConversations();
  }

  /// Watch messages for a specific conversation (for real-time updates)
  Stream<List<Message>> watchMessages(String conversationId) {
    return _localStorageRepository.watchMessages(conversationId);
  }

  @override
  Future<void> close() {
    _contactsSubscription?.cancel();
    _messagesSubscription?.cancel();
    return super.close();
  }
}
