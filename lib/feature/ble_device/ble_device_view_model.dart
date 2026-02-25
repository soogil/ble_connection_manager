import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/ble/ble_exceptions.dart';
import '../../core/ble/ble_manager.dart';
import '../../core/ble/ble_state.dart';

part 'ble_device_view_model.g.dart';

/// Device detail screen state
class BleDeviceState {
  const BleDeviceState({
    this.connectionState = BleConnectionState.disconnected,
    this.services = const [],
    this.characteristicValues = const {},
    this.notifyingChars = const {},
    this.loadingOps = const {},
    this.error,
  });

  final BleConnectionState connectionState;
  final List<BleService> services;
  final Map<String, List<int>> characteristicValues;
  final Set<String> notifyingChars;
  final Set<String> loadingOps;
  final String? error;

  bool get isConnected => connectionState == BleConnectionState.connected;

  BleDeviceState copyWith({
    BleConnectionState? connectionState,
    List<BleService>? services,
    Map<String, List<int>>? characteristicValues,
    Set<String>? notifyingChars,
    Set<String>? loadingOps,
    String? error,
  }) {
    return BleDeviceState(
      connectionState: connectionState ?? this.connectionState,
      services: services ?? this.services,
      characteristicValues: characteristicValues ?? this.characteristicValues,
      notifyingChars: notifyingChars ?? this.notifyingChars,
      loadingOps: loadingOps ?? this.loadingOps,
      error: error,
    );
  }
}

@riverpod
class BleDeviceViewModel extends _$BleDeviceViewModel {
  late final String _deviceId;
  StreamSubscription<BleConnectionState>? _connectionSub;
  final _notifySubs = <String, StreamSubscription<List<int>>>{};

  BleManager get _manager => ref.read(bleManagerProvider);

  @override
  BleDeviceState build(BleDevice device) {
    _deviceId = device.id;
    ref.onDispose(_dispose);
    _listenConnectionState();
    connect();
    return const BleDeviceState(connectionState: BleConnectionState.connecting);
  }

  void _listenConnectionState() {
    _connectionSub = _manager.connectionState(_deviceId).listen((connState) {
      state = state.copyWith(connectionState: connState);
      if (connState == BleConnectionState.disconnected) {
        _cancelAllNotifications();
        state = state.copyWith(services: [], characteristicValues: {});
      }
    });
  }

  Future<void> connect() async {
    state = state.copyWith(connectionState: BleConnectionState.connecting);
    try {
      await _manager.connect(_deviceId);
      await _discoverServices();
    } catch (e) {
      state = state.copyWith(
        connectionState: BleConnectionState.disconnected,
        error: e is BleException ? e.message : 'Connection failed',
      );
    }
  }

  Future<void> disconnect() async {
    try {
      _cancelAllNotifications();
      await _manager.disconnect(_deviceId);
    } catch (e) {
      state = state.copyWith(error: e is BleException ? e.message : 'Disconnect failed');
    }
  }

  Future<void> _discoverServices() async {
    _setLoading('discover', true);
    try {
      final services = await _manager.discoverServices(_deviceId);
      state = state.copyWith(services: services);
    } catch (e) {
      state = state.copyWith(error: e is BleException ? e.message : 'Service discovery failed');
    } finally {
      _setLoading('discover', false);
    }
  }

  Future<void> readCharacteristic(String serviceUuid, String charUuid) async {
    _setLoading('read_$charUuid', true);
    try {
      final value = await _manager.readCharacteristic(_deviceId, serviceUuid, charUuid);
      _updateCharValue(charUuid, value);
    } catch (e) {
      state = state.copyWith(error: e is BleException ? e.message : 'Read failed');
    } finally {
      _setLoading('read_$charUuid', false);
    }
  }

  Future<void> writeCharacteristic(String serviceUuid, String charUuid, List<int> value) async {
    _setLoading('write_$charUuid', true);
    try {
      await _manager.writeCharacteristic(_deviceId, serviceUuid, charUuid, value);
      await readCharacteristic(serviceUuid, charUuid);
    } catch (e) {
      state = state.copyWith(error: e is BleException ? e.message : 'Write failed');
    } finally {
      _setLoading('write_$charUuid', false);
    }
  }

  void toggleNotify(String serviceUuid, String charUuid) {
    final key = '$serviceUuid:$charUuid';
    final isNotifying = state.notifyingChars.contains(charUuid);

    if (isNotifying) {
      _notifySubs[key]?.cancel();
      _notifySubs.remove(key);
      _manager.unsubscribeCharacteristic(_deviceId, serviceUuid, charUuid);
      state = state.copyWith(notifyingChars: {...state.notifyingChars}..remove(charUuid));
    } else {
      final stream = _manager.subscribeCharacteristic(_deviceId, serviceUuid, charUuid);
      _notifySubs[key] = stream.listen(
        (value) => _updateCharValue(charUuid, value),
        onError: (e) {
          state = state.copyWith(
            notifyingChars: {...state.notifyingChars}..remove(charUuid),
            error: 'Notification error',
          );
        },
      );
      state = state.copyWith(notifyingChars: {...state.notifyingChars, charUuid});
    }
  }

  void _updateCharValue(String charUuid, List<int> value) {
    state = state.copyWith(characteristicValues: {...state.characteristicValues, charUuid: value});
  }

  void _setLoading(String opId, bool loading) {
    final ops = {...state.loadingOps};
    loading ? ops.add(opId) : ops.remove(opId);
    state = state.copyWith(loadingOps: ops);
  }

  void _cancelAllNotifications() {
    for (final sub in _notifySubs.values) {
      sub.cancel();
    }
    _notifySubs.clear();
    state = state.copyWith(notifyingChars: {});
  }

  void clearError() => state = state.copyWith(error: null);

  void _dispose() {
    _connectionSub?.cancel();
    _cancelAllNotifications();
    if (state.isConnected) _manager.disconnect(_deviceId);
  }
}
