import 'package:flutter/services.dart';
import 'package:wifi_reader/models/wifi_info.dart';

class WifiService {
  static const MethodChannel _channel = MethodChannel('wifi_channel');

  Future<String> sayHello() async {
    return await _channel.invokeMethod('hello');
  }

  Future<WifiInfo> getWifiInfo() async {
    final result = await _channel.invokeMethod('getWifiInfo');

    return WifiInfo.fromMap(Map<dynamic, dynamic>.from(result));
  }
}
