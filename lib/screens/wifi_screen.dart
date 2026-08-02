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
  Future<void> _getWifiState() async {
    final result = await _wifiService.getWifiState();

    setState(() {
      wifiEnabled = result;
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
            Text(
              wifiEnabled == null
                  ? "Press the button"
                  : wifiEnabled!
                  ? "WiFi is ON"
                  : "WiFi is OFF",
              style: const TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getWifiState,
              child: const Text("Check WiFi"),
            ),
          ],
        ),
      ),
    );
  }
}
