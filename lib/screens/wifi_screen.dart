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
  bool isLoading = false;

  static const _bg = Color(0xFF0B0F14);
  static const _surface = Color(0xFF12181F);
  static const _surfaceAlt = Color(0xFF171F28);
  static const _border = Color(0xFF223040);
  static const _accent = Color(0xFF00E5A8);
  static const _textPrimary = Color(0xFFE6EDF3);
  static const _textSecondary = Color(0xFF7C8A99);

  Future<void> _getWifiInfo() async {
    setState(() => isLoading = true);
    final result = await _wifiService.getWifiInfo();
    if (!mounted) return;
    setState(() {
      wifiInfo = result;
      isLoading = false;
    });
  }

  String signalQuality(int rssi) {
    if (rssi >= -50) return "Excellent";
    if (rssi >= -60) return "Good";
    if (rssi >= -70) return "Fair";
    return "Poor";
  }

  Color _signalColor(int rssi) {
    if (rssi >= -50) return const Color(0xFF00E5A8);
    if (rssi >= -60) return const Color(0xFF7CE562);
    if (rssi >= -70) return const Color(0xFFF5C542);
    return const Color(0xFFF5544D);
  }

  int _signalBars(int rssi) {
    if (rssi >= -50) return 4;
    if (rssi >= -60) return 3;
    if (rssi >= -70) return 2;
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        elevation: 0,
        centerTitle: false,
        title: Row(
          children: const [
            Icon(Icons.wifi_rounded, color: _accent, size: 22),
            SizedBox(width: 10),
            Text(
              "WIFI READER",
              style: TextStyle(
                color: _textPrimary,
                fontWeight: FontWeight.w700,
                fontSize: 16,
                letterSpacing: 1.4,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
          child: Column(
            children: [
              Expanded(
                child: wifiInfo == null
                    ? _EmptyState(isLoading: isLoading)
                    : SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _SignalHero(
                              ssid: wifiInfo!.ssid,
                              enabled: wifiInfo!.enabled,
                              quality: signalQuality(wifiInfo!.rssi),
                              rssi: wifiInfo!.rssi,
                              color: _signalColor(wifiInfo!.rssi),
                              bars: _signalBars(wifiInfo!.rssi),
                              surface: _surface,
                              border: _border,
                              textPrimary: _textPrimary,
                              textSecondary: _textSecondary,
                            ),
                            const SizedBox(height: 16),
                            GridView.count(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisCount: 2,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                              childAspectRatio: 1.35,
                              children: [
                                _StatTile(
                                  icon: Icons.dns_rounded,
                                  label: "IP ADDRESS",
                                  value: wifiInfo!.ipAddress,
                                  surface: _surfaceAlt,
                                  border: _border,
                                  accent: _accent,
                                  textPrimary: _textPrimary,
                                  textSecondary: _textSecondary,
                                ),
                                _StatTile(
                                  icon: Icons.speed_rounded,
                                  label: "LINK SPEED",
                                  value: "${wifiInfo!.linkSpeed} Mbps",
                                  surface: _surfaceAlt,
                                  border: _border,
                                  accent: _accent,
                                  textPrimary: _textPrimary,
                                  textSecondary: _textSecondary,
                                ),
                                _StatTile(
                                  icon: Icons.graphic_eq_rounded,
                                  label: "FREQUENCY",
                                  value: "${wifiInfo!.frequency} MHz",
                                  surface: _surfaceAlt,
                                  border: _border,
                                  accent: _accent,
                                  textPrimary: _textPrimary,
                                  textSecondary: _textSecondary,
                                ),
                                _StatTile(
                                  icon: Icons.podcasts_rounded,
                                  label: "SIGNAL (RSSI)",
                                  value: "${wifiInfo!.rssi} dBm",
                                  surface: _surfaceAlt,
                                  border: _border,
                                  accent: _signalColor(wifiInfo!.rssi),
                                  textPrimary: _textPrimary,
                                  textSecondary: _textSecondary,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _getWifiInfo,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _accent,
                    foregroundColor: const Color(0xFF06110D),
                    disabledBackgroundColor: _accent.withValues(alpha: 0.4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  child: isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.2,
                            color: Color(0xFF06110D),
                          ),
                        )
                      : const Text(
                          "SCAN WIFI",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.1,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final bool isLoading;
  const _EmptyState({required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF12181F),
              border: Border.all(color: const Color(0xFF223040)),
            ),
            child: Icon(
              isLoading ? Icons.wifi_find_rounded : Icons.wifi_off_rounded,
              color: const Color(0xFF7C8A99),
              size: 36,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            isLoading ? "Scanning network..." : "No data yet",
            style: const TextStyle(
              color: Color(0xFFE6EDF3),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            "Tap Scan WiFi to read connection info",
            style: TextStyle(color: Color(0xFF7C8A99), fontSize: 13),
          ),
        ],
      ),
    );
  }
}

class _SignalHero extends StatelessWidget {
  final String ssid;
  final bool enabled;
  final String quality;
  final int rssi;
  final int bars;
  final Color color;
  final Color surface;
  final Color border;
  final Color textPrimary;
  final Color textSecondary;

  const _SignalHero({
    required this.ssid,
    required this.enabled,
    required this.quality,
    required this.rssi,
    required this.bars,
    required this.color,
    required this.surface,
    required this.border,
    required this.textPrimary,
    required this.textSecondary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: border),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: enabled
                            ? const Color(0xFF00E5A8)
                            : const Color(0xFFF5544D),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      enabled ? "CONNECTED" : "DISABLED",
                      style: TextStyle(
                        color: textSecondary,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  ssid,
                  style: TextStyle(
                    color: textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  "$quality · $rssi dBm",
                  style: TextStyle(
                    color: color,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          _SignalBars(bars: bars, color: color),
        ],
      ),
    );
  }
}

class _SignalBars extends StatelessWidget {
  final int bars;
  final Color color;
  const _SignalBars({required this.bars, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(4, (i) {
        final active = i < bars;
        return Container(
          margin: const EdgeInsets.only(left: 4),
          width: 8,
          height: 14.0 + (i * 8),
          decoration: BoxDecoration(
            color: active ? color : color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(3),
          ),
        );
      }),
    );
  }
}

class _StatTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color surface;
  final Color border;
  final Color accent;
  final Color textPrimary;
  final Color textSecondary;

  const _StatTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.surface,
    required this.border,
    required this.accent,
    required this.textPrimary,
    required this.textSecondary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: accent, size: 20),
          const Spacer(),
          Text(
            label,
            style: TextStyle(
              color: textSecondary,
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: textPrimary,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
