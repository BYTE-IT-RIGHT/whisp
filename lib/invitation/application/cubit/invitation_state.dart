part of 'invitation_cubit.dart';

@immutable
sealed class InvitationState {}

class InvitationInitial extends InvitationState {}

class InvitationPending extends InvitationState {
  final Message invitation;

  InvitationPending({required this.invitation});
}

class InvitationAccepting extends InvitationState {
  final Message invitation;

  InvitationAccepting({required this.invitation});
}

class InvitationAccepted extends InvitationState {
  final Message invitation;

  InvitationAccepted({required this.invitation});
}

class InvitationDeclined extends InvitationState {
  final Message invitation;

  InvitationDeclined({required this.invitation});
}

class InvitationError extends InvitationState {
  final String message;

  InvitationError({required this.message});
}

