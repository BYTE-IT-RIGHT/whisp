part of 'add_contact_cubit.dart';

@immutable
sealed class AddContactState {}

final class AddContactLoading extends AddContactState {}

final class AddContactData extends AddContactState {
  final String onionAddress;

  AddContactData({required this.onionAddress});
}

final class AddContactWaiting extends AddContactState {
  final String onionAddress;

  AddContactWaiting({required this.onionAddress});
}

final class AddContactSuccess extends AddContactState {
  final String username;

  AddContactSuccess({required this.username});
}

final class AddContactDeclined extends AddContactState {
  final String onionAddress;

  AddContactDeclined({required this.onionAddress});
}

final class AddContactError extends AddContactState {
  final Failure failure;
  final String onionAddress;

  AddContactError(this.failure, {required this.onionAddress});
}
