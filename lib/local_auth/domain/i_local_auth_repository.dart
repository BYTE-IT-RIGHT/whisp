abstract class ILocalAuthRepository {
  Future<bool> authenticate();
  Future<bool> isDeviceSupported();
}
