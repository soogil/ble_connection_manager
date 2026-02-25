import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/ble/ble_state.dart';
import '../ble_device_view_model.dart';
import 'widgets/ble_service_card.dart';

class BleDevicePage extends HookConsumerWidget {
  const BleDevicePage({super.key, required this.device});

  final BleDevice device;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(bleDeviceViewModelProvider(device));
    final viewModel = ref.read(bleDeviceViewModelProvider(device).notifier);

    // error snackbar
    useEffect(() {
      if (state.error != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error!), backgroundColor: Colors.red),
          );
          viewModel.clearError();
        });
      }
      return null;
    }, [state.error]);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(device.displayName, style: const TextStyle(fontSize: 16)),
            Text(
              _connectionText(state.connectionState),
              style: TextStyle(fontSize: 12, color: _connectionColor(state.connectionState)),
            ),
          ],
        ),
        actions: [_buildConnectionButton(state.connectionState, viewModel)],
      ),
      body: _buildBody(context, state, viewModel),
    );
  }

  Widget _buildConnectionButton(BleConnectionState connState, BleDeviceViewModel viewModel) {
    return switch (connState) {
      BleConnectionState.disconnected => IconButton(
          icon: const Icon(Icons.bluetooth_connected),
          onPressed: viewModel.connect,
        ),
      BleConnectionState.connecting => const Padding(
          padding: EdgeInsets.all(16),
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
          ),
        ),
      BleConnectionState.connected => IconButton(
          icon: const Icon(Icons.bluetooth_disabled),
          onPressed: viewModel.disconnect,
        ),
    };
  }

  Widget _buildBody(BuildContext context, BleDeviceState state, BleDeviceViewModel viewModel) {
    return switch (state.connectionState) {
      BleConnectionState.disconnected => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.bluetooth_disabled, size: 64, color: Colors.grey),
              const SizedBox(height: 16),
              const Text('Disconnected', style: TextStyle(fontSize: 18, color: Colors.grey)),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: viewModel.connect,
                icon: const Icon(Icons.bluetooth_connected),
                label: const Text('Connect'),
              ),
            ],
          ),
        ),
      BleConnectionState.connecting => const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Connecting...', style: TextStyle(fontSize: 18, color: Colors.grey)),
            ],
          ),
        ),
      BleConnectionState.connected => state.services.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Discovering services...', style: TextStyle(fontSize: 18, color: Colors.grey)),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: state.services.length,
              itemBuilder: (context, index) {
                final service = state.services[index];
                return BleServiceCard(
                  service: service,
                  charValues: state.characteristicValues,
                  notifyingChars: state.notifyingChars,
                  loadingOps: state.loadingOps,
                  onRead: (charUuid) => viewModel.readCharacteristic(service.uuid, charUuid),
                  onWrite: (charUuid) => _showWriteDialog(context, service.uuid, charUuid, viewModel),
                  onToggleNotify: (charUuid) => viewModel.toggleNotify(service.uuid, charUuid),
                );
              },
            ),
    };
  }

  String _connectionText(BleConnectionState state) => switch (state) {
        BleConnectionState.disconnected => 'Disconnected',
        BleConnectionState.connecting => 'Connecting...',
        BleConnectionState.connected => 'Connected',
      };

  Color _connectionColor(BleConnectionState state) => switch (state) {
        BleConnectionState.disconnected => Colors.red.shade200,
        BleConnectionState.connecting => Colors.orange.shade200,
        BleConnectionState.connected => Colors.green.shade200,
      };

  void _showWriteDialog(
    BuildContext context,
    String serviceUuid,
    String charUuid,
    BleDeviceViewModel viewModel,
  ) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Write Value'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: '01 02 03 FF',
            helperText: 'Hex values separated by spaces',
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              final bytes = _parseHex(controller.text);
              if (bytes != null) {
                viewModel.writeCharacteristic(serviceUuid, charUuid, bytes);
                Navigator.pop(ctx);
              }
            },
            child: const Text('Write'),
          ),
        ],
      ),
    );
  }

  List<int>? _parseHex(String hex) {
    try {
      return hex.split(RegExp(r'\s+')).where((p) => p.isNotEmpty).map((p) => int.parse(p, radix: 16)).toList();
    } catch (_) {
      return null;
    }
  }
}
