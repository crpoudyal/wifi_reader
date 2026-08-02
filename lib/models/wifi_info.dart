class WifiInfo {
  final bool enabled;
  final String ssid;
  final String ipAddress;
  final int rssi;
  final int linkSpeed;
  final int frequency;

  const WifiInfo({
    required this.enabled,
    required this.ssid,
    required this.ipAddress,
    required this.rssi,
    required this.linkSpeed,
    required this.frequency,
  });

  factory WifiInfo.fromMap(Map<dynamic, dynamic> map) {
    return WifiInfo(
      enabled: map["enabled"] ?? false,
      ssid: map["ssid"] ?? "",
      ipAddress: map["ipAddress"] ?? "",
      rssi: map["rssi"] ?? 0,
      linkSpeed: map["linkSpeed"] ?? 0,
      frequency: map["frequency"] ?? 0,
    );
  }
}
