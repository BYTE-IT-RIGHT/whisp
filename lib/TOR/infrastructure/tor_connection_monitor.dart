import 'dart:async';
import 'dart:developer';

import 'package:injectable/injectable.dart';
import 'package:whisp/TOR/domain/i_tor_connection_monitor.dart';
import 'package:whisp/TOR/domain/i_tor_repository.dart';
import 'package:whisp/TOR/domain/tor_connection_state.dart';
import 'package:whisp/foreground_task/domain/i_foreground_task_service.dart';

@LazySingleton(as: ITorConnectionMonitor)
class TorConnectionMonitor implements ITorConnectionMonitor {
  final ITorRepository _torRepository;
  final IForegroundTaskService _foregroundTaskService;

  final StreamController<TorConnectionStatus> _statusController =
      StreamController<TorConnectionStatus>.broadcast();

  Timer? _healthCheckTimer;
  bool _isChecking = false;

  TorConnectionStatus _currentStatus = TorConnectionStatus.connecting;

  /// How often to check when connected
  static const Duration _connectedCheckInterval = Duration(seconds: 15);

  /// How often to check when disconnected (more frequent to detect recovery)
  static const Duration _disconnectedCheckInterval = Duration(seconds: 5);

  TorConnectionMonitor(this._torRepository, this._foregroundTaskService);

  @override
  Stream<TorConnectionStatus> get connectionStatus => _statusController.stream;

  @override
  TorConnectionStatus get currentStatus => _currentStatus;

  @override
  void startMonitoring() {
    log('TorConnectionMonitor: Starting monitoring');

    // If Tor is already initialized, assume connected initially
    if (_torRepository.isInitialized) {
      _updateStatus(TorConnectionStatus.connected);
    }

    // Brief delay before first health check to let Tor circuits stabilize
    _healthCheckTimer = Timer(const Duration(seconds: 5), () {
      _performHealthCheck();
      _scheduleNextCheck();
    });
  }

  @override
  void stopMonitoring() {
    log('TorConnectionMonitor: Stopping monitoring');
    _healthCheckTimer?.cancel();
    _healthCheckTimer = null;
  }

  void _scheduleNextCheck() {
    _healthCheckTimer?.cancel();

    // Use shorter interval when disconnected to detect recovery faster
    final interval = _currentStatus == TorConnectionStatus.connected
        ? _connectedCheckInterval
        : _disconnectedCheckInterval;

    _healthCheckTimer = Timer(interval, () {
      _performHealthCheck();
      _scheduleNextCheck();
    });
  }

  Future<void> _performHealthCheck() async {
    if (_isChecking) return;
    _isChecking = true;

    try {
      // Check if Tor is initialized
      if (!_torRepository.isInitialized) {
        log('TorConnectionMonitor: Tor not initialized');
        _handleFailure();
        return;
      }

      // Check Tor connectivity via external onion service
      final result = await _torRepository.checkTorConnectivity();

      result.fold(
        (failure) {
          log('TorConnectionMonitor: Health check failed');
          _handleFailure();
        },
        (_) {
          log('TorConnectionMonitor: Health check passed');
          _handleSuccess();
        },
      );
    } catch (e) {
      log('TorConnectionMonitor: Health check error - $e');
      _handleFailure();
    } finally {
      _isChecking = false;
    }
  }

  void _handleSuccess() {
    if (_currentStatus != TorConnectionStatus.connected) {
      _updateStatus(TorConnectionStatus.connected);
      // Reschedule with connected interval
      _scheduleNextCheck();
    }
  }

  void _handleFailure() {
    // Show disconnected immediately on first failure
    if (_currentStatus != TorConnectionStatus.disconnected) {
      _updateStatus(TorConnectionStatus.disconnected);
      // Reschedule with disconnected interval (faster checks)
      _scheduleNextCheck();
    }
  }

  @override
  Future<bool> checkConnectivity() async {
    log('TorConnectionMonitor: Manual connectivity check requested');

    if (!_torRepository.isInitialized) {
      _updateStatus(TorConnectionStatus.disconnected);
      return false;
    }

    final result = await _torRepository.checkTorConnectivity();
    final isConnected = result.isRight();

    if (isConnected) {
      _handleSuccess();
    } else {
      _handleFailure();
    }

    return isConnected;
  }

  void _updateStatus(TorConnectionStatus newStatus) {
    if (_currentStatus != newStatus) {
      log('TorConnectionMonitor: Status changed from $_currentStatus to $newStatus');
      _currentStatus = newStatus;
      _statusController.add(newStatus);

      // Update foreground notification
      _updateForegroundNotification(newStatus);
    }
  }

  Future<void> _updateForegroundNotification(TorConnectionStatus status) async {
    final isRunning = await _foregroundTaskService.isRunning();
    if (!isRunning) return;

    switch (status) {
      case TorConnectionStatus.connected:
        await _foregroundTaskService.updateNotification(
          title: 'Whisp is Connected',
          body: 'You are online and connected to Tor network',
        );
      case TorConnectionStatus.connecting:
        await _foregroundTaskService.updateNotification(
          title: 'Whisp is Connecting...',
          body: 'Establishing connection to Tor network',
        );
      case TorConnectionStatus.disconnected:
      case TorConnectionStatus.circuitFailed:
        await _foregroundTaskService.updateNotification(
          title: 'Whisp is Offline',
          body: 'Tor connection interrupted. Trying to reconnect...',
        );
    }
  }

  @override
  void dispose() {
    stopMonitoring();
    _statusController.close();
    log('TorConnectionMonitor: Disposed');
  }
}
