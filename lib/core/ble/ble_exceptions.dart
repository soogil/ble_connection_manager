/// BLE-related exceptions for error handling.
sealed class BleException implements Exception {
  const BleException(this.message);
  final String message;

  @override
  String toString() => message;
}

class BluetoothOffException extends BleException {
  const BluetoothOffException() : super('Bluetooth is turned off');
}

class PermissionDeniedException extends BleException {
  const PermissionDeniedException() : super('Bluetooth permission denied');
}

class ConnectionException extends BleException {
  const ConnectionException([String? device])
      : super(device != null ? 'Failed to connect to $device' : 'Connection failed');
}

class DisconnectedException extends BleException {
  const DisconnectedException([String? device])
      : super(device != null ? '$device disconnected' : 'Device disconnected');
}

class ServiceNotFoundException extends BleException {
  const ServiceNotFoundException(String uuid) : super('Service $uuid not found');
}

class CharacteristicNotFoundException extends BleException {
  const CharacteristicNotFoundException(String uuid)
      : super('Characteristic $uuid not found');
}

class ReadException extends BleException {
  const ReadException([String? details]) : super(details ?? 'Read failed');
}

class WriteException extends BleException {
  const WriteException([String? details]) : super(details ?? 'Write failed');
}
