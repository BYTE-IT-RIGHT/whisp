import 'package:auto_route/auto_route.dart';
import 'package:flick/add_contact/application/cubit/add_contact_cubit.dart';
import 'package:flick/common/screens/error_screen.dart';
import 'package:flick/common/screens/loading_screen.dart';
import 'package:flick/common/widgets/styled_scaffold.dart';
import 'package:flick/di/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class AddContactScreen extends StatelessWidget {
  const AddContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddContactCubit>()..init(),
      child: BlocBuilder<AddContactCubit, AddContactState>(
        builder: (context, state) {
          if (state is AddContactLoading) {
            return LoadingScreen();
          } else if (state is AddContactData) {
            return StyledScaffold(
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: FittedBox(
                            child: Text(state.onionAddress, maxLines: 1),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Clipboard.setData(
                              ClipboardData(text: state.onionAddress),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Copied to clipboard')),
                            );
                          },
                          child: Icon(Icons.copy),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            return ErrorScreen(
              failure: (state as AddContactError).failure,
              onRetry: () => context.read<AddContactCubit>().init(),
            );
          }
        },
      ),
    );
  }
}
