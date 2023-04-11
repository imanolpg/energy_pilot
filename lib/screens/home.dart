import 'package:energy_pilot/providers/bluetooth_provider.dart';
import 'package:energy_pilot/screens/scan_devices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/battery_provider.dart';
import '../widgets/amp_chart.dart';
import '../widgets/battery_config.dart';
import '../widgets/cell_status.dart';
import '../widgets/footer.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    BatteryProvider batteryProvider = context.watch<BatteryProvider>();
    BluetoothProvider bluetoothProvider = context.watch<BluetoothProvider>();

    if (bluetoothProvider.bluetooth.device == null) {
      return const ScanDevices();
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: Column(
          children: [
            const AmpChart(),
            Expanded(
              child: Column(
                children: batteryProvider.battery.cells
                    .map(
                      (cell) => CellStatus(
                        cell: cell,
                      ),
                    )
                    .toList(),
              ),
            ),
            BatteryConfig(
              battery: batteryProvider.battery,
            ),
          ],
        ),
        bottomNavigationBar: const Footer(),
      );
    }
  }
}
