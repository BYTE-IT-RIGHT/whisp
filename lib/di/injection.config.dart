// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:whisp/add_contact/application/cubit/add_contact_cubit.dart'
    as _i1030;
import 'package:whisp/add_contact/domain/i_add_contact_repository.dart'
    as _i447;
import 'package:whisp/add_contact/infrastructure/add_contact_repository.dart'
    as _i861;
import 'package:whisp/app_startup/application/cubit/app_startup_cubit.dart'
    as _i47;
import 'package:whisp/chat/application/cubit/chat_cubit.dart' as _i748;
import 'package:whisp/chat/domain/i_chat_repository.dart' as _i245;
import 'package:whisp/chat/infrastructure/chat_repository.dart' as _i634;
import 'package:whisp/conversations_library/application/cubit/conversations_cubit.dart'
    as _i576;
import 'package:whisp/encryption/domain/i_signal_protocol_store.dart' as _i387;
import 'package:whisp/encryption/domain/i_signal_service.dart' as _i102;
import 'package:whisp/encryption/infrastructure/signal_protocol_store.dart'
    as _i905;
import 'package:whisp/encryption/infrastructure/signal_service.dart' as _i772;
import 'package:whisp/foreground_task/domain/i_foreground_task_service.dart'
    as _i814;
import 'package:whisp/foreground_task/infrastructure/foreground_task_service.dart'
    as _i655;
import 'package:whisp/invitation/application/cubit/invitation_cubit.dart'
    as _i1012;
import 'package:whisp/invitation/domain/i_invitation_repository.dart' as _i236;
import 'package:whisp/invitation/infrastructure/invitation_repository.dart'
    as _i360;
import 'package:whisp/local_storage/domain/i_local_storage_repository.dart'
    as _i761;
import 'package:whisp/local_storage/infrastructure/local_storage_repository.dart'
    as _i37;
import 'package:whisp/messaging/application/cubit/messages_cubit.dart' as _i385;
import 'package:whisp/messaging/domain/i_messages_repository.dart' as _i725;
import 'package:whisp/messaging/infrastructure/messages_repository.dart'
    as _i833;
import 'package:whisp/navigation/navigation.dart' as _i966;
import 'package:whisp/notifications/domain/i_notification_service.dart'
    as _i1009;
import 'package:whisp/notifications/infrastructure/notification_service.dart'
    as _i548;
import 'package:whisp/onboarding/application/cubit/onboarding_cubit.dart'
    as _i664;
import 'package:whisp/theme/application/cubit/theme_cubit.dart' as _i140;
import 'package:whisp/TOR/domain/i_tor_repository.dart' as _i699;
import 'package:whisp/TOR/infrastructure/tor_repository.dart' as _i929;
import 'package:whisp/tutorial/application/cubit/tutorial_cubit.dart' as _i1072;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i966.Navigation>(() => _i966.Navigation());
    gh.lazySingleton<_i699.ITorRepository>(() => _i929.TorRepository());
    gh.lazySingleton<_i814.IForegroundTaskService>(
      () => _i655.ForegroundTaskService(),
    );
    gh.lazySingleton<_i761.ILocalStorageRepository>(
      () => _i37.LocalStorageRepository(),
    );
    gh.factory<_i47.AppStartupCubit>(
      () => _i47.AppStartupCubit(
        gh<_i761.ILocalStorageRepository>(),
        gh<_i699.ITorRepository>(),
      ),
    );
    gh.lazySingleton<_i387.ISignalProtocolStore>(
      () => _i905.SignalProtocolStore(),
    );
    gh.lazySingleton<_i1009.INotificationService>(
      () => _i548.NotificationService(),
    );
    gh.lazySingleton<_i102.ISignalService>(
      () => _i772.SignalService(gh<_i387.ISignalProtocolStore>()),
    );
    gh.factory<_i664.OnboardingCubit>(
      () => _i664.OnboardingCubit(
        gh<_i761.ILocalStorageRepository>(),
        gh<_i699.ITorRepository>(),
        gh<_i102.ISignalService>(),
      ),
    );
    gh.lazySingleton<_i245.IChatRepository>(
      () => _i634.ChatRepository(
        gh<_i699.ITorRepository>(),
        gh<_i761.ILocalStorageRepository>(),
        gh<_i102.ISignalService>(),
      ),
    );
    gh.lazySingleton<_i447.IAddContactRepository>(
      () => _i861.AddContactRepository(
        gh<_i699.ITorRepository>(),
        gh<_i761.ILocalStorageRepository>(),
        gh<_i102.ISignalService>(),
      ),
    );
    gh.factory<_i748.ChatCubit>(
      () => _i748.ChatCubit(
        gh<_i245.IChatRepository>(),
        gh<_i761.ILocalStorageRepository>(),
        gh<_i1009.INotificationService>(),
      ),
    );
    gh.lazySingleton<_i725.IMessagesRepository>(
      () => _i833.MessagesRepository(
        gh<_i761.ILocalStorageRepository>(),
        gh<_i102.ISignalService>(),
        gh<_i1009.INotificationService>(),
      ),
    );
    gh.factory<_i140.ThemeCubit>(
      () => _i140.ThemeCubit(gh<_i761.ILocalStorageRepository>()),
    );
    gh.factory<_i1072.TutorialCubit>(
      () => _i1072.TutorialCubit(gh<_i761.ILocalStorageRepository>()),
    );
    gh.factory<_i385.MessagesCubit>(
      () => _i385.MessagesCubit(gh<_i725.IMessagesRepository>()),
    );
    gh.lazySingleton<_i236.IInvitationRepository>(
      () => _i360.InvitationRepository(
        gh<_i699.ITorRepository>(),
        gh<_i761.ILocalStorageRepository>(),
        gh<_i102.ISignalService>(),
      ),
    );
    gh.factory<_i1030.AddContactCubit>(
      () => _i1030.AddContactCubit(
        gh<_i725.IMessagesRepository>(),
        gh<_i761.ILocalStorageRepository>(),
        gh<_i447.IAddContactRepository>(),
      ),
    );
    gh.factory<_i576.ConversationsCubit>(
      () => _i576.ConversationsCubit(
        gh<_i761.ILocalStorageRepository>(),
        gh<_i725.IMessagesRepository>(),
      ),
    );
    gh.lazySingleton<_i1012.InvitationCubit>(
      () => _i1012.InvitationCubit(
        gh<_i725.IMessagesRepository>(),
        gh<_i236.IInvitationRepository>(),
        gh<_i761.ILocalStorageRepository>(),
      ),
    );
    return this;
  }
}
