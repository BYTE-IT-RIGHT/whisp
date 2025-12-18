import 'package:whisp/invitation/application/cubit/invitation_cubit.dart';
import 'package:whisp/messaging/domain/message.dart';
import 'package:whisp/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InvitationWrapper extends StatelessWidget {
  final Widget child;

  const InvitationWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InvitationCubit, InvitationState>(
      listener: (context, state) {
        if (state is InvitationPending) {
          _showInvitationDialog(context, state.invitation);
        }
      },
      builder: (context, state) => child,
    );
  }

  void _showInvitationDialog(BuildContext blocContext, Message invitation) {
    final navigatorContext = rootNavigatorKey.currentContext;
    if (navigatorContext == null) return;

    showDialog(
      context: navigatorContext,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Contact Request'),
          content: Text(
            '${invitation.sender.username} wants to add you as a contact.\n\nDo you want to accept?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                blocContext.read<InvitationCubit>().declineInvitation(invitation);
              },
              child: const Text('Decline'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                blocContext.read<InvitationCubit>().acceptInvitation(invitation);
              },
              child: const Text('Accept'),
            ),
          ],
        );
      },
    );
  }
}
