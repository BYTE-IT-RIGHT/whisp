import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:whisp/common/domain/failure.dart';
import 'package:whisp/local_storage/domain/i_local_storage_repository.dart';
import 'package:whisp/mailbox/domain/i_mailbox_repository.dart';
import 'package:whisp/mailbox/domain/mailbox.dart';

part 'mailbox_state.dart';
part 'mailbox_cubit.freezed.dart';

@Injectable()
class MailboxCubit extends Cubit<MailboxState> {
  final IMailboxRepository _mailboxRepository;
  final ILocalStorageRepository _localStorageRepository;

  Timer? _pingTimer;
  final Map<String, bool> _onlineStatus = {};
  bool _shouldContinuePinging = false;

  MailboxCubit(this._mailboxRepository, this._localStorageRepository)
    : super(const MailboxInitial());

  void init() {
    emit(const MailboxLoading());
    _loadMailbox();
    _startPingLoop();
  }

  Future<void> _loadMailbox() async {
    final address = _localStorageRepository.getMailboxAddress();
    if (address == null || address.isEmpty) {
      emit(const MailboxState.loaded(mailboxes: []));
      return;
    }

    final pin = await _localStorageRepository.getMailboxPin();
    emit(
      MailboxState.loaded(
        mailboxes: [
          Mailbox(
            onionAddress: address,
            pin: pin ?? '',
            isOnline: _onlineStatus[address] ?? false,
          ),
        ],
      ),
    );
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
    final address = _localStorageRepository.getMailboxAddress();
    if (address == null || address.isEmpty) {
      emit(const MailboxState.loaded(mailboxes: []));
      return;
    }

    final result = await _mailboxRepository.pingMailbox(address);
    result.fold(
      (failure) => _onlineStatus[address] = false,
      (isOnline) => _onlineStatus[address] = isOnline,
    );

    // Update state with new online statuses
    state.maybeMap(
      loaded: (currentState) {
        final updatedMailboxes = currentState.mailboxes
            .map(
              (mailbox) => mailbox.copyWith(
                isOnline: _onlineStatus[mailbox.onionAddress] ?? false,
              ),
            )
            .toList();
        emit(MailboxState.loaded(mailboxes: updatedMailboxes));
      },
      orElse: () {},
    );
  }

  Future<void> addMailbox({
    required String onionAddress,
    required String pin,
  }) async {
    final result = await _mailboxRepository.addMailbox(
      onionAddress: onionAddress,
      pin: pin,
    );

    if (result.isLeft()) {
      final failure = result.fold((l) => l, (_) => UnexpectedError());
      emit(MailboxState.addError(failure, onionAddress: onionAddress));
      return;
    }

    await _loadMailbox();
    emit(const MailboxState.addSuccess());
  }

  Future<void> removeMailbox(String onionAddress) async {
    await _localStorageRepository.removeMailbox();
    _onlineStatus.remove(onionAddress);
    await _loadMailbox();
  }

  Future<void> refreshMailboxes() async {
    await _pingAllMailboxes();
  }

  @override
  Future<void> close() {
    _stopPingLoop();
    return super.close();
  }
}
