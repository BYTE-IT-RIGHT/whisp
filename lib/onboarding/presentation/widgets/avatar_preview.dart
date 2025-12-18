import 'package:whisp/theme/domain/whisp_theme.dart';
import 'package:flutter/material.dart';

class AvatarPreview extends StatelessWidget {
  final String? avatarUrl;
  final String username;

  const AvatarPreview({
    super.key,
    required this.avatarUrl,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.whispTheme;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutBack,
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: theme.primary.withValues(alpha: 0.15),
        border: Border.all(color: theme.primary, width: 3),
      ),
      child: ClipOval(
        child: avatarUrl != null && avatarUrl!.isNotEmpty
            ? _NetworkAvatar(url: avatarUrl!)
            : _LetterAvatar(username: username, theme: theme),
      ),
    );
  }
}

class _NetworkAvatar extends StatelessWidget {
  final String url;

  const _NetworkAvatar({required this.url});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
            strokeWidth: 2,
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) => Icon(
        Icons.error_outline,
        size: 40,
        color: context.whispTheme.primary,
      ),
    );
  }
}

class _LetterAvatar extends StatelessWidget {
  final String username;
  final WhispTheme theme;

  const _LetterAvatar({required this.username, required this.theme});

  @override
  Widget build(BuildContext context) {
    final letter = username.isNotEmpty ? username[0].toUpperCase() : '?';
    return Container(
      color: theme.primary,
      child: Center(
        child: Text(
          letter,
          style: theme.h1.copyWith(color: Colors.white, fontSize: 48),
        ),
      ),
    );
  }
}

