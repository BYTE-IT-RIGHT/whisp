import 'package:flutter/material.dart';
import 'package:whisp/app_startup/application/cubit/app_startup_cubit.dart';
import 'package:whisp/app_startup/presentation/widgets/animated_gradient_background.dart';
import 'package:whisp/app_startup/presentation/widgets/error_section.dart';
import 'package:whisp/app_startup/presentation/widgets/floating_particles.dart';
import 'package:whisp/app_startup/presentation/widgets/loading_section.dart';
import 'package:whisp/common/widgets/logo.dart';
import 'package:whisp/theme/domain/whisp_theme.dart';

class StartupBody extends StatefulWidget {
  final AppStartupState state;
  const StartupBody({super.key, required this.state});

  @override
  State<StartupBody> createState() => _StartupBodyState();
}

class _StartupBodyState extends State<StartupBody>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _rotationController;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

    _rotationController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..forward();

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _rotationController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.whispTheme;

    return Stack(
      children: [
        // Animated background gradient
        AnimatedGradientBackground(theme: theme),

        // Floating particles
        FloatingParticles(theme: theme),

        // Main content
        SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Center(
                child: Column(
                  children: [
                    const Spacer(flex: 2),
                
                    // Logo
                    Logo(size: 128),
                
                    const SizedBox(height: 32),
                
                    // App name with gradient
                    ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: [Colors.white, theme.primary.withOpacity(0.8)],
                      ).createShader(bounds),
                      child: const Text(
                        'WHISP',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 8,
                        ),
                      ),
                    ),
                
                    const SizedBox(height: 12),
                
                    // Tagline
                    Text(
                      'Secure P2P Messaging',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 3,
                      ),
                    ),
                
                    const Spacer(),
                
                    // Loading section
                    if (widget.state is AppStartupLoading)
                      LoadingSection(
                        state: widget.state as AppStartupLoading,
                        theme: theme,
                      ),
                
                    // Error section
                    if (widget.state is AppStartupError)
                      ErrorSection(
                        state: widget.state as AppStartupError,
                        theme: theme,
                      ),
                
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
