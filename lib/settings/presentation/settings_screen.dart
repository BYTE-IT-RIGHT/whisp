import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whisp/common/constants/avatars.dart';
import 'package:whisp/common/screens/loading_screen.dart';
import 'package:whisp/common/widgets/styled_app_bar.dart';
import 'package:whisp/common/widgets/styled_scaffold.dart';
import 'package:whisp/di/injection.dart';
import 'package:whisp/local_auth/application/cubit/local_auth_cubit.dart';
import 'package:whisp/local_auth/presentation/sheets/disable_local_auth_sheet.dart';
import 'package:whisp/local_auth/presentation/sheets/enable_local_auth_sheet.dart';
import 'package:whisp/onboarding/presentation/widgets/avatar_picker.dart';
import 'package:whisp/onboarding/presentation/widgets/avatar_preview.dart';
import 'package:whisp/settings/application/cubit/settings_cubit.dart';
import 'package:whisp/settings/presentation/widgets/section_header.dart';
import 'package:whisp/settings/presentation/widgets/settings_switch.dart';
import 'package:whisp/settings/presentation/widgets/username_field.dart';
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
        listenWhen: (previous, current) {
          return previous is SettingsData && current is SettingsData;
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
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionHeader(title: 'Profile', theme: theme),
                    const SizedBox(height: 16),

                    Center(
                      child: AvatarPreview(
                        avatarUrl: data.avatarUrl.isEmpty
                            ? null
                            : data.avatarUrl,
                        username: data.username,
                      ),
                    ),
                    const SizedBox(height: 24),

                    UsernameField(
                      controller: _usernameController,
                      username: data.username,
                      theme: theme,
                      isEditing: _isEditingUsername,
                      onEditToggle: () {
                        setState(() {
                          if (_isEditingUsername) {
                            final newUsername = _usernameController.text.trim();
                            if (newUsername.isNotEmpty) {
                              context.read<SettingsCubit>().updateUsername(
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
                      selectedAvatarUrl: data.avatarUrl.isEmpty
                          ? null
                          : data.avatarUrl,
                      onAvatarSelected: (url) {
                        context.read<SettingsCubit>().updateAvatar(url ?? '');
                      },
                    ),

                    const SizedBox(height: 32),

                    SectionHeader(title: 'Notifications', theme: theme),
                    const SizedBox(height: 12),

                    SettingsSwitch(
                      title: 'Message Notifications',
                      subtitle: 'Show notifications for incoming messages',
                      value: data.notificationsEnabled,
                      onChanged: (value) {
                        context.read<SettingsCubit>().toggleNotifications(
                          value,
                        );
                      },
                      theme: theme,
                    ),
                    const SizedBox(height: 12),

                    SettingsSwitch(
                      title: 'Background Connection',
                      subtitle:
                          'Show notification when connected in background',
                      value:
                          data.notificationsEnabled &&
                          data.foregroundServiceEnabled,
                      onChanged: (value) {
                        if (!data.notificationsEnabled) {
                          return;
                        }
                        context.read<SettingsCubit>().toggleForegroundService(
                          value,
                        );
                      },
                      theme: theme,
                    ),

                    const SizedBox(height: 32),

                    if (data.isDeviceSupported) ...[
                      SectionHeader(title: 'Security', theme: theme),
                      const SizedBox(height: 12),

                      SettingsSwitch(
                        title: 'Biometric Lock',
                        subtitle: 'Require biometric or PIN to access the app',
                        value: data.localAuthEnabled,
                        onChanged: (value) {
                          if (value) {
                            final localAuthCubit = getIt<LocalAuthCubit>();
                            EnableLocalAuthSheet.show(
                              context: context,
                              theme: theme,
                              localAuthCubit: localAuthCubit,
                            ).then((_) {
                              if (context.mounted) {
                                context.read<SettingsCubit>().init();
                              }
                            });
                          } else {
                            final settingsCubit = context.read<SettingsCubit>();
                            DisableLocalAuthSheet.show(
                              context: context,
                              theme: theme,
                              settingsCubit: settingsCubit,
                              onVerified: () {
                                if (context.mounted) {
                                  context.read<SettingsCubit>().init();
                                }
                              },
                            );
                          }
                        },
                        theme: theme,
                      ),

                      const SizedBox(height: 12),
                      SettingsSwitch(
                        title: 'Authenticate on Pause',
                        subtitle:
                            'Require authentication when returning to the app',
                        value:
                            data.localAuthEnabled &&
                            data.requireAuthenticationOnPause,
                        onChanged: (value) {
                          context
                              .read<SettingsCubit>()
                              .toggleRequireAuthenticationOnPause(value);
                        },
                        theme: theme,
                      ),
                    ],
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
