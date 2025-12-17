// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flick/local_storage/domain/i_local_storage_repository.dart'
    as _i1032;
import 'package:flick/local_storage/domain/i_secure_local_storage_repository.dart'
    as _i131;
import 'package:flick/local_storage/infrastructure/local_storage_repository.dart'
    as _i509;
import 'package:flick/local_storage/infrastructure/secure_local_storage_repository.dart'
    as _i945;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i131.ISecureLocalStorageRepository>(
      () => _i945.SecureLocalStorageRepository(),
    );
    gh.lazySingleton<_i1032.ILocalStorageRepository>(
      () => _i509.LocalStorageRepository(),
    );
    return this;
  }
}
