// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ble_device_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$bleDeviceViewModelHash() =>
    r'87af6a2f856c51254bfd62118a0d8a2f5ccd1ddb';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$BleDeviceViewModel
    extends BuildlessAutoDisposeNotifier<BleDeviceState> {
  late final BleDevice device;

  BleDeviceState build(BleDevice device);
}

/// See also [BleDeviceViewModel].
@ProviderFor(BleDeviceViewModel)
const bleDeviceViewModelProvider = BleDeviceViewModelFamily();

/// See also [BleDeviceViewModel].
class BleDeviceViewModelFamily extends Family<BleDeviceState> {
  /// See also [BleDeviceViewModel].
  const BleDeviceViewModelFamily();

  /// See also [BleDeviceViewModel].
  BleDeviceViewModelProvider call(BleDevice device) {
    return BleDeviceViewModelProvider(device);
  }

  @override
  BleDeviceViewModelProvider getProviderOverride(
    covariant BleDeviceViewModelProvider provider,
  ) {
    return call(provider.device);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'bleDeviceViewModelProvider';
}

/// See also [BleDeviceViewModel].
class BleDeviceViewModelProvider
    extends
        AutoDisposeNotifierProviderImpl<BleDeviceViewModel, BleDeviceState> {
  /// See also [BleDeviceViewModel].
  BleDeviceViewModelProvider(BleDevice device)
    : this._internal(
        () => BleDeviceViewModel()..device = device,
        from: bleDeviceViewModelProvider,
        name: r'bleDeviceViewModelProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$bleDeviceViewModelHash,
        dependencies: BleDeviceViewModelFamily._dependencies,
        allTransitiveDependencies:
            BleDeviceViewModelFamily._allTransitiveDependencies,
        device: device,
      );

  BleDeviceViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.device,
  }) : super.internal();

  final BleDevice device;

  @override
  BleDeviceState runNotifierBuild(covariant BleDeviceViewModel notifier) {
    return notifier.build(device);
  }

  @override
  Override overrideWith(BleDeviceViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: BleDeviceViewModelProvider._internal(
        () => create()..device = device,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        device: device,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<BleDeviceViewModel, BleDeviceState>
  createElement() {
    return _BleDeviceViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BleDeviceViewModelProvider && other.device == device;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, device.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin BleDeviceViewModelRef on AutoDisposeNotifierProviderRef<BleDeviceState> {
  /// The parameter `device` of this provider.
  BleDevice get device;
}

class _BleDeviceViewModelProviderElement
    extends
        AutoDisposeNotifierProviderElement<BleDeviceViewModel, BleDeviceState>
    with BleDeviceViewModelRef {
  _BleDeviceViewModelProviderElement(super.provider);

  @override
  BleDevice get device => (origin as BleDeviceViewModelProvider).device;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
