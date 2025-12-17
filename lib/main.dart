import 'package:flick/di/injection.dart';
import 'package:flick/local_storage/domain/i_local_storage_repository.dart';
import 'package:flick/navigation/navigation.dart';
import 'package:flick/theme/application/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> _initializer() async {
  configureDependencies();
  await getIt<ILocalStorageRepository>().init();
}

void main() async {
  await _initializer();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ThemeCubit>()..init(context),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            routerConfig: getIt<Navigation>().config(),
            title: 'Flick',
            theme: state.theme,
          );
        },
      ),
    );
  }
}
