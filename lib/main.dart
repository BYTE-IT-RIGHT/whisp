import 'package:whisp/TOR/application/cubit/tor_connection_cubit.dart';
import 'package:whisp/di/injection.dart';
import 'package:whisp/foreground_task/domain/i_foreground_task_service.dart';
import 'package:whisp/invitation/application/cubit/invitation_cubit.dart';
import 'package:whisp/local_storage/domain/i_local_storage_repository.dart';
import 'package:whisp/navigation/navigation.dart';
import 'package:whisp/notifications/domain/i_notification_service.dart';
import 'package:whisp/theme/application/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> _initializer() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await getIt<ILocalStorageRepository>().init();
  await getIt<INotificationService>().init();
  await getIt<IForegroundTaskService>().init();
}

void main() async {
  await _initializer();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<ThemeCubit>()..init(context)),
        BlocProvider(create: (_) => getIt<InvitationCubit>()..init()),
        BlocProvider(create: (_) => getIt<TorConnectionCubit>()..init()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            routerConfig: getIt<Navigation>().config(),
            title: 'Whisp',
            theme: state.theme,
          );
        },
      ),
    );
  }
}
