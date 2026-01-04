import 'package:auto_route/auto_route.dart';
import 'package:whisp/common/widgets/styled_scaffold.dart';
import 'package:whisp/local_auth/application/cubit/local_auth_cubit.dart';
import 'package:whisp/local_auth/presentation/sheets/verify_pin_sheet.dart';
import 'package:whisp/navigation/navigation.gr.dart';
import 'package:whisp/theme/domain/whisp_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whisp/di/injection.dart';

@RoutePage()
class LocalAuthScreen extends StatelessWidget {
  const LocalAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: BlocProvider(
        create: (context) => getIt<LocalAuthCubit>()..init(),
        child: BlocConsumer<LocalAuthCubit, LocalAuthState>(
          listener: (context, state) {
            if (state is LocalAuthAuthenticated) {
              context.router.replaceAll([const ConversationsLibraryRoute()]);
            }
          },
          builder: (context, state) {
            return StyledScaffold(body: _LocalAuthBody(state: state));
          },
        ),
      ),
    );
  }
}

class _LocalAuthBody extends StatefulWidget {
  final LocalAuthState state;

  const _LocalAuthBody({required this.state});

  @override
  State<_LocalAuthBody> createState() => _LocalAuthBodyState();
}

class _LocalAuthBodyState extends State<_LocalAuthBody> {
  @override
  void didUpdateWidget(_LocalAuthBody oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  Future<void> _handleBiometricAuth() async {
    final cubit = context.read<LocalAuthCubit>();
    final state = cubit.state;

    if (state is! LocalAuthData || !state.isDeviceSupported) {
      return;
    }

    await cubit.authenticateWithBiometric();
  }

  void _handleUnlockWithPin() {
    final cubit = context.read<LocalAuthCubit>();
    final theme = context.whispTheme;

    VerifyPinSheet.show(context: context, theme: theme, localAuthCubit: cubit);
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.whispTheme;
    final state = widget.state;

    if (state is! LocalAuthData) {
      return const SizedBox.shrink();
    }

    final hasPin = state.hasPin;
    final isDeviceSupported = state.isDeviceSupported;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          children: [
            const Spacer(flex: 2),

            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: theme.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.lock_outline_rounded,
                size: 40,
                color: theme.primary,
              ),
            ),

            const SizedBox(height: 32),

            Text(
              'Authentication Required',
              style: theme.h3,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 12),

            Text(
              'Unlock to access your account',
              style: theme.body.copyWith(
                color: theme.body.color?.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),

            const Spacer(),

            if (isDeviceSupported) ...[
              _UnlockButton(onPressed: _handleBiometricAuth, theme: theme),
              if (hasPin) ...[
                const SizedBox(height: 16),
                TextButton(
                  onPressed: _handleUnlockWithPin,
                  child: Text(
                    'Unlock using PIN',
                    style: theme.body.copyWith(color: theme.primary),
                  ),
                ),
              ],
            ],

            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}

class _UnlockButton extends StatelessWidget {
  final VoidCallback onPressed;
  final WhispTheme theme;

  const _UnlockButton({required this.onPressed, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 64,
      decoration: BoxDecoration(
        color: theme.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.fingerprint_rounded, color: Colors.white, size: 28),
                const SizedBox(width: 16),
                Text(
                  'Unlock',
                  style: theme.button.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
