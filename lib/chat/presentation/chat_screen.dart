import 'package:auto_route/auto_route.dart';
import 'package:flick/chat/application/cubit/chat_cubit.dart';
import 'package:flick/chat/presentation/widgets/chat_input.dart';
import 'package:flick/chat/presentation/widgets/message_bubble.dart';
import 'package:flick/common/widgets/styled_scaffold.dart';
import 'package:flick/conversations_library/domain/contact.dart';
import 'package:flick/di/injection.dart';
import 'package:flick/theme/domain/flick_theme.dart';
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ChatCubit>()..init(widget.contact.onionAddress),
      child: Builder(
        builder: (context) {
          return StyledScaffold(
            appBar: _buildAppBar(context),
            body: Column(
              children: [
                Expanded(child: _buildMessagesList(context)),
                BlocBuilder<ChatCubit, ChatState>(
                  builder: (context, state) {
                    return ChatInput(
                      onSend: (content) {
                        context.read<ChatCubit>().sendMessage(content);
                        // Scroll to bottom after sending
                        Future.delayed(
                          const Duration(milliseconds: 100),
                          _scrollToBottom,
                        );
                      },
                      isSending: state.isSending,
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final theme = context.flickTheme;

    return AppBar(
      backgroundColor: theme.background,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: theme.stroke),
        onPressed: () => context.router.maybePop(),
      ),
      title: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: theme.primary,
            child: Text(
              widget.contact.username[0].toUpperCase(),
              style: TextStyle(
                color: theme.background,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.contact.username,
                  style: TextStyle(
                    color: theme.stroke,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Encrypted',
                  style: TextStyle(
                    color: theme.primary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          height: 1,
          color: theme.stroke.withOpacity(0.1),
        ),
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
            child: CircularProgressIndicator(
              color: context.flickTheme.primary,
            ),
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
                  color: context.flickTheme.stroke.withOpacity(0.5),
                ),
                const SizedBox(height: 16),
                Text(
                  state.errorMessage ?? 'Something went wrong',
                  style: TextStyle(
                    color: context.flickTheme.stroke.withOpacity(0.7),
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
                  color: context.flickTheme.stroke.withOpacity(0.3),
                ),
                const SizedBox(height: 16),
                Text(
                  'No messages yet',
                  style: TextStyle(
                    color: context.flickTheme.stroke.withOpacity(0.5),
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Send a message to start the conversation',
                  style: TextStyle(
                    color: context.flickTheme.stroke.withOpacity(0.4),
                    fontSize: 14,
                  ),
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
                      color: context.flickTheme.primary,
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

