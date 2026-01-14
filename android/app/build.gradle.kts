import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// Load signing configs from properties files (if they exist)
val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key-properties/release-key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

val fossKeystoreProperties = Properties()
val fossKeystorePropertiesFile = rootProject.file("key-properties/foss-key.properties")
if (fossKeystorePropertiesFile.exists()) {
    fossKeystoreProperties.load(FileInputStream(fossKeystorePropertiesFile))
}

val fossPublicKeystoreProperties = Properties()
val fossPublicKeystorePropertiesFile = rootProject.file("key-properties/foss-public-key.properties")
if (fossPublicKeystorePropertiesFile.exists()) {
    fossPublicKeystoreProperties.load(FileInputStream(fossPublicKeystorePropertiesFile))
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
        // Debug uses Android's default debug.keystore (no config needed)

        create("release") {
            keyAlias = keystoreProperties.getProperty("keyAlias")
            keyPassword = keystoreProperties.getProperty("keyPassword")
            storeFile = keystoreProperties.getProperty("storeFile")?.let { file(it) }
            storePassword = keystoreProperties.getProperty("storePassword")
        }

        create("foss") {
            // FOSS key - PRIVATE, for official releases with crypto payments
            keyAlias = fossKeystoreProperties.getProperty("keyAlias")
            keyPassword = fossKeystoreProperties.getProperty("keyPassword")
            storeFile = fossKeystoreProperties.getProperty("storeFile")?.let { file(it) }
            storePassword = fossKeystoreProperties.getProperty("storePassword")
        }

        create("fossPublic") {
            // FOSS public key - PUBLIC (in repo), for developers to build & verify
            keyAlias = fossPublicKeystoreProperties.getProperty("keyAlias")
            keyPassword = fossPublicKeystoreProperties.getProperty("keyPassword")
            storeFile = fossPublicKeystoreProperties.getProperty("storeFile")?.let { file(it) }
            storePassword = fossPublicKeystoreProperties.getProperty("storePassword")
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
            // Official FOSS distribution (website/GitHub Releases)
            // Uses PRIVATE foss key, includes crypto payment gateway
            applicationIdSuffix = ".foss"
            versionNameSuffix = "-foss"
            signingConfig = signingConfigs.getByName("foss")
        }

        create("fosspublic") {
            dimension = "distribution"
            // Developer/contributor builds
            // Uses PUBLIC key (in repo) - anyone can build & verify
            // Crypto payments will NOT work (expected)
            applicationIdSuffix = ".foss"
            versionNameSuffix = "-foss-dev"
            signingConfig = signingConfigs.getByName("fossPublic")
        }
    }

    buildTypes {
        getByName("debug") {
            // Uses Android's default debug signing (no config needed)
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
