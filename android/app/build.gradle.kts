import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("com.google.gms.google-services") // Firebase / Google Services
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

// 🔹 Load keystore properties safely
val keystorePropertiesFile = rootProject.file("key.properties")
val keystoreProperties = Properties()
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

android {
    // ⚠️ Update with your final package name
    namespace = "com.example.quick_home"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = "11"
    }

    defaultConfig {
        // ⚠️ applicationId must match Play Store & Firebase package name
        applicationId = "com.example.quick_home"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = 1
        versionName = "1"
    }
     
    signingConfigs {
        create("release") {
            // Load only if key.properties file exists
            if (keystorePropertiesFile.exists()) {
                keyAlias = keystoreProperties["keyAlias"] as String?
                keyPassword = keystoreProperties["keyPassword"] as String?
                    val storeFilePath = keystoreProperties["storeFile"] as String? ?: "upload-keystore.jks"
                if (!storeFilePath.isNullOrEmpty()) {
                    storeFile = file(storeFilePath)
                }
                storePassword = keystoreProperties["storePassword"] as String?
            }
        }
    }

    buildTypes {
        getByName("release") {
            // Only sign if release keystore is present
            val releaseSigning = signingConfigs.findByName("release")
            if (keystorePropertiesFile.exists() && releaseSigning?.storeFile != null) {
                signingConfig = releaseSigning
            }
            isMinifyEnabled = false
            isShrinkResources = false
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }

        getByName("debug") {
            // Use the default debug signing provided by the Android Gradle plugin.
            // Do not force the release keystore for debug builds (causes password errors).
        }
    }
}

flutter {
    source = "../.."
}

// ✅ Required for Java 8+ APIs on old devices
dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.5")
}
