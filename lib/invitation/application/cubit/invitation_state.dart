part of 'invitation_cubit.dart';

@freezed
sealed class InvitationState with _$InvitationState {
  const factory InvitationState.initial() = InvitationInitial;
  const factory InvitationState.pending({required Message invitation}) =
      InvitationPending;
  const factory InvitationState.accepting({required Message invitation}) =
      InvitationAccepting;
  const factory InvitationState.accepted({required Message invitation}) =
      InvitationAccepted;
  const factory InvitationState.declined({required Message invitation}) =
      InvitationDeclined;
  const factory InvitationState.error({required String message}) =
      InvitationError;
}
