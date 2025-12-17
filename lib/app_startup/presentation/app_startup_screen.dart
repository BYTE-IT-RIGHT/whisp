import 'package:auto_route/auto_route.dart';
import 'package:flick/app_startup/application/cubit/app_startup_cubit.dart';
import 'package:flick/di/injection.dart';
import 'package:flick/navigation/navigation.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class AppStartupScreen extends StatelessWidget {
  const AppStartupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AppStartupCubit>(),
      child: BlocConsumer<AppStartupCubit, AppStartupState>(
        listener: (context, state) {
          if(state is AppStartupAuthenticated){
            // context.pushRoute()
          }
          if(state is AppStartupUnauthenticated){
            context.pushRoute(OnboardingRoute());
          }
        },
        builder: (context, state) {
          return SizedBox();
        },
      ),
    );
  }
}
