import 'package:freezed_annotation/freezed_annotation.dart';

part 'mailbox.freezed.dart';

@freezed
abstract class Mailbox with _$Mailbox {
  const Mailbox._();
  const factory Mailbox({
    required String onionAddress,
    required String pin,
    required bool isOnline,
  }) = _Mailbox;
}
