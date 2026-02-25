import 'package:freezed_annotation/freezed_annotation.dart';

part 'ble_state.freezed.dart';

/// Scanned BLE device
@freezed
class BleDevice with _$BleDevice {
  const factory BleDevice({
    required String id,
    required String name,
    required int rssi,
    @Default(true) bool isConnectable,
  }) = _BleDevice;

  const BleDevice._();

  String get displayName => name.isNotEmpty ? name : 'Unknown ($id)';
}

/// BLE service with characteristics
@freezed
class BleService with _$BleService {
  const factory BleService({
    required String uuid,
    required String deviceId,
    @Default(true) bool isPrimary,
    @Default([]) List<BleCharacteristic> characteristics,
  }) = _BleService;

  const BleService._();

  String get displayName => _knownServices[uuid.toUpperCase()] ?? uuid;

  static const _knownServices = {
    '1800': 'Generic Access',
    '1801': 'Generic Attribute',
    '180A': 'Device Information',
    '180D': 'Heart Rate',
    '180F': 'Battery Service',
  };
}

/// BLE characteristic
@freezed
class BleCharacteristic with _$BleCharacteristic {
  const factory BleCharacteristic({
    required String uuid,
    required String serviceUuid,
    required String deviceId,
    @Default(false) bool canRead,
    @Default(false) bool canWrite,
    @Default(false) bool canNotify,
    @Default([]) List<int> value,
    @Default(false) bool isNotifying,
  }) = _BleCharacteristic;

  const BleCharacteristic._();

  String get displayName => _knownCharacteristics[uuid.toUpperCase()] ?? uuid;

  String get valueAsHex => value.isEmpty
      ? '-'
      : value.map((b) => b.toRadixString(16).padLeft(2, '0').toUpperCase()).join(' ');

  static const _knownCharacteristics = {
    '2A00': 'Device Name',
    '2A19': 'Battery Level',
    '2A29': 'Manufacturer Name',
  };
}

/// Connection state
enum BleConnectionState {
  disconnected,
  connecting,
  connected,
}

/// Adapter state
enum BleAdapterState {
  unknown,
  on,
  off,
  unauthorized,
}
