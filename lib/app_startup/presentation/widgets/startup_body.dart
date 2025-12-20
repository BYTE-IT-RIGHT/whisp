import 'package:flutter/material.dart';
import 'package:whisp/app_startup/application/cubit/app_startup_cubit.dart';
import 'package:whisp/app_startup/presentation/widgets/error_section.dart';
import 'package:whisp/common/widgets/logo.dart';
import 'package:whisp/common/widgets/styled_circular_progress_indicator.dart';
import 'package:whisp/theme/domain/whisp_theme.dart';

class StartupBody extends StatelessWidget {
  final AppStartupState state;
  const StartupBody({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final theme = context.whispTheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Center(
          child: Column(
            children: [
              const Spacer(flex: 2),

              // Logo
              Logo(size: 128),

              const SizedBox(height: 32),

              // App name
              Text(
                'WHISP',
                style: TextStyle(
                  color: theme.primary,
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 8,
                ),
              ),

              const SizedBox(height: 12),

              // Tagline
              Text(
                'Secure P2P Messaging',
                style: theme.caption.copyWith(letterSpacing: 3),
              ),

              const Spacer(),

              // Loading section
              if (state is AppStartupLoading)
                _LoadingSection(
                  state: state as AppStartupLoading,
                  theme: theme,
                ),

              // Error section
              if (state is AppStartupError)
                ErrorSection(state: state as AppStartupError, theme: theme),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoadingSection extends StatelessWidget {
  final AppStartupLoading state;
  final WhispTheme theme;

  const _LoadingSection({required this.state, required this.theme});

  static const List<_StepData> _steps = [
    _StepData(title: 'Establishing secure connection', threshold: 0.0),
    _StepData(title: 'Routing through Tor nodes', threshold: 0.33),
    _StepData(title: 'Verifying encryption', threshold: 0.66),
  ];

  int _getCurrentStep(double progress) {
    for (int i = _steps.length - 1; i >= 0; i--) {
      if (progress >= _steps[i].threshold) return i;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final currentStep = _getCurrentStep(state.progress);
    final percentage = (state.progress * 100).toInt();

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.secondary,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.stroke.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Progress bar with percentage
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  state.statusMessage,
                  style: theme.subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 12),
              Text(
                '$percentage%',
                style: theme.subtitle.copyWith(
                  color: theme.primary,
                  fontFeatures: [const FontFeature.tabularFigures()],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Progress bar
          LinearProgressIndicator(
            value: state.progress,
            color: theme.primary,
            backgroundColor: theme.stroke.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(4),
            minHeight: 8,
          ),

          const SizedBox(height: 24),

          // Steps list
          ...List.generate(_steps.length, (index) {
            final isCompleted = index < currentStep;
            final isCurrent = index == currentStep;
            final isPending = index > currentStep;

            return Padding(
              padding: EdgeInsets.only(
                bottom: index < _steps.length - 1 ? 16 : 0,
              ),
              child: Row(
                children: [
                  // Step indicator
                  isCompleted
                      ? Icon(
                          Icons.check,
                          size: 14,
                          color: context.whispTheme.primary,
                        )
                      : isCurrent
                      ? StyledCircularProgressIndicator(
                          size: 12,
                          strokeWidth: 2,
                        )
                      : StyledCircularProgressIndicator(
                          size: 12,
                          value: 1,
                          strokeWidth: 2,
                          color: context.whispTheme.stroke,
                        ),

                  const SizedBox(width: 12),

                  // Step title
                  Expanded(
                    child: Text(
                      _steps[index].title,
                      style: isCurrent
                          ? theme.subtitle
                          : isPending
                          ? theme.body.copyWith(
                              color: theme.body.color?.withValues(alpha: 0.4),
                            )
                          : theme.body,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _StepData {
  final String title;
  final double threshold;

  const _StepData({required this.title, required this.threshold});
}
