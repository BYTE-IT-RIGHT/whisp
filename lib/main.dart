import 'package:flick/di/injection.dart';
import 'package:flick/local_storage/domain/i_local_storage_repository.dart';
import 'package:flick/navigation/navigation.dart';
import 'package:flutter/material.dart';

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
    return MaterialApp.router(
      routerConfig: getIt<Navigation>().config(),
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
    );
  }
}
