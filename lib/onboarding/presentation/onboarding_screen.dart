import 'package:auto_route/auto_route.dart';
import 'package:flick/di/injection.dart';
import 'package:flick/navigation/navigation.gr.dart';
import 'package:flick/onboarding/application/cubit/onboarding_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<OnboardingCubit>(),
      child: BlocConsumer<OnboardingCubit, OnboardingState>(
        listener: (context, state) {
          if (state is OnboardingSuccess) {
            context.replaceRoute(ConversationsLibraryRoute());
          }
        },
        builder: (context, state) => Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(controller: _controller),
              ElevatedButton(
                onPressed: () => context.read<OnboardingCubit>().createUser(
                  _controller.text,
                ),
                child: Text('save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
