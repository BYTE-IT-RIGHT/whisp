// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flick/add_contact/application/cubit/add_contact_cubit.dart'
    as _i882;
import 'package:flick/add_contact/domain/i_add_contact_repository.dart'
    as _i397;
import 'package:flick/add_contact/infrastructure/add_contact_repository.dart'
    as _i966;
import 'package:flick/app_startup/application/cubit/app_startup_cubit.dart'
    as _i664;
import 'package:flick/invitation/application/cubit/invitation_cubit.dart'
    as _i368;
import 'package:flick/invitation/domain/i_invitation_repository.dart' as _i316;
import 'package:flick/invitation/infrastructure/invitation_repository.dart'
    as _i12;
import 'package:flick/local_storage/domain/i_local_storage_repository.dart'
    as _i1032;
import 'package:flick/local_storage/infrastructure/local_storage_repository.dart'
    as _i509;
import 'package:flick/messaging/application/cubit/messages_cubit.dart' as _i97;
import 'package:flick/messaging/domain/i_messages_repository.dart' as _i141;
import 'package:flick/messaging/infrastructure/messages_repository.dart'
    as _i873;
import 'package:flick/navigation/navigation.dart' as _i732;
import 'package:flick/onboarding/application/cubit/onboarding_cubit.dart'
    as _i632;
import 'package:flick/theme/application/cubit/theme_cubit.dart' as _i529;
import 'package:flick/TOR/domain/i_tor_repository.dart' as _i405;
import 'package:flick/TOR/infrastructure/tor_repository.dart' as _i856;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i732.Navigation>(() => _i732.Navigation());
    gh.lazySingleton<_i1032.ILocalStorageRepository>(
      () => _i509.LocalStorageRepository(),
    );
    gh.lazySingleton<_i405.ITorRepository>(() => _i856.TorRepository());
    gh.lazySingleton<_i397.IAddContactRepository>(
      () => _i966.AddContactRepository(
        gh<_i405.ITorRepository>(),
        gh<_i1032.ILocalStorageRepository>(),
      ),
    );
    gh.lazySingleton<_i316.IInvitationRepository>(
      () => _i12.InvitationRepository(
        gh<_i405.ITorRepository>(),
        gh<_i1032.ILocalStorageRepository>(),
      ),
    );
    gh.factory<_i664.AppStartupCubit>(
      () => _i664.AppStartupCubit(
        gh<_i1032.ILocalStorageRepository>(),
        gh<_i405.ITorRepository>(),
      ),
    );
    gh.factory<_i632.OnboardingCubit>(
      () => _i632.OnboardingCubit(
        gh<_i1032.ILocalStorageRepository>(),
        gh<_i405.ITorRepository>(),
      ),
    );
    gh.factory<_i529.ThemeCubit>(
      () => _i529.ThemeCubit(gh<_i1032.ILocalStorageRepository>()),
    );
    gh.lazySingleton<_i141.IMessagesRepository>(
      () => _i873.MessagesRepository(gh<_i1032.ILocalStorageRepository>()),
    );
    gh.lazySingleton<_i368.InvitationCubit>(
      () => _i368.InvitationCubit(
        gh<_i141.IMessagesRepository>(),
        gh<_i316.IInvitationRepository>(),
        gh<_i1032.ILocalStorageRepository>(),
      ),
    );
    gh.factory<_i97.MessagesCubit>(
      () => _i97.MessagesCubit(gh<_i141.IMessagesRepository>()),
    );
    gh.factory<_i882.AddContactCubit>(
      () => _i882.AddContactCubit(
        gh<_i141.IMessagesRepository>(),
        gh<_i1032.ILocalStorageRepository>(),
        gh<_i397.IAddContactRepository>(),
      ),
    );
    return this;
  }
}
