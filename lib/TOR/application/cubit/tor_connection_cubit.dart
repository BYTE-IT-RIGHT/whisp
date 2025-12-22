import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:whisp/TOR/domain/i_tor_connection_monitor.dart';
import 'package:whisp/TOR/domain/tor_connection_state.dart';

@Injectable()
class TorConnectionCubit extends Cubit<TorConnectionStatus> {
  final ITorConnectionMonitor _connectionMonitor;
  StreamSubscription<TorConnectionStatus>? _subscription;

  TorConnectionCubit(this._connectionMonitor)
      : super(TorConnectionStatus.connecting);

  void init() {
    // Start monitoring
    _connectionMonitor.startMonitoring();

    // Emit current status
    emit(_connectionMonitor.currentStatus);

    // Listen to status changes
    _subscription = _connectionMonitor.connectionStatus.listen((status) {
      emit(status);
    });
  }

  /// Manually trigger a connectivity check
  Future<void> checkConnection() async {
    await _connectionMonitor.checkConnectivity();
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}

