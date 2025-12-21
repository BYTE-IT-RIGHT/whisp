import 'dart:async';

import 'package:whisp/TOR/domain/i_tor_repository.dart';
import 'package:whisp/common/domain/failure.dart';
import 'package:whisp/local_storage/domain/i_local_storage_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'app_startup_state.dart';

@Injectable()
class AppStartupCubit extends Cubit<AppStartupState> {
  final ILocalStorageRepository _localStorageRepository;
  final ITorRepository _torRepository;

  StreamSubscription<String>? _logSubscription;

  AppStartupCubit(this._localStorageRepository, this._torRepository)
    : super(
        AppStartupLoading(progress: 0, statusMessage: 'Initializing TOR...'),
      ) {
    _init();
  }

  Future<void> _init() async {
    _logSubscription = _torRepository.torLogs.listen(_handleTorLog);

    emit(AppStartupLoading(progress: 0, statusMessage: 'Starting Tor...'));

    final torResult = await _torRepository.init();

    await _logSubscription?.cancel();

    torResult.fold(
      (failure) => emit(AppStartupError(failure, 'Failed to start Tor')),
      (_) async {
        final onionResult = await _torRepository.getOnionAddress();

        onionResult.fold(
          (failure) =>
              emit(AppStartupError(failure, 'Failed to get onion address')),
          (onionAddress) {
            final userResult = _localStorageRepository.getUser();
            if (userResult != null) {
              // User exists - check if tutorial is completed
              final tutorialCompleted = _localStorageRepository.isTutorialCompleted();
              if (tutorialCompleted) {
                emit(AppStartupAuthenticated(onionAddress));
              } else {
                emit(AppStartupTutorialPending(onionAddress));
              }
            } else {
              emit(AppStartupUnauthenticated(onionAddress));
            }
          },
        );
      },
    );
  }

  void _handleTorLog(String log) {
    final progress = _parseBootstrapProgress(log);
    final statusMessage = _parseStatusMessage(log);
    final currentState = state;
    if (currentState is AppStartupLoading) {
      emit(
        currentState.copyWith(
          progress: progress ?? currentState.progress,
          statusMessage: _cleanTorLog(
            statusMessage ?? currentState.statusMessage,
          ),
        ),
      );
    }
  }

  String _cleanTorLog(String line) {
    final regex = RegExp(
      r'^[A-Z][a-z]{2}\s+\d{1,2}\s+\d{2}:\d{2}:\d{2}\.\d{3}\s+\[[a-zA-Z]+\]\s+',
    );
    return line.replaceFirst(regex, '');
  }

  double? _parseBootstrapProgress(String log) {
    final regex = RegExp(r'Bootstrapped (\d+)%');
    final match = regex.firstMatch(log);
    if (match != null) {
      final percentage = int.tryParse(match.group(1) ?? '0') ?? 0;
      return percentage / 100.0;
    }
    return null;
  }

  String? _parseStatusMessage(String log) {
    final regex = RegExp(r'Bootstrapped \d+% \([^)]+\): (.+)');
    final match = regex.firstMatch(log);
    if (match != null) {
      return match.group(1);
    }

    if (log.contains('.onion')) {
      return 'Hidden service created!';
    } else {
      return '$log...';
    }
  }

  @override
  Future<void> close() {
    _logSubscription?.cancel();
    return super.close();
  }
}
