import 'package:flutter_test/flutter_test.dart';

import 'package:ble_connection_manager/core/ble/ble_state.dart';

void main() {
  group('BleDevice', () {
    test('displayName returns name when available', () {
      const device = BleDevice(id: '00:11:22:33:44:55', name: 'MyDevice', rssi: -50);
      expect(device.displayName, 'MyDevice');
    });

    test('displayName returns id when name is empty', () {
      const device = BleDevice(id: '00:11:22:33:44:55', name: '', rssi: -50);
      expect(device.displayName, 'Unknown (00:11:22:33:44:55)');
    });
  });

  group('BleCharacteristic', () {
    test('valueAsHex formats bytes correctly', () {
      const char = BleCharacteristic(
        uuid: '2A00',
        serviceUuid: '1800',
        deviceId: '00:11:22:33:44:55',
        value: [0x01, 0x0A, 0xFF],
      );
      expect(char.valueAsHex, '01 0A FF');
    });

    test('valueAsHex returns dash when empty', () {
      const char = BleCharacteristic(
        uuid: '2A00',
        serviceUuid: '1800',
        deviceId: '00:11:22:33:44:55',
      );
      expect(char.valueAsHex, '-');
    });
  });
}
