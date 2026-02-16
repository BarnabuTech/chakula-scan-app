plugins {
    // Declare plugin versions centrally here (apply false so modules can apply without version)
    id("com.google.gms.google-services") version "4.3.15" apply false
    id("com.android.application") version "8.6.0" apply false  // It was version 8.2.2
    id("org.jetbrains.kotlin.android") version "2.1.0" apply false // It was version 1.9.22
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Fix Flutter build directory for compatibility (keeps your earlier adjustment)
val newBuildDir = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

// Standard clean task
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}










// plugins {
//     // Google Services plugin (version declared only here)
//     id("com.google.gms.google-services") version "4.3.15" apply false

//     // Android and Kotlin plugins
//     id("com.android.application") version "8.2.2" apply false
//     id("org.jetbrains.kotlin.android") version "1.9.22" apply false
// }

// allprojects {
//     repositories {
//         google()
//         mavenCentral()
//     }
// }

// // Fix Flutter build directory for compatibility
// val newBuildDir = rootProject.layout.buildDirectory.dir("../../build").get()
// rootProject.layout.buildDirectory.value(newBuildDir)

// subprojects {
//     val newSubprojectBuildDir = newBuildDir.dir(project.name)
//     project.layout.buildDirectory.value(newSubprojectBuildDir)
// }

// // Clean task
// tasks.register<Delete>("clean") {
//     delete(rootProject.layout.buildDirectory)
// }






// plugins {
//     // ...
//     // Add the dependency for the Google services Gradle plugin
//     id("com.google.gms.google-services") version "4.3.15" apply false
// }

// allprojects {
//     repositories {
//         google()
//         mavenCentral()
//     }
// }

// val newBuildDir: Directory =
//     rootProject.layout.buildDirectory
//         .dir("../../build")
//         .get()
// rootProject.layout.buildDirectory.value(newBuildDir)

// subprojects {
//     val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
//     project.layout.buildDirectory.value(newSubprojectBuildDir)
// }
// subprojects {
//     project.evaluationDependsOn(":app")
// }

// tasks.register<Delete>("clean") {
//     delete(rootProject.layout.buildDirectory)
// }
