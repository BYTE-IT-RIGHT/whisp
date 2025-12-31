import 'dart:developer';

import 'package:injectable/injectable.dart';
import 'package:local_auth/local_auth.dart';
import 'package:whisp/local_auth/domain/i_local_auth_repository.dart';

@LazySingleton(as: ILocalAuthRepository)
class LocalAuthRepository implements ILocalAuthRepository {
  final _localAuth = LocalAuthentication();

  @override
  Future<bool> isDeviceSupported() async => _localAuth.isDeviceSupported();

  @override
  Future<bool> authenticate() async {
    try {
      final result = await _localAuth.authenticate(
        localizedReason: 'Please authenticate to access your account',
      );
      return result;
    } catch (e) {
      log('authenticate unexpected error: $e');
      return false;
    }
  }
}
