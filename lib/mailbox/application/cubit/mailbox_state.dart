part of 'mailbox_cubit.dart';

@immutable
sealed class MailboxState {}

class MailboxInitial extends MailboxState {}

class MailboxLoading extends MailboxState {}

class MailboxLoaded extends MailboxState {
  final List<Mailbox> mailboxes;

  MailboxLoaded({required this.mailboxes});

  MailboxLoaded copyWith({List<Mailbox>? mailboxes}) {
    return MailboxLoaded(mailboxes: mailboxes ?? this.mailboxes);
  }
}

class MailboxAddSuccess extends MailboxState {}

class MailboxAddError extends MailboxState {
  final Failure failure;
  final String onionAddress;

  MailboxAddError(this.failure, {required this.onionAddress});
}


