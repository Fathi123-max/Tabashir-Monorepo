import java.io.File
import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    id("com.google.firebase.crashlytics")
    // END: FlutterFire Configuration
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

// Load keystore properties for release signing
val keystorePropertiesFile = rootProject.file("key.properties")
val keystoreProperties = if (keystorePropertiesFile.exists()) {
    val props = Properties()
    FileInputStream(keystorePropertiesFile).use { props.load(it) }
    props
} else {
    null
}

// Load version properties
val versionPropertiesFile = rootProject.file("version.properties")
val versionProperties = Properties()
if (versionPropertiesFile.exists()) {
    FileInputStream(versionPropertiesFile).use { versionProperties.load(it) }
}

android {
    namespace = "ae.tabashir"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "28.0.12433566"

    experimentalProperties["android.experiment.useElfAlignment"] = true

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "ae.tabashir"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion

        versionCode = versionProperties.getProperty("version.code")?.toInt() ?: flutter.versionCode
        versionName = versionProperties.getProperty("version.name") ?: flutter.versionName
    }

    signingConfigs {
        create("release") {
            if (keystoreProperties != null) {
                keyAlias = keystoreProperties.getProperty("keyAlias")
                keyPassword = keystoreProperties.getProperty("keyPassword")
                storeFile = file(keystoreProperties.getProperty("storeFile"))
                storePassword = keystoreProperties.getProperty("storePassword")
            }
        }
    }

    buildTypes {
        release {
            if (keystoreProperties != null) {
                signingConfig = signingConfigs.getByName("release")
            } else {
                // Fallback to debug signing if keystore not configured (dev only)
                signingConfig = signingConfigs.getByName("debug")
            }

            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }

    packaging {
        jniLibs {
            useLegacyPackaging = false
        }
        resources {
            excludes += "/remoteconfigs"
        }
    }

    // Force uncompressed native libs for 16 KB support
    @Suppress("DEPRECATION")
    packagingOptions {
        jniLibs {
            useLegacyPackaging = false
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.5")

    // Force 16 KB aligned version of Pdfium
    constraints {
        implementation("io.github.endigo:pdfiumandroid:1.0.33") {
            because("Previous versions are only 4 KB aligned")
        }
    }
}

// Toolchain aligned with JAVA_HOME
// kotlin { jvmToolchain(17) }
