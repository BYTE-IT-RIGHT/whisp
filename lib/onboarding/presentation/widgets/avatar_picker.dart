import 'package:flick/theme/domain/flick_theme.dart';
import 'package:flutter/material.dart';

class AvatarPicker extends StatelessWidget {
  final List<String> avatars;
  final String? selectedAvatarUrl;
  final ValueChanged<String?> onAvatarSelected;

  const AvatarPicker({
    super.key,
    required this.avatars,
    required this.selectedAvatarUrl,
    required this.onAvatarSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.flickTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Choose an avatar', style: theme.label),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.secondary,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: theme.stroke),
          ),
          child: Column(
            children: [
              // No avatar option
              _NoAvatarOption(
                isSelected:
                    selectedAvatarUrl == null || selectedAvatarUrl!.isEmpty,
                onTap: () => onAvatarSelected(null),
                theme: theme,
              ),
              const SizedBox(height: 16),
              // Avatar grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: avatars.length,
                itemBuilder: (context, index) {
                  final avatarUrl = avatars[index];
                  final isSelected = selectedAvatarUrl == avatarUrl;

                  return _AvatarItem(
                    avatarUrl: avatarUrl,
                    isSelected: isSelected,
                    onTap: () => onAvatarSelected(avatarUrl),
                    theme: theme,
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _NoAvatarOption extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;
  final FlickTheme theme;

  const _NoAvatarOption({
    required this.isSelected,
    required this.onTap,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.primary.withValues(alpha: 0.15)
              : theme.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? theme.primary : theme.stroke,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.primary.withValues(alpha: 0.2),
                border: Border.all(color: theme.primary),
              ),
              child: Center(
                child: Text(
                  'A',
                  style: theme.h5.copyWith(color: theme.primary),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Use initials',
                    style: theme.subtitle.copyWith(
                      color: isSelected ? theme.primary : null,
                    ),
                  ),
                  Text('Your first letter will be shown', style: theme.caption),
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle, color: theme.primary, size: 24),
          ],
        ),
      ),
    );
  }
}

class _AvatarItem extends StatelessWidget {
  final String avatarUrl;
  final bool isSelected;
  final VoidCallback onTap;
  final FlickTheme theme;

  const _AvatarItem({
    required this.avatarUrl,
    required this.isSelected,
    required this.onTap,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutBack,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? theme.primary : Colors.transparent,
            width: 3,
          ),
        ),
        child: ClipOval(
          child: Container(
            color: theme.background,
            child: Image.network(
              avatarUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  color: theme.secondary,
                  child: Center(
                    child: SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: theme.primary,
                      ),
                    ),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) => Container(
                color: theme.secondary,
                child: Icon(Icons.error_outline, size: 16, color: theme.primary),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
