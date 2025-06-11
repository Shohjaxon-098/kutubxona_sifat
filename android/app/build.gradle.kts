import java.util.Properties
import java.io.FileInputStream

val keystorePropertiesFile = project.rootProject.file("key.properties")
val keystoreProperties = Properties().apply {
    load(FileInputStream(keystorePropertiesFile))
}


plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.sdkha.kutubxona"
    compileSdk = 35
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "com.sdkha.kutubxona"
        minSdk = 21
        targetSdk = 34
        versionCode = 1
        versionName = "1.0"
    }

signingConfigs {
    create("release") {
        keyAlias = keystoreProperties["keyAlias"] as? String ?: throw GradleException("Missing keyAlias in key.properties")
        keyPassword = keystoreProperties["keyPassword"] as? String ?: throw GradleException("Missing keyPassword in key.properties")
        storeFile = keystoreProperties["storeFile"]?.let { file(it as String) } ?: throw GradleException("Missing storeFile in key.properties")
        storePassword = keystoreProperties["storePassword"] as? String ?: throw GradleException("Missing storePassword in key.properties")
    }
}


    buildTypes {
        getByName("release") {
            signingConfig = signingConfigs.getByName("release")
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
