import 'package:flutter/services.dart';

class WifiService {
  static const MethodChannel _channel = MethodChannel('wifi_channel');

  Future<String> sayHello() async {
    return await _channel.invokeMethod('hello');
  }

  Future<bool> getWifiState() async {
    final bool enabled = await _channel.invokeMethod('getWifiState');
    return enabled;
  }
}
