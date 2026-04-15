import 'package:whisp/add_contact/application/cubit/add_contact_cubit.dart';
import 'package:whisp/common/domain/failure.dart';
import 'package:whisp/theme/domain/whisp_theme.dart';
import 'package:flutter/material.dart';

class InviteStatusDialog extends StatelessWidget {
  final AddContactState state;
  final VoidCallback onClose;
  final VoidCallback onRetry;

  const InviteStatusDialog({
    super.key,
    required this.state,
    required this.onClose,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.whispTheme;

    return Dialog(
      backgroundColor: theme.secondary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildIcon(),
            const SizedBox(height: 16),
            _buildTitle(theme),
            const SizedBox(height: 8),
            _buildSubtitle(theme),
            const SizedBox(height: 24),
            _buildActions(context, theme),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return state.maybeWhen(
      waiting: (_) => const SizedBox(
        width: 64,
        height: 64,
        child: CircularProgressIndicator(strokeWidth: 3),
      ),
      success: (_) =>
          const Icon(Icons.check_circle, color: Colors.green, size: 64),
      declined: (_) => const Icon(Icons.cancel, color: Colors.red, size: 64),
      error: (_, onionAddress) =>
          const Icon(Icons.error_outline, color: Colors.orange, size: 64),
      orElse: () => const SizedBox.shrink(),
    );
  }

  Widget _buildTitle(WhispTheme theme) {
    final text = state.maybeWhen(
      waiting: (_) => 'Invitation Pending',
      success: (_) => 'Invitation Accepted!',
      declined: (_) => 'Invitation Declined',
      error: (_, _) => 'Error',
      orElse: () => '',
    );

    return Text(text, style: theme.h5);
  }

  Widget _buildSubtitle(WhispTheme theme) {
    final text = state.maybeWhen(
      waiting: (_) => 'Waiting for response...',
      success: (username) => '$username accepted your invite!',
      declined: (_) => 'Your invitation was declined',
      error: (failure, _) => _getErrorMessage(failure),
      orElse: () => '',
    );

    return Text(text, style: theme.body, textAlign: TextAlign.center);
  }

  String _getErrorMessage(Failure failure) {
    return switch (failure) {
      TorNotRunningError() => 'Tor is not running',
      TorConnectionError() => 'Could not connect to contact',
      RecipientOfflineError() => 'Contact is offline',
      MessageSendError() => 'Failed to send invitation',
      _ => 'An unexpected error occurred',
    };
  }

  Widget _buildActions(BuildContext context, WhispTheme theme) {
    return state.maybeWhen(
      waiting: (_) => const SizedBox.shrink(),
      success: (_) =>
          ElevatedButton(onPressed: onClose, child: const Text('Done')),
      declined: (_) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(onPressed: onClose, child: const Text('Close')),
          const SizedBox(width: 16),
          ElevatedButton(onPressed: onRetry, child: const Text('Try again')),
        ],
      ),
      error: (_, _) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(onPressed: onClose, child: const Text('Close')),
          const SizedBox(width: 16),
          ElevatedButton(onPressed: onRetry, child: const Text('Try again')),
        ],
      ),
      orElse: () => const SizedBox.shrink(),
    );
  }
}
