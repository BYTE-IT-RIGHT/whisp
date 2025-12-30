import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:injectable/injectable.dart';
import 'package:whisp/common/domain/failure.dart';
import 'package:whisp/foreground_task/domain/i_foreground_task_service.dart';

@pragma('vm:entry-point')
class WhispTaskHandler extends TaskHandler {
  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {
    log('ForegroundTask: onStart - $timestamp');
  }

  @override
  void onRepeatEvent(DateTime timestamp) {}

  @override
  Future<void> onDestroy(DateTime timestamp, bool isAppExit) async {
    log('ForegroundTask: onDestroy - $timestamp, isAppExit: $isAppExit');
  }

  @override
  void onReceiveData(Object data) {
    log('ForegroundTask: onReceiveData - $data');
  }

  @override
  void onNotificationButtonPressed(String id) {
    log('ForegroundTask: onNotificationButtonPressed - $id');
  }

  @override
  void onNotificationPressed() {
    log('ForegroundTask: onNotificationPressed');
    FlutterForegroundTask.launchApp();
  }

  @override
  void onNotificationDismissed() {
    log('ForegroundTask: onNotificationDismissed');
  }
}

@pragma('vm:entry-point')
void startCallback() {
  FlutterForegroundTask.setTaskHandler(WhispTaskHandler());
}

@LazySingleton(as: IForegroundTaskService)
class ForegroundTaskService implements IForegroundTaskService {
  bool _isInitialized = false;

  @override
  Future<Either<Failure, Unit>> init() async {
    if (_isInitialized) {
      return right(unit);
    }

    try {
      FlutterForegroundTask.init(
        androidNotificationOptions: AndroidNotificationOptions(
          channelId: 'whisp_foreground_service',
          channelName: 'Whisp Connection',
          channelDescription: 'Shows when Whisp is connected to the Tor network',
          channelImportance: NotificationChannelImportance.LOW,
          priority: NotificationPriority.LOW,
        ),
        iosNotificationOptions: const IOSNotificationOptions(
          showNotification: false,
          playSound: false,
        ),
        foregroundTaskOptions: ForegroundTaskOptions(
          eventAction: ForegroundTaskEventAction.repeat(60000),
          autoRunOnBoot: false,
          autoRunOnMyPackageReplaced: false,
          allowWakeLock: true,
          allowWifiLock: true,
        ),
      );

      _isInitialized = true;
      log('ForegroundTaskService: Initialized successfully');
      return right(unit);
    } catch (e) {
      log('ForegroundTaskService: Initialization error - $e');
      return left(ForegroundTaskError('Failed to initialize foreground task: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> startService() async {
    try {
      if (!_isInitialized) {
        final initResult = await init();
        if (initResult.isLeft()) {
          return initResult;
        }
      }

      if (await FlutterForegroundTask.isRunningService) {
        log('ForegroundTaskService: Service already running');
        return right(unit);
      }

      await FlutterForegroundTask.startService(
        notificationTitle: 'Whisp is Connected',
        notificationText: 'You are online and connected to Tor network',
        notificationIcon: const NotificationIcon(
          metaDataName: 'com.whisp.notification_icon',
        ),
        callback: startCallback,
      );

      log('ForegroundTaskService: Service started successfully');
      return right(unit);
    } catch (e) {
      log('ForegroundTaskService: Error starting service - $e');
      return left(ForegroundTaskError('Failed to start foreground service: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> stopService() async {
    try {
      if (!await FlutterForegroundTask.isRunningService) {
        log('ForegroundTaskService: Service not running');
        return right(unit);
      }

      await FlutterForegroundTask.stopService();

      log('ForegroundTaskService: Service stopped successfully');
      return right(unit);
    } catch (e) {
      log('ForegroundTaskService: Error stopping service - $e');
      return left(ForegroundTaskError('Failed to stop foreground service: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateNotification({
    required String title,
    required String body,
  }) async {
    try {
      if (!await FlutterForegroundTask.isRunningService) {
        log('ForegroundTaskService: Cannot update - service not running');
        return left(ForegroundTaskError('Foreground service is not running'));
      }

      await FlutterForegroundTask.updateService(
        notificationTitle: title,
        notificationText: body,
      );

      log('ForegroundTaskService: Notification updated - $title');
      return right(unit);
    } catch (e) {
      log('ForegroundTaskService: Error updating notification - $e');
      return left(ForegroundTaskError('Failed to update notification: $e'));
    }
  }

  @override
  Future<bool> isRunning() async {
    return await FlutterForegroundTask.isRunningService;
  }
}

