import 'package:dartz/dartz.dart';
import 'package:whisp/common/domain/failure.dart';
import 'package:whisp/messaging/domain/message.dart' as msg;

/// Interface for the local notification service
abstract class INotificationService {
  /// Initialize the notification service
  /// Must be called before any other methods
  Future<Either<Failure, Unit>> init();

  /// Show a notification for an incoming message
  Future<Either<Failure, Unit>> showMessageNotification(msg.Message message);

  /// Request notification permissions from the user
  Future<bool> requestPermissions();

  /// Check if notifications are enabled
  Future<bool> areNotificationsEnabled();

  /// Cancel a specific notification by ID
  Future<void> cancelNotification(int id);

  /// Cancel all notifications
  Future<void> cancelAllNotifications();
}

