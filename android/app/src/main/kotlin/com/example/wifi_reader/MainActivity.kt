package com.example.wifi_reader

import android.content.Context
import android.net.wifi.WifiManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.net.InetAddress
import java.nio.ByteBuffer
import java.nio.ByteOrder

class MainActivity : FlutterActivity() {

    private val CHANNEL = "wifi_channel"

    private fun intToIp(ip: Int): String {
        val bytes = ByteBuffer.allocate(4).order(ByteOrder.LITTLE_ENDIAN).putInt(ip).array()

        return InetAddress.getByAddress(bytes).hostAddress ?: "Unknown"
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call,
                result ->
            when (call.method) {
                "hello" -> {
                    result.success("Hello from Android")
                }
                "getWifiInfo" -> {

                    val wifiManager =
                            applicationContext.getSystemService(Context.WIFI_SERVICE) as WifiManager

                    val info = wifiManager.connectionInfo

                    val map =
                            hashMapOf<String, Any?>(
                                    "enabled" to wifiManager.isWifiEnabled,
                                    "ssid" to info.ssid,
                                    "ipAddress" to intToIp(info.ipAddress),
                                    "rssi" to info.rssi,
                                    "linkSpeed" to info.linkSpeed,
                                    "frequency" to info.frequency
                            )

                    result.success(map)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }
}
