import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class ScanDevices extends StatelessWidget {
  const ScanDevices({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Connect a board"),
      ),
      body: StreamBuilder<BluetoothState>(
          stream: FlutterBlue.instance.state,
          initialData: BluetoothState.unknown,
          builder: (c, snapshot) {
            final state = snapshot.data;
            if (state == BluetoothState.on) {
              return const Center(
                child: Text("Bluetooth on"),
              );
            }
            return const Center(
              child: Text("Bluetooth off"),
            );
          }),
    );
  }
}
