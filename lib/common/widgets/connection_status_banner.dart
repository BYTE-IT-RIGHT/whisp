import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whisp/TOR/application/cubit/tor_connection_cubit.dart';
import 'package:whisp/TOR/domain/tor_connection_state.dart';
import 'package:whisp/theme/domain/whisp_theme.dart';

/// A banner that displays the current Tor connection status
/// Shows only when disconnected or connecting
class ConnectionStatusBanner extends StatelessWidget {
  const ConnectionStatusBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TorConnectionCubit, TorConnectionStatus>(
      builder: (context, status) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, -1),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              )),
              child: child,
            );
          },
          child: _buildBanner(context, status),
        );
      },
    );
  }

  Widget _buildBanner(BuildContext context, TorConnectionStatus status) {
    switch (status) {
      case TorConnectionStatus.connected:
        // Don't show banner when connected
        return const SizedBox.shrink(key: ValueKey('connected'));

      case TorConnectionStatus.connecting:
        return _ConnectionBannerContent(
          key: const ValueKey('connecting'),
          icon: Icons.sync,
          iconRotating: true,
          message: 'Connecting to Tor network...',
          backgroundColor: Colors.orange.shade700,
        );

      case TorConnectionStatus.disconnected:
        return _ConnectionBannerContent(
          key: const ValueKey('disconnected'),
          icon: Icons.wifi_off_rounded,
          iconRotating: false,
          message: 'Tor connection lost. Reconnecting...',
          backgroundColor: Colors.red.shade700,
          onTap: () => context.read<TorConnectionCubit>().checkConnection(),
        );

      case TorConnectionStatus.circuitFailed:
        return _ConnectionBannerContent(
          key: const ValueKey('circuit_failed'),
          icon: Icons.error_outline_rounded,
          iconRotating: false,
          message: 'Failed to establish Tor circuit',
          backgroundColor: Colors.red.shade800,
          onTap: () => context.read<TorConnectionCubit>().checkConnection(),
        );
    }
  }
}

class _ConnectionBannerContent extends StatefulWidget {
  final IconData icon;
  final bool iconRotating;
  final String message;
  final Color backgroundColor;
  final VoidCallback? onTap;

  const _ConnectionBannerContent({
    super.key,
    required this.icon,
    required this.iconRotating,
    required this.message,
    required this.backgroundColor,
    this.onTap,
  });

  @override
  State<_ConnectionBannerContent> createState() =>
      _ConnectionBannerContentState();
}

class _ConnectionBannerContentState extends State<_ConnectionBannerContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    if (widget.iconRotating) {
      _rotationController.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant _ConnectionBannerContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.iconRotating && !_rotationController.isAnimating) {
      _rotationController.repeat();
    } else if (!widget.iconRotating && _rotationController.isAnimating) {
      _rotationController.stop();
    }
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.whispTheme;

    return Material(
      color: widget.backgroundColor,
      child: InkWell(
        onTap: widget.onTap,
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RotationTransition(
                  turns: _rotationController,
                  child: Icon(
                    widget.icon,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Text(
                    widget.message,
                    style: theme.small.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                if (widget.onTap != null) ...[
                  const SizedBox(width: 10),
                  const Icon(
                    Icons.refresh_rounded,
                    color: Colors.white70,
                    size: 18,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

