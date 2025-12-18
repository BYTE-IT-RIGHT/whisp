import 'package:auto_route/auto_route.dart';
import 'package:whisp/chat/application/cubit/chat_cubit.dart';
import 'package:whisp/chat/presentation/widgets/chat_app_bar.dart';
import 'package:whisp/chat/presentation/widgets/chat_input.dart';
import 'package:whisp/chat/presentation/widgets/message_bubble.dart';
import 'package:whisp/common/widgets/styled_scaffold.dart';
import 'package:whisp/conversations_library/domain/contact.dart';
import 'package:whisp/di/injection.dart';
import 'package:whisp/theme/domain/whisp_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ChatScreen extends StatefulWidget {
  final Contact contact;

  const ChatScreen({super.key, required this.contact});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels <=
        _scrollController.position.minScrollExtent + 100) {
      // Near the top, load more older messages
      context.read<ChatCubit>().loadMore();
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _showOfflineDialog(BuildContext context) {
    final theme = context.whispTheme;
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: theme.secondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: theme.stroke),
        ),
        icon: Icon(
          Icons.cloud_off_rounded,
          size: 48,
          color: Colors.orange.shade400,
        ),
        title: Text(
          'Recipient Offline',
          style: theme.h6,
        ),
        content: Text(
          'This person is currently offline and cannot receive messages. Please try again later when they are online.',
          style: theme.body.copyWith(
            color: theme.body.color?.withValues(alpha: 0.8),
          ),
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            style: TextButton.styleFrom(
              backgroundColor: theme.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('OK'),
          ),
        ],
        actionsAlignment: MainAxisAlignment.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<ChatCubit>()..init(widget.contact.onionAddress),
      child: Builder(
        builder: (context) {
          return BlocListener<ChatCubit, ChatState>(
            listener: (context, state) {
              // Show offline dialog when send fails due to recipient being offline
              if (state is ChatSendError &&
                  state.errorType == ChatErrorType.recipientOffline) {
                _showOfflineDialog(context);
              }
            },
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                return StyledScaffold(
                  appBar: ChatAppBar(
                    contact: widget.contact,
                    isOnline: state.isRecipientOnline,
                  ),
                  body: Column(
                    children: [
                      Expanded(child: _buildMessagesList(context)),
                      ChatInput(
                        onSend: (content) {
                          context.read<ChatCubit>().sendMessage(content);
                          // Scroll to bottom after sending
                          Future.delayed(
                            const Duration(milliseconds: 100),
                            _scrollToBottom,
                          );
                        },
                        isSending: state.isSending,
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildMessagesList(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state) {
        if (state is ChatLoaded && state.messages.isNotEmpty) {
          // Scroll to bottom on initial load or new messages
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (_scrollController.hasClients) {
              _scrollController.jumpTo(
                _scrollController.position.maxScrollExtent,
              );
            }
          });
        }
      },
      builder: (context, state) {
        if (state is ChatLoading) {
          return Center(
            child: CircularProgressIndicator(color: context.whispTheme.primary),
          );
        }

        if (state is ChatError && state.messages.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 48,
                  color: context.whispTheme.stroke.withValues(alpha: 0.5),
                ),
                const SizedBox(height: 16),
                Text(
                  state.errorMessage ?? 'Something went wrong',
                  style: TextStyle(
                    color: context.whispTheme.stroke.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          );
        }

        final messages = state.messages;

        if (messages.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.chat_bubble_outline,
                  size: 64,
                  color: context.whispTheme.stroke.withValues(alpha: 0.3),
                ),
                const SizedBox(height: 16),
                Text('No messages yet', style: context.whispTheme.body),
                const SizedBox(height: 8),
                Text(
                  'Send a message to start the conversation',
                  style: context.whispTheme.caption,
                ),
              ],
            ),
          );
        }

        final cubit = context.read<ChatCubit>();

        return ListView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.symmetric(vertical: 16),
          itemCount: messages.length + (state.hasMore ? 1 : 0),
          itemBuilder: (context, index) {
            // Show loading indicator at the top for pagination
            if (state.hasMore && index == 0) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: context.whispTheme.primary,
                    ),
                  ),
                ),
              );
            }

            final messageIndex = state.hasMore ? index - 1 : index;
            final message = messages[messageIndex];

            return MessageBubble(
              message: message,
              isOwnMessage: cubit.isOwnMessage(message),
            );
          },
        );
      },
    );
  }
}
