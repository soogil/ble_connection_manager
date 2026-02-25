// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ble_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$BleDevice {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get rssi => throw _privateConstructorUsedError;
  bool get isConnectable => throw _privateConstructorUsedError;

  /// Create a copy of BleDevice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BleDeviceCopyWith<BleDevice> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BleDeviceCopyWith<$Res> {
  factory $BleDeviceCopyWith(BleDevice value, $Res Function(BleDevice) then) =
      _$BleDeviceCopyWithImpl<$Res, BleDevice>;
  @useResult
  $Res call({String id, String name, int rssi, bool isConnectable});
}

/// @nodoc
class _$BleDeviceCopyWithImpl<$Res, $Val extends BleDevice>
    implements $BleDeviceCopyWith<$Res> {
  _$BleDeviceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BleDevice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? rssi = null,
    Object? isConnectable = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            rssi:
                null == rssi
                    ? _value.rssi
                    : rssi // ignore: cast_nullable_to_non_nullable
                        as int,
            isConnectable:
                null == isConnectable
                    ? _value.isConnectable
                    : isConnectable // ignore: cast_nullable_to_non_nullable
                        as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BleDeviceImplCopyWith<$Res>
    implements $BleDeviceCopyWith<$Res> {
  factory _$$BleDeviceImplCopyWith(
    _$BleDeviceImpl value,
    $Res Function(_$BleDeviceImpl) then,
  ) = __$$BleDeviceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, int rssi, bool isConnectable});
}

/// @nodoc
class __$$BleDeviceImplCopyWithImpl<$Res>
    extends _$BleDeviceCopyWithImpl<$Res, _$BleDeviceImpl>
    implements _$$BleDeviceImplCopyWith<$Res> {
  __$$BleDeviceImplCopyWithImpl(
    _$BleDeviceImpl _value,
    $Res Function(_$BleDeviceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BleDevice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? rssi = null,
    Object? isConnectable = null,
  }) {
    return _then(
      _$BleDeviceImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        rssi:
            null == rssi
                ? _value.rssi
                : rssi // ignore: cast_nullable_to_non_nullable
                    as int,
        isConnectable:
            null == isConnectable
                ? _value.isConnectable
                : isConnectable // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc

class _$BleDeviceImpl extends _BleDevice {
  const _$BleDeviceImpl({
    required this.id,
    required this.name,
    required this.rssi,
    this.isConnectable = true,
  }) : super._();

  @override
  final String id;
  @override
  final String name;
  @override
  final int rssi;
  @override
  @JsonKey()
  final bool isConnectable;

  @override
  String toString() {
    return 'BleDevice(id: $id, name: $name, rssi: $rssi, isConnectable: $isConnectable)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BleDeviceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.rssi, rssi) || other.rssi == rssi) &&
            (identical(other.isConnectable, isConnectable) ||
                other.isConnectable == isConnectable));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, rssi, isConnectable);

  /// Create a copy of BleDevice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BleDeviceImplCopyWith<_$BleDeviceImpl> get copyWith =>
      __$$BleDeviceImplCopyWithImpl<_$BleDeviceImpl>(this, _$identity);
}

abstract class _BleDevice extends BleDevice {
  const factory _BleDevice({
    required final String id,
    required final String name,
    required final int rssi,
    final bool isConnectable,
  }) = _$BleDeviceImpl;
  const _BleDevice._() : super._();

  @override
  String get id;
  @override
  String get name;
  @override
  int get rssi;
  @override
  bool get isConnectable;

  /// Create a copy of BleDevice
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BleDeviceImplCopyWith<_$BleDeviceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$BleService {
  String get uuid => throw _privateConstructorUsedError;
  String get deviceId => throw _privateConstructorUsedError;
  bool get isPrimary => throw _privateConstructorUsedError;
  List<BleCharacteristic> get characteristics =>
      throw _privateConstructorUsedError;

  /// Create a copy of BleService
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BleServiceCopyWith<BleService> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BleServiceCopyWith<$Res> {
  factory $BleServiceCopyWith(
    BleService value,
    $Res Function(BleService) then,
  ) = _$BleServiceCopyWithImpl<$Res, BleService>;
  @useResult
  $Res call({
    String uuid,
    String deviceId,
    bool isPrimary,
    List<BleCharacteristic> characteristics,
  });
}

/// @nodoc
class _$BleServiceCopyWithImpl<$Res, $Val extends BleService>
    implements $BleServiceCopyWith<$Res> {
  _$BleServiceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BleService
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = null,
    Object? deviceId = null,
    Object? isPrimary = null,
    Object? characteristics = null,
  }) {
    return _then(
      _value.copyWith(
            uuid:
                null == uuid
                    ? _value.uuid
                    : uuid // ignore: cast_nullable_to_non_nullable
                        as String,
            deviceId:
                null == deviceId
                    ? _value.deviceId
                    : deviceId // ignore: cast_nullable_to_non_nullable
                        as String,
            isPrimary:
                null == isPrimary
                    ? _value.isPrimary
                    : isPrimary // ignore: cast_nullable_to_non_nullable
                        as bool,
            characteristics:
                null == characteristics
                    ? _value.characteristics
                    : characteristics // ignore: cast_nullable_to_non_nullable
                        as List<BleCharacteristic>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BleServiceImplCopyWith<$Res>
    implements $BleServiceCopyWith<$Res> {
  factory _$$BleServiceImplCopyWith(
    _$BleServiceImpl value,
    $Res Function(_$BleServiceImpl) then,
  ) = __$$BleServiceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String uuid,
    String deviceId,
    bool isPrimary,
    List<BleCharacteristic> characteristics,
  });
}

/// @nodoc
class __$$BleServiceImplCopyWithImpl<$Res>
    extends _$BleServiceCopyWithImpl<$Res, _$BleServiceImpl>
    implements _$$BleServiceImplCopyWith<$Res> {
  __$$BleServiceImplCopyWithImpl(
    _$BleServiceImpl _value,
    $Res Function(_$BleServiceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BleService
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = null,
    Object? deviceId = null,
    Object? isPrimary = null,
    Object? characteristics = null,
  }) {
    return _then(
      _$BleServiceImpl(
        uuid:
            null == uuid
                ? _value.uuid
                : uuid // ignore: cast_nullable_to_non_nullable
                    as String,
        deviceId:
            null == deviceId
                ? _value.deviceId
                : deviceId // ignore: cast_nullable_to_non_nullable
                    as String,
        isPrimary:
            null == isPrimary
                ? _value.isPrimary
                : isPrimary // ignore: cast_nullable_to_non_nullable
                    as bool,
        characteristics:
            null == characteristics
                ? _value._characteristics
                : characteristics // ignore: cast_nullable_to_non_nullable
                    as List<BleCharacteristic>,
      ),
    );
  }
}

/// @nodoc

class _$BleServiceImpl extends _BleService {
  const _$BleServiceImpl({
    required this.uuid,
    required this.deviceId,
    this.isPrimary = true,
    final List<BleCharacteristic> characteristics = const [],
  }) : _characteristics = characteristics,
       super._();

  @override
  final String uuid;
  @override
  final String deviceId;
  @override
  @JsonKey()
  final bool isPrimary;
  final List<BleCharacteristic> _characteristics;
  @override
  @JsonKey()
  List<BleCharacteristic> get characteristics {
    if (_characteristics is EqualUnmodifiableListView) return _characteristics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_characteristics);
  }

  @override
  String toString() {
    return 'BleService(uuid: $uuid, deviceId: $deviceId, isPrimary: $isPrimary, characteristics: $characteristics)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BleServiceImpl &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId) &&
            (identical(other.isPrimary, isPrimary) ||
                other.isPrimary == isPrimary) &&
            const DeepCollectionEquality().equals(
              other._characteristics,
              _characteristics,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    uuid,
    deviceId,
    isPrimary,
    const DeepCollectionEquality().hash(_characteristics),
  );

  /// Create a copy of BleService
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BleServiceImplCopyWith<_$BleServiceImpl> get copyWith =>
      __$$BleServiceImplCopyWithImpl<_$BleServiceImpl>(this, _$identity);
}

abstract class _BleService extends BleService {
  const factory _BleService({
    required final String uuid,
    required final String deviceId,
    final bool isPrimary,
    final List<BleCharacteristic> characteristics,
  }) = _$BleServiceImpl;
  const _BleService._() : super._();

  @override
  String get uuid;
  @override
  String get deviceId;
  @override
  bool get isPrimary;
  @override
  List<BleCharacteristic> get characteristics;

  /// Create a copy of BleService
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BleServiceImplCopyWith<_$BleServiceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$BleCharacteristic {
  String get uuid => throw _privateConstructorUsedError;
  String get serviceUuid => throw _privateConstructorUsedError;
  String get deviceId => throw _privateConstructorUsedError;
  bool get canRead => throw _privateConstructorUsedError;
  bool get canWrite => throw _privateConstructorUsedError;
  bool get canNotify => throw _privateConstructorUsedError;
  List<int> get value => throw _privateConstructorUsedError;
  bool get isNotifying => throw _privateConstructorUsedError;

  /// Create a copy of BleCharacteristic
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BleCharacteristicCopyWith<BleCharacteristic> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BleCharacteristicCopyWith<$Res> {
  factory $BleCharacteristicCopyWith(
    BleCharacteristic value,
    $Res Function(BleCharacteristic) then,
  ) = _$BleCharacteristicCopyWithImpl<$Res, BleCharacteristic>;
  @useResult
  $Res call({
    String uuid,
    String serviceUuid,
    String deviceId,
    bool canRead,
    bool canWrite,
    bool canNotify,
    List<int> value,
    bool isNotifying,
  });
}

/// @nodoc
class _$BleCharacteristicCopyWithImpl<$Res, $Val extends BleCharacteristic>
    implements $BleCharacteristicCopyWith<$Res> {
  _$BleCharacteristicCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BleCharacteristic
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = null,
    Object? serviceUuid = null,
    Object? deviceId = null,
    Object? canRead = null,
    Object? canWrite = null,
    Object? canNotify = null,
    Object? value = null,
    Object? isNotifying = null,
  }) {
    return _then(
      _value.copyWith(
            uuid:
                null == uuid
                    ? _value.uuid
                    : uuid // ignore: cast_nullable_to_non_nullable
                        as String,
            serviceUuid:
                null == serviceUuid
                    ? _value.serviceUuid
                    : serviceUuid // ignore: cast_nullable_to_non_nullable
                        as String,
            deviceId:
                null == deviceId
                    ? _value.deviceId
                    : deviceId // ignore: cast_nullable_to_non_nullable
                        as String,
            canRead:
                null == canRead
                    ? _value.canRead
                    : canRead // ignore: cast_nullable_to_non_nullable
                        as bool,
            canWrite:
                null == canWrite
                    ? _value.canWrite
                    : canWrite // ignore: cast_nullable_to_non_nullable
                        as bool,
            canNotify:
                null == canNotify
                    ? _value.canNotify
                    : canNotify // ignore: cast_nullable_to_non_nullable
                        as bool,
            value:
                null == value
                    ? _value.value
                    : value // ignore: cast_nullable_to_non_nullable
                        as List<int>,
            isNotifying:
                null == isNotifying
                    ? _value.isNotifying
                    : isNotifying // ignore: cast_nullable_to_non_nullable
                        as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BleCharacteristicImplCopyWith<$Res>
    implements $BleCharacteristicCopyWith<$Res> {
  factory _$$BleCharacteristicImplCopyWith(
    _$BleCharacteristicImpl value,
    $Res Function(_$BleCharacteristicImpl) then,
  ) = __$$BleCharacteristicImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String uuid,
    String serviceUuid,
    String deviceId,
    bool canRead,
    bool canWrite,
    bool canNotify,
    List<int> value,
    bool isNotifying,
  });
}

/// @nodoc
class __$$BleCharacteristicImplCopyWithImpl<$Res>
    extends _$BleCharacteristicCopyWithImpl<$Res, _$BleCharacteristicImpl>
    implements _$$BleCharacteristicImplCopyWith<$Res> {
  __$$BleCharacteristicImplCopyWithImpl(
    _$BleCharacteristicImpl _value,
    $Res Function(_$BleCharacteristicImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BleCharacteristic
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = null,
    Object? serviceUuid = null,
    Object? deviceId = null,
    Object? canRead = null,
    Object? canWrite = null,
    Object? canNotify = null,
    Object? value = null,
    Object? isNotifying = null,
  }) {
    return _then(
      _$BleCharacteristicImpl(
        uuid:
            null == uuid
                ? _value.uuid
                : uuid // ignore: cast_nullable_to_non_nullable
                    as String,
        serviceUuid:
            null == serviceUuid
                ? _value.serviceUuid
                : serviceUuid // ignore: cast_nullable_to_non_nullable
                    as String,
        deviceId:
            null == deviceId
                ? _value.deviceId
                : deviceId // ignore: cast_nullable_to_non_nullable
                    as String,
        canRead:
            null == canRead
                ? _value.canRead
                : canRead // ignore: cast_nullable_to_non_nullable
                    as bool,
        canWrite:
            null == canWrite
                ? _value.canWrite
                : canWrite // ignore: cast_nullable_to_non_nullable
                    as bool,
        canNotify:
            null == canNotify
                ? _value.canNotify
                : canNotify // ignore: cast_nullable_to_non_nullable
                    as bool,
        value:
            null == value
                ? _value._value
                : value // ignore: cast_nullable_to_non_nullable
                    as List<int>,
        isNotifying:
            null == isNotifying
                ? _value.isNotifying
                : isNotifying // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc

class _$BleCharacteristicImpl extends _BleCharacteristic {
  const _$BleCharacteristicImpl({
    required this.uuid,
    required this.serviceUuid,
    required this.deviceId,
    this.canRead = false,
    this.canWrite = false,
    this.canNotify = false,
    final List<int> value = const [],
    this.isNotifying = false,
  }) : _value = value,
       super._();

  @override
  final String uuid;
  @override
  final String serviceUuid;
  @override
  final String deviceId;
  @override
  @JsonKey()
  final bool canRead;
  @override
  @JsonKey()
  final bool canWrite;
  @override
  @JsonKey()
  final bool canNotify;
  final List<int> _value;
  @override
  @JsonKey()
  List<int> get value {
    if (_value is EqualUnmodifiableListView) return _value;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_value);
  }

  @override
  @JsonKey()
  final bool isNotifying;

  @override
  String toString() {
    return 'BleCharacteristic(uuid: $uuid, serviceUuid: $serviceUuid, deviceId: $deviceId, canRead: $canRead, canWrite: $canWrite, canNotify: $canNotify, value: $value, isNotifying: $isNotifying)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BleCharacteristicImpl &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.serviceUuid, serviceUuid) ||
                other.serviceUuid == serviceUuid) &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId) &&
            (identical(other.canRead, canRead) || other.canRead == canRead) &&
            (identical(other.canWrite, canWrite) ||
                other.canWrite == canWrite) &&
            (identical(other.canNotify, canNotify) ||
                other.canNotify == canNotify) &&
            const DeepCollectionEquality().equals(other._value, _value) &&
            (identical(other.isNotifying, isNotifying) ||
                other.isNotifying == isNotifying));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    uuid,
    serviceUuid,
    deviceId,
    canRead,
    canWrite,
    canNotify,
    const DeepCollectionEquality().hash(_value),
    isNotifying,
  );

  /// Create a copy of BleCharacteristic
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BleCharacteristicImplCopyWith<_$BleCharacteristicImpl> get copyWith =>
      __$$BleCharacteristicImplCopyWithImpl<_$BleCharacteristicImpl>(
        this,
        _$identity,
      );
}

abstract class _BleCharacteristic extends BleCharacteristic {
  const factory _BleCharacteristic({
    required final String uuid,
    required final String serviceUuid,
    required final String deviceId,
    final bool canRead,
    final bool canWrite,
    final bool canNotify,
    final List<int> value,
    final bool isNotifying,
  }) = _$BleCharacteristicImpl;
  const _BleCharacteristic._() : super._();

  @override
  String get uuid;
  @override
  String get serviceUuid;
  @override
  String get deviceId;
  @override
  bool get canRead;
  @override
  bool get canWrite;
  @override
  bool get canNotify;
  @override
  List<int> get value;
  @override
  bool get isNotifying;

  /// Create a copy of BleCharacteristic
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BleCharacteristicImplCopyWith<_$BleCharacteristicImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
