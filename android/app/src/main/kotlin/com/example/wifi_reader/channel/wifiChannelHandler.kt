package com.example.wifi_reader.channel

import android.content.Context
import com.example.wifi_reader.provider.WifiInfoProvider
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class WifiChannelHandler(private val context: Context) : MethodChannel.MethodCallHandler {

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "hello" -> {
                result.success("Hello from Android")
            }
            "getWifiInfo" -> {
                // Now safely passing the class-level context
                result.success(WifiInfoProvider.getWifiInfo(context))
            }
            else -> {
                result.notImplemented()
            }
        }
    }
}
