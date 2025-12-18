import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:whisp/app_startup/application/cubit/app_startup_cubit.dart';
import 'package:whisp/theme/domain/whisp_theme.dart';

class LoadingSection extends StatelessWidget {
  final AppStartupLoading state;
  final WhispTheme theme;

  const LoadingSection({
    super.key,
    required this.state,
    required this.theme,
  });

  List<_StepData> get _steps => [
    _StepData(
      title: 'Initializing',
      description: 'Setting up secure environment',
      threshold: 0.0,
    ),
    _StepData(
      title: 'Connecting',
      description: 'Establishing Tor network',
      threshold: 0.25,
    ),
    _StepData(
      title: 'Building Circuit',
      description: 'Creating encrypted tunnel',
      threshold: 0.50,
    ),
    _StepData(
      title: 'Finalizing',
      description: 'Starting hidden service',
      threshold: 0.85,
    ),
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
        color: theme.secondary.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.stroke.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Steps indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_steps.length, (index) {
              final isCompleted = index < currentStep;
              final isCurrent = index == currentStep;
              return _StepDot(
                index: index,
                isCompleted: isCompleted,
                isCurrent: isCurrent,
                theme: theme,
                isLast: index == _steps.length - 1,
              );
            }),
          ),

          const SizedBox(height: 24),

          // Current step info
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Column(
              key: ValueKey(currentStep),
              children: [
                Text(
                  _steps[currentStep].title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _steps[currentStep].description,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Progress bar with percentage
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: state.progress),
                    duration: const Duration(milliseconds: 300),
                    builder: (context, value, child) {
                      return Stack(
                        children: [
                          // Background
                          Container(
                            height: 10,
                            decoration: BoxDecoration(
                              color: theme.stroke.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          // Progress with gradient
                          FractionallySizedBox(
                            widthFactor: value.clamp(0.0, 1.0),
                            child: Container(
                              height: 10,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    theme.primary,
                                    theme.primary.withOpacity(0.7),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(6),
                                boxShadow: [
                                  BoxShadow(
                                    color: theme.primary.withOpacity(0.4),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 16),
              SizedBox(
                width: 48,
                child: Text(
                  '$percentage%',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: theme.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Status message with animated dots
          _AnimatedStatusMessage(
            message: state.statusMessage,
            theme: theme,
          ),
        ],
      ),
    );
  }
}

class _StepData {
  final String title;
  final String description;
  final double threshold;

  _StepData({
    required this.title,
    required this.description,
    required this.threshold,
  });
}

class _StepDot extends StatelessWidget {
  final int index;
  final bool isCompleted;
  final bool isCurrent;
  final WhispTheme theme;
  final bool isLast;

  const _StepDot({
    required this.index,
    required this.isCompleted,
    required this.isCurrent,
    required this.theme,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: isCurrent ? 32 : 12,
          height: 12,
          decoration: BoxDecoration(
            color: isCompleted || isCurrent
                ? theme.primary
                : theme.stroke.withOpacity(0.5),
            borderRadius: BorderRadius.circular(6),
            boxShadow: isCurrent
                ? [
                    BoxShadow(
                      color: theme.primary.withOpacity(0.5),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ]
                : null,
          ),
          child: isCurrent
              ? const Center(
                  child: _PulsingDot(color: Colors.white),
                )
              : isCompleted
                  ? const Icon(Icons.check, size: 8, color: Colors.white)
                  : null,
        ),
        if (!isLast)
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 24,
            height: 2,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: isCompleted
                  ? theme.primary
                  : theme.stroke.withOpacity(0.3),
              borderRadius: BorderRadius.circular(1),
            ),
          ),
      ],
    );
  }
}

class _PulsingDot extends StatefulWidget {
  final Color color;
  const _PulsingDot({required this.color});

  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: 4 + _controller.value * 2,
          height: 4 + _controller.value * 2,
          decoration: BoxDecoration(
            color: widget.color.withOpacity(0.8 + _controller.value * 0.2),
            shape: BoxShape.circle,
          ),
        );
      },
    );
  }
}

class _AnimatedStatusMessage extends StatefulWidget {
  final String message;
  final WhispTheme theme;

  const _AnimatedStatusMessage({
    required this.message,
    required this.theme,
  });

  @override
  State<_AnimatedStatusMessage> createState() => _AnimatedStatusMessageState();
}

class _AnimatedStatusMessageState extends State<_AnimatedStatusMessage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.security,
          size: 14,
          color: widget.theme.primary.withOpacity(0.7),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            widget.message,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(width: 4),
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final dotCount = (_controller.value * 4).floor() % 4;
            return SizedBox(
              width: 20,
              child: Text(
                '.' * dotCount,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

