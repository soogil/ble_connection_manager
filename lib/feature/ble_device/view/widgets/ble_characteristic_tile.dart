import 'package:flutter/material.dart';

import '../../../../core/ble/ble_state.dart';

class BleCharacteristicTile extends StatelessWidget {
  const BleCharacteristicTile({
    super.key,
    required this.characteristic,
    this.value,
    this.isNotifying = false,
    this.isReadLoading = false,
    this.isWriteLoading = false,
    required this.onRead,
    required this.onWrite,
    required this.onToggleNotify,
  });

  final BleCharacteristic characteristic;
  final List<int>? value;
  final bool isNotifying;
  final bool isReadLoading;
  final bool isWriteLoading;
  final VoidCallback onRead;
  final VoidCallback onWrite;
  final VoidCallback onToggleNotify;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey.shade200))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(characteristic.displayName, style: const TextStyle(fontWeight: FontWeight.w500)),
                    Text(characteristic.uuid, style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
              _buildPropertyBadges(),
            ],
          ),
          if (value != null) ...[
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('HEX: ${_formatHex(value!)}', style: const TextStyle(fontFamily: 'monospace', fontSize: 12)),
                  Text('ASCII: ${_formatAscii(value!)}', style: const TextStyle(fontFamily: 'monospace', fontSize: 12)),
                ],
              ),
            ),
          ],
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (characteristic.canRead) _actionButton(Icons.download, 'Read', onRead, isReadLoading),
              if (characteristic.canWrite) _actionButton(Icons.upload, 'Write', onWrite, isWriteLoading),
              if (characteristic.canNotify)
                TextButton.icon(
                  onPressed: onToggleNotify,
                  icon: Icon(
                    isNotifying ? Icons.notifications_active : Icons.notifications_off,
                    size: 16,
                    color: isNotifying ? Colors.orange : null,
                  ),
                  label: Text(isNotifying ? 'Stop' : 'Notify'),
                  style: TextButton.styleFrom(foregroundColor: isNotifying ? Colors.orange : null),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyBadges() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (characteristic.canRead) _badge('R', Colors.blue),
        if (characteristic.canWrite) _badge('W', Colors.green),
        if (characteristic.canNotify) _badge('N', Colors.orange),
      ],
    );
  }

  Widget _badge(String label, Color color) {
    return Container(
      margin: const EdgeInsets.only(left: 4),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(label, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }

  Widget _actionButton(IconData icon, String label, VoidCallback onPressed, bool isLoading) {
    return TextButton.icon(
      onPressed: isLoading ? null : onPressed,
      icon: isLoading
          ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
          : Icon(icon, size: 16),
      label: Text(label),
    );
  }

  String _formatHex(List<int> bytes) =>
      bytes.isEmpty ? '-' : bytes.map((b) => b.toRadixString(16).padLeft(2, '0').toUpperCase()).join(' ');

  String _formatAscii(List<int> bytes) {
    if (bytes.isEmpty) return '-';
    try {
      return String.fromCharCodes(bytes.where((b) => b >= 32 && b < 127));
    } catch (_) {
      return '-';
    }
  }
}
