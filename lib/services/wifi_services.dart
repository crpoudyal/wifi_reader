import 'package:flutter/services.dart';

class WifiService {
  static const MethodChannel _channel = MethodChannel('wifi_channel');

  Future<String> sayHello() async {
    final String result = await _channel.invokeMethod('hello');
    return result;
  }
}
