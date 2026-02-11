import 'dart:developer';

import 'package:injectable/injectable.dart';
import 'package:whisp/local_auth/domain/i_local_auth_repository.dart';
import 'package:local_auth/local_auth.dart';

@LazySingleton(as: ILocalAuthRepository)
class LocalAuthRepository implements ILocalAuthRepository {
  final _localAuth = LocalAuthentication();

  @override
  Future<bool> authenticate() async {
    try {
      final result = await _localAuth.authenticate(
        localizedReason: 'Authenticate to continue',
      );
      return result;
    } catch (e) {
      log('LocalAuthRepository authenticate error: $e');
      return false;
    }
  }

  @override
  Future<bool> isDeviceSupported() async {
    try {
      final result = await _localAuth.isDeviceSupported();
      return result;
    } catch (e) {
      log('LocalAuthRepository isDeviceSupported error: $e');
      return false;
    }
  }
}
