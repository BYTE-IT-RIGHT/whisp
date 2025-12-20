import 'package:auto_route/auto_route.dart';
import 'package:whisp/invitation/application/cubit/invitation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whisp/navigation/navigation.gr.dart';

class InvitationWrapper extends StatelessWidget {
  final Widget child;

  const InvitationWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InvitationCubit, InvitationState>(
      listener: (context, state) {
        if (state is InvitationPending) {
          context.pushRoute(
            InvitationRoute(
              invitation: state.invitation,
              onAccept: () {
                context.read<InvitationCubit>().acceptInvitation(
                  state.invitation,
                );
              },
              onDecline: () {
                context.read<InvitationCubit>().declineInvitation(
                  state.invitation,
                );
              },
            ),
          );
        }
      },
      builder: (context, state) => child,
    );
  }
}
