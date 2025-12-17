import 'package:auto_route/auto_route.dart';
import 'package:flick/app_startup/application/cubit/app_startup_cubit.dart';
import 'package:flick/di/injection.dart';
import 'package:flick/navigation/navigation.gr.dart';
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
            context.replaceRoute(ContactsLibraryRoute());
          }
          if (state is AppStartupUnauthenticated) {
            context.replaceRoute(OnboardingRoute());
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xFF0D0D0D),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    const Spacer(),
                    // Logo / Title
                    const Text('🧅', style: TextStyle(fontSize: 64)),
                    const SizedBox(height: 16),
                    const Text(
                      'Flick',
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
                      _buildProgressSection(state),

                    const Spacer(),

                    if (state is AppStartupLoading) Text(state.statusMessage),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProgressSection(AppStartupLoading state) {
    final percentage = (state.progress * 100).toInt();

    return Column(
      children: [
        // Progress bar
        Container(
          height: 8,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: state.progress,
              backgroundColor: Colors.transparent,
              color: Colors.blue,
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Percentage
        Text(
          '$percentage%',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),

        // Status message
        Text(
          state.statusMessage,
          style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 14),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
