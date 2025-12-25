import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whisp/theme/domain/whisp_theme.dart';

void copyToClipboard(BuildContext context, String data) {
  Clipboard.setData(ClipboardData(text: data));
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.white, size: 20),
          const SizedBox(width: 12),
          const Text('Copied to clipboard'),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: context.whispTheme.primary,
      duration: const Duration(seconds: 2),
    ),
  );
}
