import 'package:whisp/TOR/domain/tor_connection_state.dart';

/// Interface for monitoring Tor network connection status
abstract class ITorConnectionMonitor {
  /// Stream of connection status updates
  Stream<TorConnectionStatus> get connectionStatus;

  /// Current connection status
  TorConnectionStatus get currentStatus;

  /// Start monitoring the connection
  void startMonitoring();

  /// Stop monitoring the connection
  void stopMonitoring();

  /// Manually trigger a connectivity check
  Future<bool> checkConnectivity();

  /// Dispose resources
  void dispose();
}

