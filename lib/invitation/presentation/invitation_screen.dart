import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:whisp/common/widgets/profile_image.dart';
import 'package:whisp/common/widgets/styled_button.dart';
import 'package:whisp/common/widgets/styled_scaffold.dart';
import 'package:whisp/messaging/domain/message.dart';
import 'package:whisp/theme/domain/whisp_theme.dart';

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
    final theme = context.whispTheme;
    final sender = invitation.sender;

    return StyledScaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 48),

              Text(
                'Contact Request',
                style: theme.h4,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Someone wants to connect with you',
                style: theme.caption,
                textAlign: TextAlign.center,
              ),

              const Spacer(),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: theme.secondary,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: theme.stroke.withValues(alpha: 0.1)),
                ),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: theme.primary.withValues(alpha: 0.3),
                            blurRadius: 32,
                            spreadRadius: 8,
                          ),
                        ],
                      ),
                      child: ProfileImage(
                        contact: sender,
                        radius: 56,
                      ),
                    ),
                    const SizedBox(height: 24),

                    Text(
                      sender.username,
                      style: theme.h5,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: theme.background,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: theme.stroke.withValues(alpha: 0.1),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.vpn_lock_rounded,
                            size: 16,
                            color: theme.primary,
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              _formatOnionAddress(sender.onionAddress),
                              style: theme.caption.copyWith(
                                fontFamily: 'monospace',
                                letterSpacing: 0.5,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: StyledButton.primary(
                  text: 'Accept',
                  fullWidth: true,
                  leading: Icon(
                    Icons.check_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                  onPressed: () {
                    onAccept();
                    context.maybePop();
                  },
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: StyledButton.secondary(
                  text: 'Decline',
                  fullWidth: true,
                  leading: Icon(
                    Icons.close_rounded,
                    color: theme.body.color,
                    size: 20,
                  ),
                  onPressed: () {
                    onDecline();
                    context.maybePop();
                  },
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  String _formatOnionAddress(String address) {
    if (address.length <= 16) return address;
    return '${address.substring(0, 8)}...${address.substring(address.length - 8)}';
  }
}
