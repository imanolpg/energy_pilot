import 'package:energy_pilot/widgets/scanned_devices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:provider/provider.dart';

import '../providers/bluetooth_provider.dart';

class ScanDevices extends StatelessWidget {
  const ScanDevices({super.key});

  @override
  Widget build(BuildContext context) {
    BluetoothProvider bluetoothProvider = context.watch<BluetoothProvider>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Scan for Device'),
      ),
      body: StreamBuilder<BluetoothState>(
          stream: bluetoothProvider.bodyBluetoothStateStream,
          initialData: BluetoothState.unknown,
          builder: (context, snapshot) {
            final state = snapshot.data;
            if (state == BluetoothState.on) {
              return Column(
                children: [
                  if (bluetoothProvider.isScanning)
                    SizedBox(
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Text("Scanning..."),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            height: 20,
                            width: 20,
                            child: Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          )
                        ],
                      ),
                    )
                  else
                    const SizedBox(
                      height: 60,
                    ),
                  const ScannedDevices(),
                ],
              );
            } else {
              return Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.bluetooth_disabled),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Bluetooth is not available"),
                  ],
                ),
              );
            }
          }),
      floatingActionButton: StreamBuilder<BluetoothState>(
          stream: bluetoothProvider.floatingActionButtonBluetoothStateStream,
          initialData: BluetoothState.unknown,
          builder: (context, snapshot) {
            final state = snapshot.data;
            if (state == BluetoothState.on && !bluetoothProvider.isScanning) {
              return FloatingActionButton.extended(
                onPressed: () {
                  bluetoothProvider.scanForAvailableDevices();
                },
                label: const Text("Start scanning.."),
              );
            } else {
              return Container();
            }
          }),
    );
  }
}
