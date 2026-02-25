import 'dart:async';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'ble_exceptions.dart';
import 'ble_state.dart';

part 'ble_manager.g.dart';

/// Single source of truth for all BLE operations.
/// This is the ONLY class that directly uses flutter_blue_plus.
@Riverpod(keepAlive: true)
BleManager bleManager(Ref ref) => BleManager();

class BleManager {
  final _connectedDevices = <String, BluetoothDevice>{};
  final _discoveredServices = <String, List<BluetoothService>>{};

  // ==================== Adapter State ====================

  Stream<BleAdapterState> get adapterState =>
      FlutterBluePlus.adapterState.map(_mapAdapterState);

  Future<BleAdapterState> getAdapterState() async {
    final state = await FlutterBluePlus.adapterState.first;
    return _mapAdapterState(state);
  }

  BleAdapterState _mapAdapterState(BluetoothAdapterState state) {
    return switch (state) {
      BluetoothAdapterState.on => BleAdapterState.on,
      BluetoothAdapterState.off => BleAdapterState.off,
      BluetoothAdapterState.unauthorized => BleAdapterState.unauthorized,
      _ => BleAdapterState.unknown,
    };
  }

  // ==================== Scanning ====================

  bool get isScanning => FlutterBluePlus.isScanningNow;

  Stream<List<BleDevice>> scanDevices({Duration timeout = const Duration(seconds: 10)}) {
    final controller = StreamController<List<BleDevice>>();
    final devices = <String, BleDevice>{};

    final subscription = FlutterBluePlus.scanResults.listen(
      (results) {
        for (final r in results) {
          devices[r.device.remoteId.str] = BleDevice(
            id: r.device.remoteId.str,
            name: r.device.platformName,
            rssi: r.rssi,
            isConnectable: r.advertisementData.connectable,
          );
        }
        controller.add(devices.values.toList()..sort((a, b) => b.rssi.compareTo(a.rssi)));
      },
      onError: (e) => controller.addError(_mapException(e)),
    );

    FlutterBluePlus.startScan(timeout: timeout).catchError((e) {
      controller.addError(_mapException(e));
    });

    FlutterBluePlus.isScanning.listen((scanning) {
      if (!scanning && !controller.isClosed) controller.close();
    });

    controller.onCancel = () {
      subscription.cancel();
      FlutterBluePlus.stopScan();
    };

    return controller.stream;
  }

  Future<void> stopScan() => FlutterBluePlus.stopScan();

  // ==================== Connection ====================

  Future<void> connect(String deviceId) async {
    try {
      final device = BluetoothDevice.fromId(deviceId);
      await device.connect(timeout: const Duration(seconds: 15));
      _connectedDevices[deviceId] = device;
    } catch (e) {
      throw _mapException(e);
    }
  }

  Future<void> disconnect(String deviceId) async {
    try {
      final device = _connectedDevices[deviceId] ?? BluetoothDevice.fromId(deviceId);
      await device.disconnect();
      _connectedDevices.remove(deviceId);
      _discoveredServices.remove(deviceId);
    } catch (e) {
      throw _mapException(e);
    }
  }

  Stream<BleConnectionState> connectionState(String deviceId) {
    final device = _connectedDevices[deviceId] ?? BluetoothDevice.fromId(deviceId);
    return device.connectionState.map((s) => switch (s) {
          BluetoothConnectionState.connected => BleConnectionState.connected,
          BluetoothConnectionState.disconnected => BleConnectionState.disconnected,
          _ => BleConnectionState.connecting,
        });
  }

  // ==================== Services & Characteristics ====================

  Future<List<BleService>> discoverServices(String deviceId) async {
    try {
      final device = _connectedDevices[deviceId] ?? BluetoothDevice.fromId(deviceId);
      final services = await device.discoverServices();
      _discoveredServices[deviceId] = services;

      return services.map((s) => BleService(
        uuid: s.uuid.str,
        deviceId: deviceId,
        isPrimary: s.isPrimary,
        characteristics: s.characteristics.map((c) => BleCharacteristic(
          uuid: c.uuid.str,
          serviceUuid: s.uuid.str,
          deviceId: deviceId,
          canRead: c.properties.read,
          canWrite: c.properties.write || c.properties.writeWithoutResponse,
          canNotify: c.properties.notify || c.properties.indicate,
          isNotifying: c.isNotifying,
        )).toList(),
      )).toList();
    } catch (e) {
      throw _mapException(e);
    }
  }

  Future<List<int>> readCharacteristic(String deviceId, String serviceUuid, String charUuid) async {
    try {
      final char = _findCharacteristic(deviceId, serviceUuid, charUuid);
      return await char.read();
    } catch (e) {
      if (e is BleException) rethrow;
      throw _mapException(e);
    }
  }

  Future<void> writeCharacteristic(
    String deviceId,
    String serviceUuid,
    String charUuid,
    List<int> value, {
    bool withoutResponse = false,
  }) async {
    try {
      final char = _findCharacteristic(deviceId, serviceUuid, charUuid);
      await char.write(value, withoutResponse: withoutResponse);
    } catch (e) {
      if (e is BleException) rethrow;
      throw _mapException(e);
    }
  }

  Stream<List<int>> subscribeCharacteristic(String deviceId, String serviceUuid, String charUuid) {
    final char = _findCharacteristic(deviceId, serviceUuid, charUuid);
    char.setNotifyValue(true);
    return char.onValueReceived;
  }

  Future<void> unsubscribeCharacteristic(String deviceId, String serviceUuid, String charUuid) async {
    try {
      final char = _findCharacteristic(deviceId, serviceUuid, charUuid);
      await char.setNotifyValue(false);
    } catch (e) {
      if (e is BleException) rethrow;
      throw _mapException(e);
    }
  }

  BluetoothCharacteristic _findCharacteristic(String deviceId, String serviceUuid, String charUuid) {
    final services = _discoveredServices[deviceId];
    if (services == null) throw ServiceNotFoundException(serviceUuid);

    for (final service in services) {
      if (service.uuid.str.toLowerCase() == serviceUuid.toLowerCase()) {
        for (final char in service.characteristics) {
          if (char.uuid.str.toLowerCase() == charUuid.toLowerCase()) {
            return char;
          }
        }
        throw CharacteristicNotFoundException(charUuid);
      }
    }
    throw ServiceNotFoundException(serviceUuid);
  }

  BleException _mapException(dynamic e) {
    if (e is BleException) return e;
    final msg = e.toString().toLowerCase();
    if (msg.contains('bluetooth') && msg.contains('off')) return const BluetoothOffException();
    if (msg.contains('permission')) return const PermissionDeniedException();
    if (msg.contains('connect')) return const ConnectionException();
    if (msg.contains('disconnect')) return const DisconnectedException();
    return ReadException(e.toString());
  }
}
