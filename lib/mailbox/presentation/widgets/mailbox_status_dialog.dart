import 'package:flutter/material.dart';
import 'package:whisp/common/domain/failure.dart';
import 'package:whisp/common/widgets/styled_button.dart';
import 'package:whisp/mailbox/application/cubit/mailbox_cubit.dart';
import 'package:whisp/theme/domain/whisp_theme.dart';

class MailboxStatusDialog extends StatelessWidget {
  final MailboxAddError state;

  const MailboxStatusDialog({super.key, required this.state});

  static Future<void> show(BuildContext context, MailboxAddError state) async {
    return await showDialog<void>(
      context: context,
      builder: (context) => MailboxStatusDialog(state: state),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.whispTheme;

    final (icon, title, message) = _getErrorDetails(state.failure);

    return Dialog(
      backgroundColor: theme.background,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.error.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 48, color: theme.error),
            ),
            const SizedBox(height: 16),
            Text(title, style: theme.h5),
            const SizedBox(height: 8),
            Text(message, style: theme.body, textAlign: TextAlign.center),
            const SizedBox(height: 8),
            Text(
              _truncateAddress(state.onionAddress),
              style: theme.caption.copyWith(fontFamily: 'monospace'),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            StyledButton.primary(
              text: 'OK',
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }

  (IconData, String, String) _getErrorDetails(Failure failure) {
    return switch (failure) {
      MailboxConnectionError() => (
        Icons.cloud_off_rounded,
        'Connection Failed',
        'Could not connect to the mailbox. Please check the address and try again.',
      ),
      MailboxAuthenticationError() => (
        Icons.lock_outline_rounded,
        'Authentication Failed',
        'The password is incorrect. Please try again with the correct password.',
      ),
      _ => (
        Icons.error_outline_rounded,
        'Error',
        'An unexpected error occurred. Please try again.',
      ),
    };
  }

  String _truncateAddress(String address) {
    if (address.length <= 30) return address;
    return '${address.substring(0, 15)}...${address.substring(address.length - 15)}';
  }
}
