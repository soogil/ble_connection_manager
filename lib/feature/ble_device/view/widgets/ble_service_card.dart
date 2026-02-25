import 'package:flutter/material.dart';

import '../../../../core/ble/ble_state.dart';
import 'ble_characteristic_tile.dart';

class BleServiceCard extends StatelessWidget {
  const BleServiceCard({
    super.key,
    required this.service,
    required this.charValues,
    required this.notifyingChars,
    required this.loadingOps,
    required this.onRead,
    required this.onWrite,
    required this.onToggleNotify,
  });

  final BleService service;
  final Map<String, List<int>> charValues;
  final Set<String> notifyingChars;
  final Set<String> loadingOps;
  final void Function(String charUuid) onRead;
  final void Function(String charUuid) onWrite;
  final void Function(String charUuid) onToggleNotify;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ExpansionTile(
        title: Text(service.displayName, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(service.uuid, style: Theme.of(context).textTheme.bodySmall),
        leading: Icon(
          service.isPrimary ? Icons.star : Icons.star_border,
          color: service.isPrimary ? Colors.amber : Colors.grey,
        ),
        children: service.characteristics.isEmpty
            ? [const Padding(padding: EdgeInsets.all(16), child: Text('No characteristics'))]
            : service.characteristics.map((char) {
                return BleCharacteristicTile(
                  characteristic: char,
                  value: charValues[char.uuid],
                  isNotifying: notifyingChars.contains(char.uuid),
                  isReadLoading: loadingOps.contains('read_${char.uuid}'),
                  isWriteLoading: loadingOps.contains('write_${char.uuid}'),
                  onRead: () => onRead(char.uuid),
                  onWrite: () => onWrite(char.uuid),
                  onToggleNotify: () => onToggleNotify(char.uuid),
                );
              }).toList(),
      ),
    );
  }
}
