abstract class ILocalAuthRepository {
  Future<bool> isDeviceSupported();
  Future<bool> authenticate();
}
