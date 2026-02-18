pluginManagement {
    // Locate Flutter SDK from local.properties and include the flutter_tools build for the plugin
    val flutterSdkPath =
        run {
            val properties = java.util.Properties()
            file("local.properties").inputStream().use { properties.load(it) }
            val flutterSdkPath = properties.getProperty("flutter.sdk")
            require(flutterSdkPath != null) { "flutter.sdk not set in local.properties" }
            flutterSdkPath
        }

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

// IMPORTANT: do NOT redeclare plugin versions here — they are centrally declared in android/build.gradle.kts
rootProject.name = "android"
include(":app")





// pluginManagement {
//     val flutterSdkPath =
//         run {
//             val properties = java.util.Properties()
//             file("local.properties").inputStream().use { properties.load(it) }
//             val flutterSdkPath = properties.getProperty("flutter.sdk")
//             require(flutterSdkPath != null) { "flutter.sdk not set in local.properties" }
//             flutterSdkPath
//         }

//     includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

//     repositories {
//         google()
//         mavenCentral()
//         gradlePluginPortal()
//     }
// }

// plugins {
//     id("dev.flutter.flutter-plugin-loader") version "1.0.0"
//     id("com.android.application") version "8.11.1" apply false
    // START: FlutterFire Configuration
    id("com.google.gms.google-services") version("4.3.15") apply false
    // END: FlutterFire Configuration
//     // START: FlutterFire Configuration
//     id("com.google.gms.google-services") version("4.3.15") apply false
//     // END: FlutterFire Configuration
//     id("org.jetbrains.kotlin.android") version "2.2.20" apply false
// }

// include(":app")
