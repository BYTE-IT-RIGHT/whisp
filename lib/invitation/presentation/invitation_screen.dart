import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:whisp/common/widgets/profile_image.dart';
import 'package:whisp/common/widgets/styled_button.dart';
import 'package:whisp/common/widgets/styled_scaffold.dart';
import 'package:whisp/messaging/domain/message.dart';

@RoutePage()
class InvitationScreen extends StatelessWidget {
  final Message invitation;
  final Function() onAccept;
  final Function() onDecline;
  const InvitationScreen({
    super.key,
    required this.invitation,
    required this.onAccept,
    required this.onDecline,
  });

  @override
  Widget build(BuildContext context) {
    return StyledScaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ProfileImage(contact: invitation.sender),
          Text(invitation.sender.username),
          Text('Do you want to accept this invitation?'),
          Image.asset('assets/images/invitation.png'),
          Text(invitation.sender.onionAddress),
          StyledButton.primary(text: 'Accept', onPressed: onAccept),
          StyledButton.secondary(text: 'Decline', onPressed: onDecline),
        ],
      ),
    );
  }
}
