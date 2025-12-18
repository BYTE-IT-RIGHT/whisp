import 'package:auto_route/auto_route.dart';
import 'package:whisp/app_startup/application/cubit/app_startup_cubit.dart';
import 'package:whisp/common/widgets/logo.dart';
import 'package:whisp/common/widgets/styled_circular_progress_indicator.dart';
import 'package:whisp/common/widgets/styled_scaffold.dart';
import 'package:whisp/di/injection.dart';
import 'package:whisp/navigation/navigation.gr.dart';
import 'package:whisp/theme/domain/whisp_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class AppStartupScreen extends StatelessWidget {
  const AppStartupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AppStartupCubit>(),
      child: BlocConsumer<AppStartupCubit, AppStartupState>(
        listener: (context, state) {
          if (state is AppStartupAuthenticated) {
            context.replaceRoute(ConversationsLibraryRoute());
          }
          if (state is AppStartupUnauthenticated) {
            context.replaceRoute(OnboardingRoute());
          }
        },
        builder: (context, state) {
          return StyledScaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    const Spacer(),
                    Logo(size: 128),
                    const SizedBox(height: 16),
                    const Text(
                      'Whisp',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Secure P2P Messaging',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 14,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 48),

                    // Progress section
                    if (state is AppStartupLoading)
                      _buildProgressSection(context, state: state),

                    const Spacer(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProgressSection(
    BuildContext context, {
    required AppStartupLoading state,
  }) {
    final percentage = (state.progress * 100).toInt();

    return Column(
      children: [
        StyledCircularProgressIndicator(size: 65),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                state.statusMessage,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Spacer(),
            Text(percentage.toString()),
          ],
        ),
        LinearProgressIndicator(
          borderRadius: BorderRadius.circular(4),
          minHeight: 8,
          value: state.progress,
          backgroundColor: context.whispTheme.stroke,
          color: context.whispTheme.primary,
        ),
        Column(children: []),
      ],
    );
  }
}
