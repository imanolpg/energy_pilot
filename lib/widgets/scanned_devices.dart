import 'package:energy_pilot/providers/bluetooth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:provider/provider.dart';

class ScannedDevices extends StatelessWidget {
  const ScannedDevices({Key? key, required this.devices}) : super(key: key);

  final List<BluetoothDevice> devices;

  void devicePressed(BluetoothDevice device, BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BluetoothProvider bluetoothProvider =
          Provider.of<BluetoothProvider>(context, listen: false);
      bluetoothProvider.setDevice(device);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Center(
        child: Text(
          "Choose a device",
          style: TextStyle(fontSize: 36.0),
        ),
      ),
      Container(
        margin: const EdgeInsets.all(10.0),
        color: Colors.grey[100],
        height: 500,
        child: devices.isNotEmpty
            ? Column(
                children: devices
                    .map(
                      (device) => Container(
                        margin: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ]),
                        child: Material(
                          color: Colors.grey[200],
                          child: InkWell(
                            onTap: () {
                              devicePressed(device, context);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.developer_board,
                                    color: Colors.brown,
                                    size: 60,
                                  ),
                                  const SizedBox(width: 20),
                                  const Icon(
                                    Icons.bluetooth,
                                    color: Colors.blueAccent,
                                    size: 22,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    device.name,
                                    style: const TextStyle(
                                      fontSize: 19.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              )
            : Container(),
      ),
    ]);
  }
}
