part of 'add_contact_cubit.dart';

@freezed
sealed class AddContactState with _$AddContactState {
  const factory AddContactState.loading() = AddContactLoading;
  const factory AddContactState.data({required String onionAddress}) =
      AddContactData;
  const factory AddContactState.waiting({required String onionAddress}) =
      AddContactWaiting;
  const factory AddContactState.success({required String username}) =
      AddContactSuccess;
  const factory AddContactState.declined({required String onionAddress}) =
      AddContactDeclined;
  const factory AddContactState.error(
    Failure failure, {
    required String onionAddress,
  }) = AddContactError;
}
