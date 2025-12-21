import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'package:whisp/common/domain/failure.dart';
import 'package:whisp/messaging/domain/message.dart' as msg;
import 'package:whisp/notifications/domain/i_notification_service.dart';

/// Callback for handling notification taps
@pragma('vm:entry-point')
void onDidReceiveNotificationResponse(NotificationResponse response) {
  log('Notification tapped: ${response.payload}');
  // TODO: Navigate to the specific chat when notification is tapped
}

@LazySingleton(as: INotificationService)
class NotificationService implements INotificationService {
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  /// Android notification channel for messages
  static const AndroidNotificationChannel _messageChannel =
      AndroidNotificationChannel(
    'whisp_messages',
    'Messages',
    description: 'Notifications for incoming messages',
    importance: Importance.high,
    playSound: true,
    enableVibration: true,
  );

  @override
  Future<Either<Failure, Unit>> init() async {
    if (_isInitialized) {
      return right(unit);
    }

    try {
      // Android initialization settings
      const androidSettings = AndroidInitializationSettings('@mipmap/launcher_icon');

      const initSettings = InitializationSettings(android: androidSettings);

      // Initialize the plugin
      final initialized = await _plugin.initialize(
        initSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
      );

      if (initialized != true) {
        log('Failed to initialize notifications');
        return left(NotificationError('Failed to initialize notifications'));
      }

      // Create the notification channel on Android
      await _createNotificationChannel();

      _isInitialized = true;
      log('Notification service initialized successfully');
      return right(unit);
    } catch (e) {
      log('Error initializing notification service: $e');
      return left(NotificationError(e.toString()));
    }
  }

  Future<void> _createNotificationChannel() async {
    final androidPlugin =
        _plugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    if (androidPlugin != null) {
      await androidPlugin.createNotificationChannel(_messageChannel);
      log('Notification channel created: ${_messageChannel.id}');
    }
  }

  @override
  Future<bool> requestPermissions() async {
    final androidPlugin =
        _plugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    if (androidPlugin != null) {
      final granted = await androidPlugin.requestNotificationsPermission();
      log('Notification permission granted: $granted');
      return granted ?? false;
    }

    return false;
  }

  @override
  Future<bool> areNotificationsEnabled() async {
    final androidPlugin =
        _plugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    if (androidPlugin != null) {
      final enabled = await androidPlugin.areNotificationsEnabled();
      return enabled ?? false;
    }

    return false;
  }

  @override
  Future<Either<Failure, Unit>> showMessageNotification(msg.Message message) async {
    if (!_isInitialized) {
      log('Notification service not initialized');
      return left(NotificationError('Notification service not initialized'));
    }

    try {
      // Don't show notifications for ping or system messages
      if (message.type == msg.MessageType.ping) {
        return right(unit);
      }

      String title;
      String body;

      switch (message.type) {
        case msg.MessageType.text:
          title = message.sender.username;
          body = message.content;
        case msg.MessageType.contactRequest:
          title = 'New Contact Request';
          body = '${message.sender.username} wants to connect with you';
        case msg.MessageType.contactAccepted:
          title = 'Contact Accepted';
          body = '${message.sender.username} accepted your request';
        case msg.MessageType.contactDeclined:
          title = 'Contact Declined';
          body = '${message.sender.username} declined your request';
        case msg.MessageType.ping:
          return right(unit);
      }

      // Generate a unique notification ID from the message ID
      final notificationId = message.id.hashCode;

      final androidDetails = AndroidNotificationDetails(
        _messageChannel.id,
        _messageChannel.name,
        channelDescription: _messageChannel.description,
        importance: Importance.high,
        priority: Priority.high,
        icon: '@mipmap/launcher_icon',
        ticker: 'New message',
        category: AndroidNotificationCategory.message,
        styleInformation: BigTextStyleInformation(body),
      );

      final notificationDetails = NotificationDetails(android: androidDetails);

      await _plugin.show(
        notificationId,
        title,
        body,
        notificationDetails,
        payload: message.sender.onionAddress, // Use for navigation
      );

      log('Notification shown: $title - $body');
      return right(unit);
    } catch (e) {
      log('Error showing notification: $e');
      return left(NotificationError(e.toString()));
    }
  }

  @override
  Future<void> cancelNotification(int id) async {
    await _plugin.cancel(id);
  }

  @override
  Future<void> cancelAllNotifications() async {
    await _plugin.cancelAll();
  }
}
