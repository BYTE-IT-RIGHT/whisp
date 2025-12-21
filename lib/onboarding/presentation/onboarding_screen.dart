import 'package:auto_route/auto_route.dart';
import 'package:whisp/common/constants/avatars.dart';
import 'package:whisp/common/widgets/styled_button.dart';
import 'package:whisp/common/widgets/styled_scaffold.dart';
import 'package:whisp/di/injection.dart';
import 'package:whisp/navigation/navigation.gr.dart';
import 'package:whisp/onboarding/application/cubit/onboarding_cubit.dart';
import 'package:whisp/onboarding/presentation/widgets/avatar_picker.dart';
import 'package:whisp/onboarding/presentation/widgets/avatar_preview.dart';
import 'package:whisp/theme/domain/whisp_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = TextEditingController();
  String? _selectedAvatarUrl;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.whispTheme;

    return BlocProvider(
      create: (context) => getIt<OnboardingCubit>(),
      child: BlocConsumer<OnboardingCubit, OnboardingState>(
        listener: (context, state) {
          if (state is OnboardingSuccess) {
            context.replaceRoute(TutorialRoute());
          }
          if (state is OnboardingError) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Failed to create profile')),
            );
          }
        },
        builder: (context, state) => StyledScaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 24),
                  Text(
                    'Create Your Profile',
                    style: theme.h3,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),

                  Text(
                    'Choose an avatar and pick a username',
                    style: theme.caption,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  // Avatar preview
                  AvatarPreview(
                    avatarUrl: _selectedAvatarUrl,
                    username: _controller.text,
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: _controller,
                    onChanged: (_) => setState(() {}),
                    style: theme.body,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      labelStyle: theme.caption,
                      hintText: 'Enter your username',
                      hintStyle: theme.caption,
                      filled: true,
                      fillColor: theme.secondary,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: theme.stroke),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: theme.stroke),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: theme.primary, width: 2),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Avatar picker
                  AvatarPicker(
                    avatars: Avatars.avatars,
                    selectedAvatarUrl: _selectedAvatarUrl,
                    onAvatarSelected: (url) {
                      setState(() => _selectedAvatarUrl = url);
                    },
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
              child: SizedBox(
                height: 52,
                child: StyledButton.primary(
                  text: 'Continue',
                  fullWidth: true,
                  isLoading: state is OnboardingLoading,
                  onPressed: _controller.text.trim().isEmpty
                      ? null
                      : () => context.read<OnboardingCubit>().createUser(
                          username: _controller.text.trim(),
                          avatarUrl: _selectedAvatarUrl ?? '',
                        ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
