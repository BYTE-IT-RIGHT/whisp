import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whisp/local_auth/application/cubit/local_auth_cubit.dart';
import 'package:whisp/navigation/navigation.gr.dart';

class LocalAuthBackgroundWrapper extends StatelessWidget {
  final Widget child;

  const LocalAuthBackgroundWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalAuthCubit, LocalAuthState>(
      builder: (context, state) {
        return _LocalAuthLifecycleHandler(
          isLocalAuthOnPauseEnabled: state.requireAuthenticationOnPause,
          child: child,
        );
      },
    );
  }
}

class _LocalAuthLifecycleHandler extends StatefulWidget {
  final Widget child;
  final bool isLocalAuthOnPauseEnabled;
  const _LocalAuthLifecycleHandler({
    required this.child,
    required this.isLocalAuthOnPauseEnabled,
  });

  @override
  State<_LocalAuthLifecycleHandler> createState() =>
      _LocalAuthLifecycleHandlerState();
}

class _LocalAuthLifecycleHandlerState extends State<_LocalAuthLifecycleHandler>
    with WidgetsBindingObserver {
  bool _authPushed = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (!mounted || !widget.isLocalAuthOnPauseEnabled) return;

    if (state == AppLifecycleState.inactive && !_authPushed) {
      if (mounted && context.router.topRoute.name == LocalAuthRoute.name) {
        return;
      }

      _authPushed = true;

      if (mounted) {
        context.read<LocalAuthCubit>().setToUnauthenticated();
        context.pushRoute(LocalAuthRoute(initialAuthentication: false));
      }
    }

    if (state == AppLifecycleState.resumed) {
      _authPushed = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
