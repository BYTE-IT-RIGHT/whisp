import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:whisp/di/injection.dart';
import 'package:whisp/foreground_task/domain/i_foreground_task_service.dart';
import 'package:whisp/local_storage/domain/i_local_storage_repository.dart';

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
  final ILocalStorageRepository _localStorageRepository =
      getIt<ILocalStorageRepository>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
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
        _startForegroundService();
        break;
      case AppLifecycleState.resumed:
        _stopForegroundService();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
        break;
    }
  }

  Future<void> _startForegroundService() async {
    if (!_localStorageRepository.isForegroundServiceEnabled()) {
      log('ForegroundTaskWrapper: Foreground service disabled in settings');
      return;
    }

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

