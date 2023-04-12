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

    List<Widget> buildAppBarActions() {
      List<Widget> actionsList = [];
      var device = bluetoothProvider.device;
      var deviceName = bluetoothProvider.device?.name;
      if (device != null && deviceName != null) {
        actionsList.add(Center(
          child: Text(
            deviceName,
            style: const TextStyle(
              fontSize: 18.0,
            ),
          ),
        ));
        actionsList.add(const SizedBox(width: 4));
        actionsList.add(const Icon(
          Icons.bluetooth,
          color: Colors.white,
          size: 18,
        ));
        actionsList.add(const SizedBox(
          width: 4,
        ));
        actionsList.add(Container(
          margin: const EdgeInsets.only(top: 6.0, bottom: 6.0, right: 6.0),
          child: TextButton(
            onPressed: () {
              bluetoothProvider.disconnectDevice();
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
            ),
            child: const Text(
              "Disconnect",
              style: TextStyle(color: Colors.blueAccent),
            ),
          ),
        ));
      }
      return actionsList;
    }

    if (bluetoothProvider.device == null) {
      return const ScanDevices();
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          actions: buildAppBarActions(),
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
