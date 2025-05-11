import org.gradle.api.tasks.Delete
import org.gradle.api.Project
import org.gradle.api.file.Directory

// 👉 Pluginlar uchun repository va versiyalar
buildscript {
    repositories {
        google()
        mavenCentral()
    }

    dependencies {
        classpath("com.android.tools.build:gradle:8.1.2")
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:1.9.10")
    }
}

// 👉 SDK versiyalarini global e'lon qilish
ext["compileSdkVersion"] = 33
ext["minSdkVersion"] = 21
ext["targetSdkVersion"] = 33

// 👉 Repositoriyalarni e'lon qilish
allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// 👉 build/ joylashuvini o‘zgartirish
val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

// 👉 Clean task
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
