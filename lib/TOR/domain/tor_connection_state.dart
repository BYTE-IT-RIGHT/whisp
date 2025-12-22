/// Represents the current state of the Tor network connection
enum TorConnectionStatus {
  /// Successfully connected to Tor network
  connected,

  /// Currently establishing connection to Tor network
  connecting,

  /// Disconnected from Tor network
  disconnected,

  /// Failed to build Tor circuits
  circuitFailed,
}

