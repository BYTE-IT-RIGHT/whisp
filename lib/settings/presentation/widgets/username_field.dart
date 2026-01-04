import 'package:flutter/material.dart';
import 'package:whisp/theme/domain/whisp_theme.dart';

class UsernameField extends StatelessWidget {
  final TextEditingController controller;
  final String username;
  final WhispTheme theme;
  final bool isEditing;
  final VoidCallback onEditToggle;
  final ValueChanged<String> onChanged;

  const UsernameField({
    super.key,
    required this.controller,
    required this.username,
    required this.theme,
    required this.isEditing,
    required this.onEditToggle,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.secondary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.stroke),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Username', style: theme.caption),
                const SizedBox(height: 4),
                isEditing
                    ? TextFormField(
                        controller: controller,
                        onChanged: onChanged,
                        autofocus: true,
                        style: theme.body,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          hintText: 'Enter username',
                          hintStyle: theme.caption,
                        ),
                      )
                    : Text(username, style: theme.body),
              ],
            ),
          ),
          IconButton(
            onPressed: onEditToggle,
            icon: Icon(
              isEditing ? Icons.check : Icons.edit,
              color: theme.primary,
            ),
          ),
        ],
      ),
    );
  }
}

