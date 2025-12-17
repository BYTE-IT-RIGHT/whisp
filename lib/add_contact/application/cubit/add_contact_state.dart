part of 'add_contact_cubit.dart';

@immutable
sealed class AddContactState {}

final class AddContactLoading extends AddContactState {}

final class AddContactData extends AddContactState {
  final String onionAddress;

  AddContactData({required this.onionAddress});
}

final class AddContactSuccess extends AddContactState {}

final class AddContactError extends AddContactState {
  final Failure failure;

  AddContactError(this.failure);
}
