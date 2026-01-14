/// Application distribution flavor configuration.
///
/// This class provides compile-time constants to differentiate between
/// Google Play and FOSS (Free Open Source Software) builds.
///
/// Usage:
/// ```bash
/// # Google Play build
/// flutter build appbundle --flavor googleplay --release --dart-define=APP_FLAVOR=googleplay
///
/// # FOSS build (for F-Droid, GitHub releases, manual APK distribution)
/// flutter build apk --flavor foss --release --dart-define=APP_FLAVOR=foss
/// ```
abstract final class AppFlavor {
  /// Current flavor from compile-time dart-define.
  /// Defaults to 'googleplay' if not specified.
  static const String current = String.fromEnvironment(
    'APP_FLAVOR',
    defaultValue: 'googleplay',
  );

  /// Whether this is a Google Play Store build.
  static const bool isGooglePlay = current == 'googleplay';

  /// Whether this is a FOSS (Free Open Source Software) build.
  /// Used for F-Droid, GitHub releases, and manual APK distribution.
  static const bool isFoss = current == 'foss';
}

