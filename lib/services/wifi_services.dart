import 'package:flutter/services.dart';

class WifiService {
  static const MethodChannel _channel = MethodChannel('wifi_channel');

  Future<String> sayHello() async {
    return await _channel.invokeMethod('hello');
  }

  Future<Map<dynamic, dynamic>> getWifiInfo() async {
    final result = await _channel.invokeMethod('getWifiInfo');
    return Map<dynamic, dynamic>.from(result);
  }
}
