# Keep Tor native libraries
-keep class **.tor.** { *; }
-keep class **.TorHiddenService** { *; }

# Keep native method names
-keepclasseswithmembernames class * {
    native <methods>;
}

# Keep JNI-related classes
-keepclasseswithmembers class * {
    native <methods>;
}

# Keep all native libraries
-keep class * {
    native <methods>;
}

# Keep Flutter plugin classes
-keep class io.flutter.plugins.** { *; }
-keep class io.flutter.embedding.** { *; }

# Keep Tor plugin classes
-keep class com.**.tor_hidden_service.** { *; }

# Don't obfuscate native method names
-keepclasseswithmembernames,includedescriptorclasses class * {
    native <methods>;
}

# Suppress warnings for Google Play Core classes (not needed since we disabled ABI splitting)
-dontwarn com.google.android.play.core.splitcompat.SplitCompatApplication
-dontwarn com.google.android.play.core.splitinstall.SplitInstallException
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManager
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManagerFactory
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest$Builder
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest
-dontwarn com.google.android.play.core.splitinstall.SplitInstallSessionState
-dontwarn com.google.android.play.core.splitinstall.SplitInstallStateUpdatedListener
-dontwarn com.google.android.play.core.tasks.OnFailureListener
-dontwarn com.google.android.play.core.tasks.OnSuccessListener
-dontwarn com.google.android.play.core.tasks.Task

