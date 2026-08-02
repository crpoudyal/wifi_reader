package com.example.wifi_reader

import android.content.Context
import android.net.wifi.WifiManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val CHANNEL = "wifi_channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call,
                result ->
            when (call.method) {
                "hello" -> {
                    result.success("Hello from Android")
                }
                "getWifiState" -> {
                    val wifiManager =
                            applicationContext.getSystemService(Context.WIFI_SERVICE) as WifiManager

                    result.success(wifiManager.isWifiEnabled)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }
}
