import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whisp/common/constants/avatars.dart';
import 'package:whisp/common/screens/loading_screen.dart';
import 'package:whisp/common/widgets/styled_app_bar.dart';
import 'package:whisp/common/widgets/styled_scaffold.dart';
import 'package:whisp/di/injection.dart';
import 'package:whisp/onboarding/presentation/widgets/avatar_picker.dart';
import 'package:whisp/onboarding/presentation/widgets/avatar_preview.dart';
import 'package:whisp/settings/application/cubit/settings_cubit.dart';
import 'package:whisp/theme/domain/whisp_theme.dart';

@RoutePage()
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _usernameController = TextEditingController();
  bool _isEditingUsername = false;

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.whispTheme;

    return BlocProvider(
      create: (context) => getIt<SettingsCubit>()..init(),
      child: BlocConsumer<SettingsCubit, SettingsState>(
        listener: (context, state) {
          if (state is SettingsData && !_isEditingUsername) {
            _usernameController.text = state.username;
          }
        },
        builder: (context, state) {
          if (state is SettingsLoading || state is SettingsInitial) {
            return StyledScaffold(
              appBar: StyledAppBar(title: 'Settings'),
              body: const LoadingScreen(),
            );
          }

          if (state is SettingsError) {
            return StyledScaffold(
              appBar: StyledAppBar(title: 'Settings'),
              body: Center(child: Text(state.message, style: theme.body)),
            );
          }

          final data = state as SettingsData;

          return StyledScaffold(
            appBar: StyledAppBar(title: 'Settings'),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile section
                  _SectionHeader(title: 'Profile', theme: theme),
                  const SizedBox(height: 16),

                  // Avatar preview
                  Center(
                    child: AvatarPreview(
                      avatarUrl: data.avatarUrl.isEmpty ? null : data.avatarUrl,
                      username: data.username,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Username field
                  _UsernameField(
                    controller: _usernameController,
                    theme: theme,
                    isEditing: _isEditingUsername,
                    onEditToggle: () {
                      setState(() {
                        if (_isEditingUsername) {
                          // Save
                          final newUsername = _usernameController.text.trim();
                          if (newUsername.isNotEmpty) {
                            context.read<SettingsCubit>().updateUsername(newUsername);
                          }
                        }
                        _isEditingUsername = !_isEditingUsername;
                      });
                    },
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: 24),

                  // Avatar picker
                  AvatarPicker(
                    avatars: Avatars.avatars,
                    selectedAvatarUrl: data.avatarUrl.isEmpty ? null : data.avatarUrl,
                    onAvatarSelected: (url) {
                      context.read<SettingsCubit>().updateAvatar(url ?? '');
                    },
                  ),

                  const SizedBox(height: 32),

                  // Notifications section
                  _SectionHeader(title: 'Notifications', theme: theme),
                  const SizedBox(height: 12),

                  _SettingsSwitch(
                    title: 'Message Notifications',
                    subtitle: 'Show notifications for incoming messages',
                    value: data.notificationsEnabled,
                    onChanged: (value) {
                      context.read<SettingsCubit>().toggleNotifications(value);
                    },
                    theme: theme,
                  ),
                  const SizedBox(height: 12),

                  _SettingsSwitch(
                    title: 'Background Connection',
                    subtitle: 'Show notification when connected in background',
                    value: data.foregroundServiceEnabled,
                    onChanged: (value) {
                      context.read<SettingsCubit>().toggleForegroundService(value);
                    },
                    theme: theme,
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final WhispTheme theme;

  const _SectionHeader({required this.title, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: theme.h5,
    );
  }
}

class _UsernameField extends StatelessWidget {
  final TextEditingController controller;
  final WhispTheme theme;
  final bool isEditing;
  final VoidCallback onEditToggle;
  final ValueChanged<String> onChanged;

  const _UsernameField({
    required this.controller,
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
                    : Text(controller.text, style: theme.body),
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

class _SettingsSwitch extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  final WhispTheme theme;

  const _SettingsSwitch({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                Text(title, style: theme.subtitle),
                const SizedBox(height: 2),
                Text(subtitle, style: theme.caption),
              ],
            ),
          ),
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeColor: theme.primary,
          ),
        ],
      ),
    );
  }
}

