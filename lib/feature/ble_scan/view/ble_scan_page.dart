import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/ble/ble_state.dart';
import '../../ble_device/view/ble_device_page.dart';
import '../ble_scan_view_model.dart';
import 'widgets/ble_device_tile.dart';

class BleScanPage extends HookConsumerWidget {
  const BleScanPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(bleScanViewModelProvider);
    final viewModel = ref.read(bleScanViewModelProvider.notifier);

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
        title: const Text('BLE Scanner'),
        actions: [
          if (state.isScanning)
            const Padding(
              padding: EdgeInsets.all(16),
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
              ),
            ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          viewModel.stopScan();
          viewModel.startScan();
        },
        child: state.devices.isEmpty
            ? _buildEmptyState(state.isScanning)
            : ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: state.devices.length,
                itemBuilder: (context, index) {
                  final device = state.devices[index];
                  return BleDeviceTile(
                    device: device,
                    onTap: () => _navigateToDevice(context, device),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: state.isScanning ? viewModel.stopScan : viewModel.startScan,
        icon: Icon(state.isScanning ? Icons.stop : Icons.bluetooth_searching),
        label: Text(state.isScanning ? 'Stop' : 'Scan'),
      ),
    );
  }

  Widget _buildEmptyState(bool isScanning) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isScanning ? Icons.bluetooth_searching : Icons.bluetooth_disabled,
            size: 64,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          Text(
            isScanning ? 'Scanning for devices...' : 'No devices found\nTap Scan to start',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  void _navigateToDevice(BuildContext context, BleDevice device) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => BleDevicePage(device: device)),
    );
  }
}
