import 'package:flutter/material.dart';
import 'package:wifi_reader/services/wifi_services.dart';

class WifiScreen extends StatefulWidget {
  const WifiScreen({super.key});

  @override
  State<WifiScreen> createState() => _WifiScreenState();
}

class _WifiScreenState extends State<WifiScreen> {
  final WifiService _wifiService = WifiService();
  bool? wifiEnabled;

  String message = "Press the button";
  Map<dynamic, dynamic>? wifiInfo;
  // Future<void> _getWifiState() async {
  //   final result = await _wifiService.getWifiState();

  //   setState(() {
  //     wifiEnabled = result;
  //   });
  // }

  Future<void> _getWifiInfo() async {
    final result = await _wifiService.getWifiInfo();

    setState(() {
      wifiInfo = result;
    });
  }

  Future<void> _callAndroid() async {
    try {
      final result = await _wifiService.sayHello();

      setState(() {
        message = result;
      });
    } catch (e) {
      setState(() {
        message = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Method Channel Demo")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (wifiInfo == null)
              const Text("Press button")
            else
              Column(
                children: [
                  Text("Enabled : ${wifiInfo!['enabled']}"),
                  Text("SSID : ${wifiInfo!['ssid']}"),
                  Text("IP : ${wifiInfo!['ipAddress']}"),
                ],
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getWifiInfo,
              child: const Text("Load WiFi Info"),
            ),
          ],
        ),
      ),
    );
  }
}
