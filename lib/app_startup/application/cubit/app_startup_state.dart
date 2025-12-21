part of 'app_startup_cubit.dart';

@immutable
sealed class AppStartupState {}

final class AppStartupLoading extends AppStartupState {
  final double progress;
  final String statusMessage;

  AppStartupLoading({required this.progress, required this.statusMessage});

  AppStartupLoading copyWith({
    double? progress,
    String? statusMessage,
    String? log,
  }) {
    return AppStartupLoading(
      progress: progress ?? this.progress,
      statusMessage: statusMessage ?? this.statusMessage,
    );
  }
}

final class AppStartupAuthenticated extends AppStartupState {
  final String onionAddress;
  AppStartupAuthenticated(this.onionAddress);
}

final class AppStartupTutorialPending extends AppStartupState {
  final String onionAddress;
  AppStartupTutorialPending(this.onionAddress);
}

final class AppStartupUnauthenticated extends AppStartupState {
  final String onionAddress;
  AppStartupUnauthenticated(this.onionAddress);
}

final class AppStartupError extends AppStartupState {
  final Failure failure;
  final String message;
  AppStartupError(this.failure, [this.message = '']);
}
