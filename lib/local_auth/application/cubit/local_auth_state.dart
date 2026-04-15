part of 'local_auth_cubit.dart';

enum LocalAuthStatus { initial, data, loading, authenticated, unauthenticated }

@freezed
abstract class LocalAuthState with _$LocalAuthState {
  const factory LocalAuthState({
    @Default(false) bool isEnabled,
    @Default(false) bool requireAuthenticationOnPause,
    @Default(false) bool isDeviceSupported,
    @Default(false) bool hasPin,
    @Default(LocalAuthStatus.initial) LocalAuthStatus status,
  }) = _LocalAuthState;
}
