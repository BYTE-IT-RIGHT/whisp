import 'package:whisp/theme/domain/whisp_theme.dart';
import 'package:flutter/material.dart';

class ChatInput extends StatefulWidget {
  final ValueChanged<String> onSend;
  final bool isSending;

  const ChatInput({super.key, required this.onSend, this.isSending = false});

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  bool get _hasText => _controller.text.trim().isNotEmpty;

  void _handleSend() {
    if (!_hasText || widget.isSending) return;

    widget.onSend(_controller.text);
    _controller.clear();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.whispTheme;

    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).padding.bottom + 8,
      ),
      decoration: BoxDecoration(
        color: theme.secondary,
        border: Border(top: BorderSide(color: theme.stroke)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  constraints: const BoxConstraints(maxHeight: 120),
                  decoration: BoxDecoration(
                    color: theme.stroke.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    maxLines: null,
                    textCapitalization: TextCapitalization.sentences,
                    style: theme.body,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: theme.stroke,
                      hintText: 'Type anonymous message...',
                      hintStyle: theme.caption,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(48),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(48),
                        borderSide: BorderSide(color: theme.primary),
                      ),
                    ),
                    onChanged: (_) => setState(() {}),
                    onSubmitted: (_) => _handleSend(),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Stack(
                children: [
                  AnimatedContainer(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: _hasText ? theme.primary : theme.stroke,
                    ),
                    alignment: Alignment.center,
                    duration: const Duration(milliseconds: 200),

                    child: widget.isSending
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Icon(
                            Icons.send_rounded,
                            color: Colors.white,
                            size: 22,
                          ),
                  ),
                  Positioned.fill(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(24),
                        onTap: _hasText && !widget.isSending
                            ? _handleSend
                            : null,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 8,
              children: [
                Icon(Icons.lock, color: theme.contrast, size: 12),
                Text(
                  'Serverless P2P - No metadata stored',
                  style: theme.caption,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
