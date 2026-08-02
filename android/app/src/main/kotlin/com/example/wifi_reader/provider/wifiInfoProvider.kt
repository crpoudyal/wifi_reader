package com.example.wifi_reader.provider

import android.content.Context
import android.net.ConnectivityManager
import android.net.wifi.WifiInfo
import android.net.wifi.WifiManager
import android.os.Build
import java.net.InetAddress
import java.nio.ByteBuffer
import java.nio.ByteOrder

object WifiInfoProvider {

    fun getWifiInfo(context: Context): Map<String, Any?> {
        val appContext = context.applicationContext
        val wifiManager = appContext.getSystemService(Context.WIFI_SERVICE) as WifiManager
        val connectivityManager =
                appContext.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager

        // API 31+ approach to fetch current active WifiInfo synchronously
        val info: WifiInfo? =
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
                    val activeNetwork = connectivityManager.activeNetwork
                    val capabilities = connectivityManager.getNetworkCapabilities(activeNetwork)
                    capabilities?.transportInfo as? WifiInfo
                } else {
                    @Suppress("DEPRECATION") wifiManager.connectionInfo
                }

        return hashMapOf(
                "enabled" to wifiManager.isWifiEnabled,
                "ssid" to info?.ssid,
                "ipAddress" to intToIp(info?.ipAddress ?: 0),
                "rssi" to info?.rssi,
                "linkSpeed" to info?.linkSpeed,
                "frequency" to info?.frequency
        )
    }

    private fun intToIp(ip: Int): String {
        if (ip == 0) return "0.0.0.0"
        return try {
            val bytes = ByteBuffer.allocate(4).order(ByteOrder.LITTLE_ENDIAN).putInt(ip).array()
            InetAddress.getByAddress(bytes).hostAddress ?: "Unknown"
        } catch (e: Exception) {
            "Unknown"
        }
    }
}
