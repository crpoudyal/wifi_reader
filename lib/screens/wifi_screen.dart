import 'package:flutter/material.dart';
import 'package:wifi_reader/models/wifi_info.dart';
import 'package:wifi_reader/services/wifi_services.dart';

class WifiScreen extends StatefulWidget {
  const WifiScreen({super.key});

  @override
  State<WifiScreen> createState() => _WifiScreenState();
}

class _WifiScreenState extends State<WifiScreen> {
  final WifiService _wifiService = WifiService();
  WifiInfo? wifiInfo;
  Future<void> _getWifiInfo() async {
    final result = await _wifiService.getWifiInfo();

    setState(() {
      wifiInfo = result;
    });
  }

  String signalQuality(int rssi) {
    if (rssi >= -50) return "Excellent";
    if (rssi >= -60) return "Good";
    if (rssi >= -70) return "Fair";
    return "Poor";
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Enabled : ${wifiInfo?.enabled}"),
                  Text("SSID : ${wifiInfo?.ssid}"),
                  Text("IP Address : ${wifiInfo?.ipAddress}"),
                  // Text("RSSI : ${wifiInfo?.rssi} dBm"),
                  Text(
                    "Signal : ${signalQuality(wifiInfo!.rssi)} (${wifiInfo?.rssi} dBm)",
                  ),
                  Text("Link Speed : ${wifiInfo?.linkSpeed} Mbps"),
                  Text("Frequency : ${wifiInfo?.frequency} MHz"),
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
