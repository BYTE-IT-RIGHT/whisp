import 'package:dartz/dartz.dart';
import 'package:whisp/common/domain/failure.dart';

/// Interface for managing foreground task service
/// Used to keep the app running in the background with a persistent notification
abstract class IForegroundTaskService {
  /// Initialize the foreground task service
  /// Must be called before starting the service
  Future<Either<Failure, Unit>> init();

  /// Start the foreground task with a persistent notification
  /// Shows the user that they're connected to the messaging app and Tor
  Future<Either<Failure, Unit>> startService();

  /// Stop the foreground task
  Future<Either<Failure, Unit>> stopService();

  /// Update the notification text
  Future<Either<Failure, Unit>> updateNotification({
    required String title,
    required String body,
  });

  /// Check if the foreground service is currently running
  Future<bool> isRunning();
}

