part of 'local_auth_cubit.dart';

enum LocalAuthStatus { initial, data, loading, authenticated, unauthenticated }

final class LocalAuthState {
  final bool isEnabled;
  final bool requireAuthenticationOnPause;
  final bool isDeviceSupported;
  final bool hasPin;
  final LocalAuthStatus status;

  LocalAuthState({
    this.isEnabled = false,
    this.requireAuthenticationOnPause = false,
    this.isDeviceSupported = false,
    this.hasPin = false,
    this.status = LocalAuthStatus.initial,
  });

  LocalAuthState copyWith({
    bool? isEnabled,
    bool? requireAuthenticationOnPause,
    bool? isDeviceSupported,
    bool? hasPin,
    LocalAuthStatus? status,
  }) {
    return LocalAuthState(
      isEnabled: isEnabled ?? this.isEnabled,
      requireAuthenticationOnPause:
          requireAuthenticationOnPause ?? this.requireAuthenticationOnPause,
      isDeviceSupported: isDeviceSupported ?? this.isDeviceSupported,
      hasPin: hasPin ?? this.hasPin,
      status: status ?? this.status,
    );
  }
}
