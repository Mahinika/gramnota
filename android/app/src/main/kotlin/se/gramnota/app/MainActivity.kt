package se.gramnota.app

import android.content.ClipData
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.provider.Settings
import androidx.core.content.FileProvider
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "se.gramnota.app/updates",
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "installedBuild" -> {
                    try {
                        result.success(installedBuild())
                    } catch (error: Exception) {
                        result.error("build", error.message, null)
                    }
                }
                "canInstallPackages" -> result.success(canInstallPackages())
                "openInstallPermissionSettings" -> {
                    openInstallPermissionSettings()
                    result.success(null)
                }
                "installApk" -> {
                    val path = call.argument<String>("path")
                    if (path.isNullOrEmpty()) {
                        result.error("bad_path", "Missing APK path", null)
                    } else {
                        try {
                            installApk(path)
                            result.success(null)
                        } catch (error: Exception) {
                            result.error("install", error.message, null)
                        }
                    }
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun installedBuild(): Int {
        val info = packageManager.getPackageInfo(packageName, 0)
        val code =
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
                info.longVersionCode
            } else {
                @Suppress("DEPRECATION")
                info.versionCode.toLong()
            }
        return code.toInt()
    }

    private fun canInstallPackages(): Boolean {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.O) {
            return true
        }
        return packageManager.canRequestPackageInstalls()
    }

    private fun openInstallPermissionSettings() {
        val intent =
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                Intent(Settings.ACTION_MANAGE_UNKNOWN_APP_SOURCES).apply {
                    data = Uri.parse("package:$packageName")
                }
            } else {
                Intent(Settings.ACTION_SECURITY_SETTINGS)
            }
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        startActivity(intent)
    }

    private fun installApk(path: String) {
        val file = File(path)
        val uri =
            FileProvider.getUriForFile(
                this,
                "$packageName.fileprovider",
                file,
            )
        val intent =
            Intent(Intent.ACTION_VIEW).apply {
                setDataAndType(uri, "application/vnd.android.package-archive")
                addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION or Intent.FLAG_ACTIVITY_NEW_TASK)
                clipData = ClipData.newRawUri("apk", uri)
            }
        startActivity(intent)
    }
}
