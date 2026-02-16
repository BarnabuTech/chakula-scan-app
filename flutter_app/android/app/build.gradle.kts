plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin plugins.
    id("dev.flutter.flutter-gradle-plugin")
    // Apply the Google services plugin (version comes from root build.gradle.kts)
    id("com.google.gms.google-services")
}

android {
    namespace = "com.barsheba.chakulascanapp"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    // Kotlin options for Android
    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "com.barsheba.chakulascanapp"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

dependencies {
    // Firebase BoM
    implementation(platform("com.google.firebase:firebase-bom:34.5.0"))

    // Firebase libraries (no explicit versions when using BoM)
    implementation("com.google.firebase:firebase-analytics")
    implementation("com.google.firebase:firebase-auth")
    // add other firebase libraries as needed, e.g. firestore, storage (without versions)
}

flutter {
    source = "../.."
}





































// plugins {
//     id("com.android.application")
//     id("kotlin-android")
//     // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
//     id("dev.flutter.flutter-gradle-plugin")
//     // Add the Google services Gradle plugin
//     id("com.google.gms.google-services")   // version "4.4.4"
// }

// android {
//     namespace = "com.barsheba.chakulascanapp"
//     compileSdk = flutter.compileSdkVersion
//     ndkVersion = flutter.ndkVersion

//     compileOptions {
//         sourceCompatibility = JavaVersion.VERSION_17
//         targetCompatibility = JavaVersion.VERSION_17
//     }

//     kotlinOptions {
//         jvmTarget = JavaVersion.VERSION_17.toString()
//     }

//     defaultConfig {
//         // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
//         applicationId = "com.barsheba.chakulascanapp"
//         // You can update the following values to match your application needs.
//         // For more information, see: https://flutter.dev/to/review-gradle-config.
//         minSdk = flutter.minSdkVersion
//         targetSdk = flutter.targetSdkVersion
//         versionCode = flutter.versionCode
//         versionName = flutter.versionName
//     }

//     buildTypes {
//         release {
//             // TODO: Add your own signing config for the release build.
//             // Signing with the debug keys for now, so `flutter run --release` works.
//             signingConfig = signingConfigs.getByName("debug")
//         }
//     }
// }

// dependencies {
//     // Import the Firebase BoM
//     implementation(platform("com.google.firebase:firebase-bom:34.5.0"))

//     // TODO: Add the dependencies for Firebase products you want to use
//     // When using the BoM, don't specify versions in Firebase dependencies
//     implementation("com.google.firebase:firebase-analytics")

//     // Add the dependencies for any other desired Firebase products
//     // https://firebase.google.com/docs/android/setup#available-libraries
//     implementation("com.google.firebase:firebase-auth")
//     // implementation("com.google.firebase:firebase-firestore")
//     // implementation("com.google.firebase:firebase-storage")
// }

// flutter {
//     source = "../.."
// }
