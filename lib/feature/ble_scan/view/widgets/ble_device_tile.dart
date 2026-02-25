import 'package:flutter/material.dart';

import '../../../../core/ble/ble_state.dart';

class BleDeviceTile extends StatelessWidget {
  const BleDeviceTile({
    super.key,
    required this.device,
    required this.onTap,
  });

  final BleDevice device;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final signalColor = device.rssi >= -50
        ? Colors.green
        : device.rssi >= -70
            ? Colors.orange
            : Colors.red;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        onTap: device.isConnectable ? onTap : null,
        leading: Icon(
          Icons.bluetooth,
          color: device.isConnectable ? signalColor : Colors.grey,
          size: 32,
        ),
        title: Text(
          device.displayName,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: device.isConnectable ? null : Colors.grey,
          ),
        ),
        subtitle: Text(device.id, style: Theme.of(context).textTheme.bodySmall),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${device.rssi} dBm',
              style: TextStyle(color: signalColor, fontWeight: FontWeight.bold),
            ),
            if (device.isConnectable) ...[
              const SizedBox(width: 8),
              const Icon(Icons.chevron_right),
            ],
          ],
        ),
      ),
    );
  }
}
