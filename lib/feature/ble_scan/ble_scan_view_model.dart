import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/ble/ble_exceptions.dart';
import '../../core/ble/ble_manager.dart';
import '../../core/ble/ble_state.dart';

part 'ble_scan_view_model.g.dart';

/// Scan screen state
class BleScanState {
  const BleScanState({
    this.devices = const [],
    this.isScanning = false,
    this.error,
  });

  final List<BleDevice> devices;
  final bool isScanning;
  final String? error;

  BleScanState copyWith({
    List<BleDevice>? devices,
    bool? isScanning,
    String? error,
  }) {
    return BleScanState(
      devices: devices ?? this.devices,
      isScanning: isScanning ?? this.isScanning,
      error: error,
    );
  }
}

@riverpod
class BleScanViewModel extends _$BleScanViewModel {
  StreamSubscription<List<BleDevice>>? _scanSubscription;
  StreamSubscription<BleAdapterState>? _adapterSubscription;

  BleManager get _manager => ref.read(bleManagerProvider);

  @override
  BleScanState build() {
    ref.onDispose(_dispose);
    _listenAdapterState();
    return const BleScanState();
  }

  void _listenAdapterState() {
    _adapterSubscription = _manager.adapterState.listen((adapterState) {
      if (adapterState == BleAdapterState.off) {
        stopScan();
        state = state.copyWith(error: 'Bluetooth is turned off');
      }
    });
  }

  void startScan() {
    if (state.isScanning) return;

    state = const BleScanState(isScanning: true);

    _scanSubscription = _manager.scanDevices().listen(
      (devices) => state = state.copyWith(devices: devices),
      onError: (e) {
        state = state.copyWith(
          isScanning: false,
          error: e is BleException ? e.message : 'Scan failed',
        );
      },
      onDone: () => state = state.copyWith(isScanning: false),
    );
  }

  void stopScan() {
    _scanSubscription?.cancel();
    _scanSubscription = null;
    _manager.stopScan();
    state = state.copyWith(isScanning: false);
  }

  void clearError() => state = state.copyWith(error: null);

  void _dispose() {
    _scanSubscription?.cancel();
    _adapterSubscription?.cancel();
    _manager.stopScan();
  }
}
