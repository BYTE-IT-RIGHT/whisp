import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whisp/common/constants/avatars.dart';
import 'package:whisp/di/injection.dart';
import 'package:whisp/onboarding/presentation/widgets/avatar_picker.dart';
import 'package:whisp/onboarding/presentation/widgets/avatar_preview.dart';
import 'package:whisp/settings/application/user_settings_cubit/user_settings_cubit.dart';
import 'package:whisp/settings/presentation/widgets/section_header.dart';
import 'package:whisp/settings/presentation/widgets/username_field.dart';

class UserSettingsSection extends StatefulWidget {
  const UserSettingsSection({super.key});

  @override
  State<UserSettingsSection> createState() => _UserSettingsSectionState();
}

class _UserSettingsSectionState extends State<UserSettingsSection> {
  final _usernameController = TextEditingController();
  bool _isEditingUsername = false;

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<UserSettingsCubit>()..init(),
      child: BlocConsumer<UserSettingsCubit, UserSettingsState>(
        listener: (context, state) {
          if (state is UserSettingsData && _usernameController.text.isEmpty) {
            _usernameController.text = state.username;
          }
        },
        builder: (context, state) {
          if (state is UserSettingsData) {
            return Column(
              children: [
                SectionHeader(title: 'Profile'),
                const SizedBox(height: 16),

                Center(
                  child: AvatarPreview(
                    avatarUrl: state.avatarUrl.isEmpty ? null : state.avatarUrl,
                    username: state.username,
                  ),
                ),
                const SizedBox(height: 24),

                UsernameField(
                  controller: _usernameController,
                  username: state.username,
                  isEditing: _isEditingUsername,
                  onEditToggle: () {
                    setState(() {
                      if (_isEditingUsername) {
                        final newUsername = _usernameController.text.trim();
                        if (newUsername.isNotEmpty) {
                          context.read<UserSettingsCubit>().updateUsername(
                            newUsername,
                          );
                        }
                      }
                      _isEditingUsername = !_isEditingUsername;
                    });
                  },
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: 24),

                AvatarPicker(
                  avatars: Avatars.avatars,
                  selectedAvatarUrl: state.avatarUrl.isEmpty
                      ? null
                      : state.avatarUrl,
                  onAvatarSelected: (url) {
                    context.read<UserSettingsCubit>().updateAvatar(url ?? '');
                  },
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
