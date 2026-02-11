import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whisp/common/widgets/styled_button.dart';
import 'package:whisp/common/widgets/styled_scaffold.dart';
import 'package:whisp/local_auth/application/cubit/local_auth_cubit.dart';
import 'package:whisp/local_auth/presentation/dialogs/pin_input_dialog.dart';
import 'package:whisp/navigation/navigation.gr.dart';
import 'package:whisp/theme/domain/whisp_theme.dart';

@RoutePage()
class LocalAuthScreen extends StatefulWidget {
  final bool initialAuthentication;
  const LocalAuthScreen({super.key, this.initialAuthentication = true});

  @override
  State<LocalAuthScreen> createState() => _LocalAuthScreenState();
}

class _LocalAuthScreenState extends State<LocalAuthScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.initialAuthentication) {
      context.read<LocalAuthCubit>().authenticate();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.whispTheme;

    return BlocConsumer<LocalAuthCubit, LocalAuthState>(
      listener: (context, state) {
        if (state.status == LocalAuthStatus.authenticated) {
          if (context.router.stack.length > 1) {
            context.pop();
          } else {
            context.router.replaceAll([const ConversationsLibraryRoute()]);
          }
        }
      },
      builder: (context, state) => PopScope(
        canPop: false,
        child: StyledScaffold(
          body: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(flex: 2),
                    // Lock icon
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: theme.secondary,
                        border: Border.all(
                          color: theme.primary.withValues(alpha: 0.3),
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        Icons.lock_outline_rounded,
                        size: 36,
                        color: theme.primary,
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Title
                    Text(
                      'Welcome Back',
                      style: theme.h3.copyWith(letterSpacing: -0.5),
                    ),
                    const SizedBox(height: 12),
                    // Subtitle
                    Text(
                      'Authenticate to access your conversations',
                      style: theme.caption.copyWith(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(flex: 2),
                    // Buttons
                    StyledButton.primary(
                      text: 'Authenticate',
                      fullWidth: true,
                      leading: const Icon(
                        Icons.fingerprint_rounded,
                        color: Colors.white,
                        size: 22,
                      ),
                      onPressed: () {
                        context.read<LocalAuthCubit>().authenticate();
                      },
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () async {
                        final pin = await PinInputDialog.show(context);
                        if (pin != null && context.mounted) {
                          context.read<LocalAuthCubit>().authenticateWithPin(
                            pin,
                          );
                        }
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: theme.primary,
                      ),
                      child: Text(
                        'Use PIN instead',
                        style: theme.small.copyWith(
                          color: theme.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
