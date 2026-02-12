import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:whisp/common/domain/failure.dart';
import 'package:whisp/local_storage/domain/i_local_storage_repository.dart';
import 'package:whisp/mailbox/domain/i_mailbox_repository.dart';
import 'package:whisp/mailbox/domain/mailbox.dart';

part 'mailbox_state.dart';

@Injectable()
class MailboxCubit extends Cubit<MailboxState> {
  final IMailboxRepository _mailboxRepository;
  final ILocalStorageRepository _localStorageRepository;

  StreamSubscription<List<String>>? _mailboxSubscription;
  Timer? _pingTimer;
  final Map<String, bool> _onlineStatus = {};
  bool _shouldContinuePinging = false;

  MailboxCubit(this._mailboxRepository, this._localStorageRepository)
    : super(MailboxInitial());

  void init() {
    emit(MailboxLoading());

    _mailboxSubscription = _localStorageRepository
        .watchMailboxAddresses()
        .listen((addresses) async {
          final mailboxes = await Future.wait(
            addresses.map((address) async {
              final pin = await _localStorageRepository.getMailboxPin(address);
              return Mailbox(
                onionAddress: address,
                pin: pin ?? '',
                isOnline: _onlineStatus[address] ?? false,
              );
            }),
          );

          emit(MailboxLoaded(mailboxes: mailboxes));
        });

    _startPingLoop();
  }

  void _startPingLoop() {
    _shouldContinuePinging = true;
    _pingLoop();
  }

  void _stopPingLoop() {
    _shouldContinuePinging = false;
    _pingTimer?.cancel();
  }

  Future<void> _pingLoop() async {
    if (!_shouldContinuePinging) return;

    await _pingAllMailboxes();

    if (!_shouldContinuePinging) return;

    await Future.delayed(const Duration(seconds: 10));
    _pingLoop();
  }

  Future<void> _pingAllMailboxes() async {
    final addresses = _localStorageRepository.getMailboxAddresses();

    for (final address in addresses) {
      final result = await _mailboxRepository.pingMailbox(address);
      result.fold(
        (failure) => _onlineStatus[address] = false,
        (isOnline) => _onlineStatus[address] = isOnline,
      );
    }

    // Update state with new online statuses
    if (state is MailboxLoaded) {
      final currentState = state as MailboxLoaded;
      final updatedMailboxes = currentState.mailboxes
          .map(
            (mailbox) => mailbox.copyWith(
              isOnline: _onlineStatus[mailbox.onionAddress] ?? false,
            ),
          )
          .toList();
      emit(MailboxLoaded(mailboxes: updatedMailboxes));
    }
  }

  Future<void> addMailbox({
    required String onionAddress,
    required String pin,
  }) async {
    final result = await _mailboxRepository.addMailbox(
      onionAddress: onionAddress,
      pin: pin,
    );

    result.fold(
      (failure) => emit(MailboxAddError(failure, onionAddress: onionAddress)),
      (_) => emit(MailboxAddSuccess()),
    );
  }

  Future<void> removeMailbox(String onionAddress) async {
    await _localStorageRepository.removeMailbox(onionAddress);
    _onlineStatus.remove(onionAddress);
  }

  Future<void> refreshMailboxes() async {
    await _pingAllMailboxes();
  }

  @override
  Future<void> close() {
    _stopPingLoop();
    _mailboxSubscription?.cancel();
    return super.close();
  }
}
