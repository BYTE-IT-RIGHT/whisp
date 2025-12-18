import 'package:flick/add_contact/application/cubit/add_contact_cubit.dart';
import 'package:flick/common/domain/failure.dart';
import 'package:flick/theme/domain/flick_theme.dart';
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
    final theme = context.flickTheme;

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
    return switch (state) {
      AddContactWaiting() => const SizedBox(
        width: 64,
        height: 64,
        child: CircularProgressIndicator(strokeWidth: 3),
      ),
      AddContactSuccess() => const Icon(
        Icons.check_circle,
        color: Colors.green,
        size: 64,
      ),
      AddContactDeclined() => const Icon(
        Icons.cancel,
        color: Colors.red,
        size: 64,
      ),
      AddContactError() => const Icon(
        Icons.error_outline,
        color: Colors.orange,
        size: 64,
      ),
      _ => const SizedBox.shrink(),
    };
  }

  Widget _buildTitle(FlickTheme theme) {
    final text = switch (state) {
      AddContactWaiting() => 'Invitation Pending',
      AddContactSuccess() => 'Invitation Accepted!',
      AddContactDeclined() => 'Invitation Declined',
      AddContactError() => 'Error',
      _ => '',
    };

    return Text(text, style: theme.h5);
  }

  Widget _buildSubtitle(FlickTheme theme) {
    final text = switch (state) {
      AddContactWaiting() => 'Waiting for response...',
      AddContactSuccess(:final username) => '$username accepted your invite!',
      AddContactDeclined() => 'Your invitation was declined',
      AddContactError(:final failure) => _getErrorMessage(failure),
      _ => '',
    };

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

  Widget _buildActions(BuildContext context, FlickTheme theme) {
    return switch (state) {
      AddContactWaiting() => const SizedBox.shrink(),
      AddContactSuccess() => ElevatedButton(
        onPressed: onClose,
        child: const Text('Done'),
      ),
      AddContactDeclined() || AddContactError() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(onPressed: onClose, child: const Text('Close')),
          const SizedBox(width: 16),
          ElevatedButton(onPressed: onRetry, child: const Text('Try again')),
        ],
      ),
      _ => const SizedBox.shrink(),
    };
  }
}

