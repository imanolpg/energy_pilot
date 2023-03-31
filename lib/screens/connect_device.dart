import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

import '../widgets/Footer.dart';

class ConnectDevice extends StatefulWidget {
  const ConnectDevice({Key? key}) : super(key: key);

  @override
  State<ConnectDevice> createState() => _ConnectDeviceState();
}

class _ConnectDeviceState extends State<ConnectDevice> {
  FlutterBlue flutterBlue = FlutterBlue.instance;

  late BluetoothDevice miDispositivo;

  void prueba2() async {
    print("Device connected");
    List<BluetoothService> services = await miDispositivo.discoverServices();
    services.forEach((service) {
      // do something with service
      print("Service UUID: ${service.uuid.toString()}");
    });
  }

  void prueba() {
    // Start scanning
    flutterBlue.startScan(timeout: const Duration(seconds: 4));

    // Listen to scan results
    var subscription = flutterBlue.scanResults.listen((results) async {
      // do something with scan results
      print("Entrando bucle -------");
      for (ScanResult r in results) {
        //print('${r.device.name} found! rssi: ${r.rssi}');
        if (r.device.name == "ESP32 prueba") {
          print("Device detected");
          await r.device.connect();
          miDispositivo = r.device;
        }
      }
      print("Saliendo bucle -------");
    });

    // Stop scanning
    flutterBlue.stopScan();
  }

  @override
  Widget build(BuildContext context) {
    prueba();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Connect device'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(),
          ),
        ],
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
