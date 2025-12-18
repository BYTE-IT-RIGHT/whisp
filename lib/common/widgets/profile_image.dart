import 'package:flick/conversations_library/domain/contact.dart';
import 'package:flick/theme/domain/flick_theme.dart';
import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final Contact contact;
  final double radius;

  const ProfileImage({
    super.key,
    required this.contact,
    this.radius = 18,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.flickTheme;
    final hasAvatar = contact.avatarUrl.isNotEmpty;

    return CircleAvatar(
      radius: radius,
      backgroundColor: theme.primary,
      child: hasAvatar
          ? ClipOval(
              child: Image.network(
                contact.avatarUrl,
                width: radius * 2,
                height: radius * 2,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return _LetterFallback(
                    letter: contact.username[0].toUpperCase(),
                    theme: theme,
                    radius: radius,
                  );
                },
                errorBuilder: (context, error, stackTrace) => _LetterFallback(
                  letter: contact.username[0].toUpperCase(),
                  theme: theme,
                  radius: radius,
                ),
              ),
            )
          : _LetterFallback(
              letter: contact.username[0].toUpperCase(),
              theme: theme,
              radius: radius,
            ),
    );
  }
}

class _LetterFallback extends StatelessWidget {
  final String letter;
  final FlickTheme theme;
  final double radius;

  const _LetterFallback({
    required this.letter,
    required this.theme,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      letter,
      style: theme.h6.copyWith(
        fontSize: radius * 0.9,
        color: Colors.white,
      ),
    );
  }
}
