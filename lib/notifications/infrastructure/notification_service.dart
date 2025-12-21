import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'package:whisp/common/domain/failure.dart';
import 'package:whisp/di/injection.dart';
import 'package:whisp/local_storage/domain/i_local_storage_repository.dart';
import 'package:whisp/messaging/domain/message.dart' as msg;
import 'package:whisp/navigation/navigation.dart';
import 'package:whisp/navigation/navigation.gr.dart';
import 'package:whisp/notifications/domain/i_notification_service.dart';

// Access to local storage for checking notification settings
ILocalStorageRepository get _localStorageRepository => getIt<ILocalStorageRepository>();

/// Callback for handling notification taps
@pragma('vm:entry-point')
void onDidReceiveNotificationResponse(NotificationResponse response) {
  log('Notification tapped: ${response.payload}');
  
  final payload = response.payload;
  if (payload == null || payload.isEmpty) return;
  
  // Navigate to the chat with this contact
  _navigateToChat(payload);
}

/// Navigate to chat screen with the given onion address
Future<void> _navigateToChat(String onionAddress) async {
  try {
    final localStorageRepository = getIt<ILocalStorageRepository>();
    final contact = await localStorageRepository.getContactByOnionAddress(onionAddress);
    
    if (contact != null) {
      final navigation = getIt<Navigation>();
      navigation.push(ChatRoute(contact: contact));
      log('Navigating to chat with: ${contact.username}');
    } else {
      log('Contact not found for onion address: $onionAddress');
    }
  } catch (e) {
    log('Error navigating to chat: $e');
  }
}

@LazySingleton(as: INotificationService)
class NotificationService implements INotificationService {
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;
  String? _activeChat;

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
  String? get activeChat => _activeChat;

  @override
  void setActiveChat(String? senderOnionAddress) {
    _activeChat = senderOnionAddress;
    log('Active chat set to: $senderOnionAddress');
  }

  @override
  Future<Either<Failure, Unit>> init() async {
    if (_isInitialized) {
      return right(unit);
    }

    try {
      // Android initialization settings - use monochrome icon for status bar
      const androidSettings = AndroidInitializationSettings('@drawable/ic_launcher_monochrome');

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
      // Check if notifications are enabled in settings
      if (!_localStorageRepository.areNotificationsEnabled()) {
        log('Notifications disabled in settings');
        return right(unit);
      }

      // Don't show notifications for ping messages
      if (message.type == msg.MessageType.ping) {
        return right(unit);
      }

      // Don't show notification if we're currently in the chat with this sender
      final senderOnionAddress = message.sender.onionAddress;
      if (_activeChat != null && _activeChat == senderOnionAddress) {
        log('Skipping notification - user is in active chat with sender');
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
        icon: '@drawable/ic_launcher_monochrome',
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
        payload: senderOnionAddress, // Use for navigation
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
