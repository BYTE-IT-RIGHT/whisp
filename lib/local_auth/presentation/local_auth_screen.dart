import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whisp/common/widgets/styled_button.dart';
import 'package:whisp/common/widgets/styled_scaffold.dart';
import 'package:whisp/local_auth/application/cubit/local_auth_cubit.dart';
import 'package:pinput/pinput.dart';
import 'package:whisp/navigation/navigation.gr.dart';

@RoutePage()
class LocalAuthScreen extends StatefulWidget {
  final bool initialAuthentication;
  const LocalAuthScreen({super.key, this.initialAuthentication = true});

  @override
  State<LocalAuthScreen> createState() => _LocalAuthScreenState();
}

class _LocalAuthScreenState extends State<LocalAuthScreen> {
  
  @override
  void initState() {
    super.initState();
    if (widget.initialAuthentication) {
      context.read<LocalAuthCubit>().authenticate();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocalAuthCubit, LocalAuthState>(
      listener: (context, state) {
        if (state.status == LocalAuthStatus.authenticated) {
          context.router.replaceAll([const ConversationsLibraryRoute()]);
        }
      },
      builder: (context, state) => PopScope(
        canPop: false,
        child: StyledScaffold(
          body: Center(
            child: Column(
              children: [
                Text('Local Auth'),
                StyledButton.primary(
                  text: 'Authenticate',
                  onPressed: () {
                    context.read<LocalAuthCubit>().authenticate();
                  },
                ),
                StyledButton.secondary(
                  text: 'Use PIN instead',
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        child: Column(
                          children: [
                            Pinput(length: 6, onChanged: (value) {}),
                            StyledButton.secondary(
                              text: 'cancel',
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
