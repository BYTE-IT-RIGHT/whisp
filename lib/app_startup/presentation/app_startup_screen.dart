import 'package:auto_route/auto_route.dart';
import 'package:whisp/app_startup/application/cubit/app_startup_cubit.dart';
import 'package:whisp/app_startup/presentation/widgets/startup_body.dart';
import 'package:whisp/common/widgets/styled_scaffold.dart';
import 'package:whisp/di/injection.dart';
import 'package:whisp/navigation/navigation.gr.dart';
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
          if (state is AppStartupAuthenticated) {
            context.replaceRoute(ConversationsLibraryRoute());
          }
          if (state is AppStartupTutorialPending) {
            context.replaceRoute(TutorialRoute());
          }
          if (state is AppStartupUnauthenticated) {
            context.replaceRoute(OnboardingRoute());
          }
        },
        builder: (context, state) {
          return StyledScaffold(body: StartupBody(state: state));
        },
      ),
    );
  }
}
