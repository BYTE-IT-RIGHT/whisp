import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:whisp/di/injection.dart';
import 'package:whisp/foreground_task/domain/i_foreground_task_service.dart';

/// A wrapper widget that manages the foreground task lifecycle.
/// 
/// When the app goes to background, it starts a foreground service showing
/// a notification that the user is connected to Tor.
/// When the app comes to foreground, it stops the service.
class ForegroundTaskWrapper extends StatefulWidget {
  final Widget child;

  const ForegroundTaskWrapper({super.key, required this.child});

  @override
  State<ForegroundTaskWrapper> createState() => _ForegroundTaskWrapperState();
}

class _ForegroundTaskWrapperState extends State<ForegroundTaskWrapper>
    with WidgetsBindingObserver {
  final IForegroundTaskService _foregroundTaskService =
      getIt<IForegroundTaskService>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    // Stop service when leaving this screen
    _foregroundTaskService.stopService();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    log('ForegroundTaskWrapper: AppLifecycleState changed to $state');

    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.hidden:
        // App moved to background - start foreground service
        _startForegroundService();
        break;
      case AppLifecycleState.resumed:
        // App came to foreground - stop foreground service
        _stopForegroundService();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
        // No action needed for these states
        break;
    }
  }

  Future<void> _startForegroundService() async {
    final result = await _foregroundTaskService.startService();
    result.fold(
      (failure) => log('ForegroundTaskWrapper: Failed to start service: $failure'),
      (_) => log('ForegroundTaskWrapper: Service started successfully'),
    );
  }

  Future<void> _stopForegroundService() async {
    final result = await _foregroundTaskService.stopService();
    result.fold(
      (failure) => log('ForegroundTaskWrapper: Failed to stop service: $failure'),
      (_) => log('ForegroundTaskWrapper: Service stopped successfully'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WithForegroundTask(child: widget.child);
  }
}

