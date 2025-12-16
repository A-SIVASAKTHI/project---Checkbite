plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")   // Correct Kotlin plugin
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.food_scanner"
    compileSdk = flutter.compileSdkVersion

    // IMPORTANT: Use highest NDK version as required by your plugins
    ndkVersion = "28.2.13676358"

    defaultConfig {
        applicationId = "com.example.food_scanner"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = "11"
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

dependencies {
    // Firebase BoM (manages all Firebase versions automatically)
    implementation(platform("com.google.firebase:firebase-bom:32.2.2"))

    // Firebase Auth
    implementation("com.google.firebase:firebase-auth-ktx")

    // Add other plugins you use:
    // implementation("androidx.camera:camera-core:<version>")
    // implementation("org.tensorflow:tensorflow-lite:<version>")
}

flutter {
    source = "../.."
}
