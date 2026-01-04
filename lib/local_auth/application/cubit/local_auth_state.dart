part of 'local_auth_cubit.dart';

@immutable
sealed class LocalAuthState {}

final class LocalAuthInitial extends LocalAuthState {}

final class LocalAuthData extends LocalAuthState {
  final bool isEnabled;
  final bool requireAuthenticationOnPause;
  final bool isDeviceSupported;
  final bool hasPin;

  LocalAuthData({
    required this.isEnabled,
    required this.requireAuthenticationOnPause,
    required this.isDeviceSupported,
    required this.hasPin,
  });
}

final class LocalAuthAuthenticated extends LocalAuthState {}
