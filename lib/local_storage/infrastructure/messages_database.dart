import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'messages_database.g.dart';

/// Table for storing messages with proper indexing for pagination
@TableIndex(name: 'idx_conversation_timestamp', columns: {#conversationId, #timestamp})
class Messages extends Table {
  // Primary key - message ID
  TextColumn get id => text()();

  // Foreign key - conversation identifier (contact's onion address)
  TextColumn get conversationId => text()();

  // Message content (encrypted)
  TextColumn get content => text()();

  // Sender info (encrypted JSON)
  TextColumn get senderJson => text()();

  // Timestamp for sorting/pagination
  DateTimeColumn get timestamp => dateTime()();

  // Message type
  TextColumn get messageType => text().withDefault(const Constant('text'))();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Messages])
class MessagesDatabase extends _$MessagesDatabase {
  MessagesDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  /// Get messages for a conversation with cursor-based pagination
  Future<List<Message>> getMessagesForConversation(
    String conversationId, {
    int limit = 20,
    DateTime? before,
  }) {
    final query = select(messages)
      ..where((m) => m.conversationId.equals(conversationId));

    if (before != null) {
      query.where((m) => m.timestamp.isSmallerThanValue(before));
    }

    query
      ..orderBy([(m) => OrderingTerm.desc(m.timestamp)])
      ..limit(limit);

    return query.get();
  }

  /// Check if there are more messages before a timestamp
  Future<bool> hasMoreMessages(String conversationId, DateTime before) async {
    final query = select(messages)
      ..where((m) => m.conversationId.equals(conversationId))
      ..where((m) => m.timestamp.isSmallerThanValue(before))
      ..limit(1);

    final result = await query.get();
    return result.isNotEmpty;
  }

  /// Get the last message for a conversation
  Future<Message?> getLastMessage(String conversationId) async {
    final query = select(messages)
      ..where((m) => m.conversationId.equals(conversationId))
      ..orderBy([(m) => OrderingTerm.desc(m.timestamp)])
      ..limit(1);

    final results = await query.get();
    return results.isNotEmpty ? results.first : null;
  }

  /// Insert or update a message
  Future<void> upsertMessage(MessagesCompanion message) {
    return into(messages).insertOnConflictUpdate(message);
  }

  /// Watch messages for a conversation (real-time updates)
  Stream<List<Message>> watchMessages(String conversationId, {int limit = 50}) {
    final query = select(messages)
      ..where((m) => m.conversationId.equals(conversationId))
      ..orderBy([(m) => OrderingTerm.desc(m.timestamp)])
      ..limit(limit);

    return query.watch();
  }

  /// Delete all messages for a conversation
  Future<int> deleteConversationMessages(String conversationId) {
    return (delete(messages)..where((m) => m.conversationId.equals(conversationId))).go();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'flick_messages.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}

