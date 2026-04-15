part of 'mailbox_cubit.dart';

@freezed
sealed class MailboxState with _$MailboxState {
  const factory MailboxState.initial() = MailboxInitial;
  const factory MailboxState.loading() = MailboxLoading;
  const factory MailboxState.loaded({required List<Mailbox> mailboxes}) =
      MailboxLoaded;
  const factory MailboxState.addSuccess() = MailboxAddSuccess;
  const factory MailboxState.addError(
    Failure failure, {
    required String onionAddress,
  }) = MailboxAddError;
}
