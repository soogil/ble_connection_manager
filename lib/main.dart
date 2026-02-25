import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'feature/ble_scan/view/ble_scan_page.dart';

void main() {
  runApp(const ProviderScope(child: BleConnectionManagerApp()));
}

class BleConnectionManagerApp extends StatelessWidget {
  const BleConnectionManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BLE Connection Manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const BleScanPage(),
    );
  }
}
