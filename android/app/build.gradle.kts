import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key-properties/release-key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

val debugKeystoreProperties = Properties()
val debugKeystorePropertiesFile = rootProject.file("key-properties/debug-key.properties")
if (debugKeystorePropertiesFile.exists()) {
    debugKeystoreProperties.load(FileInputStream(debugKeystorePropertiesFile))
}

val fossKeystoreProperties = Properties()
val fossKeystorePropertiesFile = rootProject.file("key-properties/foss-key.properties")
if (fossKeystorePropertiesFile.exists()) {
    fossKeystoreProperties.load(FileInputStream(fossKeystorePropertiesFile))
}

android {
    namespace = "pl.byteitright.whisp"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlin {
        compilerOptions {
            jvmTarget.set(org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17)
        }
    }

    defaultConfig {
        applicationId = "pl.byteitright.whisp"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        ndk {
            abiFilters += listOf("armeabi-v7a", "arm64-v8a", "x86", "x86_64")
        }
    }

    bundle {
        language {
            enableSplit = false
        }
        density {
            enableSplit = false
        }
        abi {
            enableSplit = false
        }
    }

    packaging {
        jniLibs {
            useLegacyPackaging = true
        }
    }

    signingConfigs {
        getByName("debug") {
            keyAlias = debugKeystoreProperties.getProperty("keyAlias")
            keyPassword = debugKeystoreProperties.getProperty("keyPassword")
            storeFile = debugKeystoreProperties.getProperty("storeFile")?.let { file(it) }
            storePassword = debugKeystoreProperties.getProperty("storePassword")
        }

        create("release") {
            keyAlias = keystoreProperties.getProperty("keyAlias")
            keyPassword = keystoreProperties.getProperty("keyPassword")
            storeFile = keystoreProperties.getProperty("storeFile")?.let { file(it) }
            storePassword = keystoreProperties.getProperty("storePassword")
        }

        create("foss") {
            keyAlias = fossKeystoreProperties.getProperty("keyAlias")
            keyPassword = fossKeystoreProperties.getProperty("keyPassword")
            storeFile = fossKeystoreProperties.getProperty("storeFile")?.let { file(it) }
            storePassword = fossKeystoreProperties.getProperty("storePassword")
        }
    }

    // Product flavors for different distribution channels
    flavorDimensions += "distribution"

    productFlavors {
        create("googleplay") {
            dimension = "distribution"
            // Google Play Store distribution
            // Uses release signing for production
            // Will include Google Pay for payments
            signingConfig = signingConfigs.getByName("release")
        }

        create("foss") {
            dimension = "distribution"
            // Free Open Source Software distribution (GitHub Releases)
            // Uses dedicated FOSS key for official releases & fingerprint verification
            applicationIdSuffix = ".foss"
            versionNameSuffix = "-foss"
            signingConfig = signingConfigs.getByName("foss")
        }
    }

    buildTypes {
        getByName("debug") {
            signingConfig = signingConfigs.getByName("debug")
        }

        getByName("release") {
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}
