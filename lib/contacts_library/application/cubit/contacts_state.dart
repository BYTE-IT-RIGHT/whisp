part of 'contacts_cubit.dart';

@immutable
sealed class ContactsState {}

final class ContactsData extends ContactsState {
  final List<Contact> contacts;
  ContactsData({required this.contacts});
}
