import 'package:flutter/material.dart';
import 'package:whisp/common/widgets/styled_button.dart';
import 'package:whisp/common/widgets/styled_pinput.dart';
import 'package:whisp/theme/domain/whisp_theme.dart';

class MailboxPasswordDialog extends StatefulWidget {
  const MailboxPasswordDialog({super.key});

  static Future<String?> show(BuildContext context) async {
    return await showDialog<String>(
      context: context,
      builder: (context) => const MailboxPasswordDialog(),
    );
  }

  @override
  State<MailboxPasswordDialog> createState() => _MailboxPasswordDialogState();
}

class _MailboxPasswordDialogState extends State<MailboxPasswordDialog> {
  final _pinController = TextEditingController();

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.whispTheme;
    return Dialog(
      backgroundColor: theme.background,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.lock_outline_rounded, size: 48, color: theme.primary),
            const SizedBox(height: 16),
            Text('Enter Mailbox Password', style: theme.h5),
            const SizedBox(height: 8),
            Text(
              'Enter the 6-digit password for this mailbox',
              style: theme.caption,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            StyledPinput(
              controller: _pinController,
              onCompleted: (password) {
                Navigator.of(context).pop(password);
              },
              obscureText: false,
            ),
            const SizedBox(height: 24),
            StyledButton.secondary(
              text: 'Cancel',
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}
