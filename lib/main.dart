import 'package:flutter/material.dart';
import 'screens/wifi_screen.dart';

void main() {
  runApp(const WifiApp());
}

class WifiApp extends StatelessWidget {
  const WifiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WiFi Method Channel',
      theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),
      home: const WifiScreen(),
    );
  }
}
