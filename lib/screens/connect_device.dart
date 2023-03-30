import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class ConnectDevice extends StatefulWidget {
  const ConnectDevice({Key? key}) : super(key: key);

  @override
  State<ConnectDevice> createState() => _ConnectDeviceState();
}

class _ConnectDeviceState extends State<ConnectDevice> {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  @override
  Widget build(BuildContext context) {
    // Start scanning
    flutterBlue.startScan(timeout: const Duration(seconds: 4));

// Listen to scan results
    var subscription = flutterBlue.scanResults.listen((results) {
      // do something with scan results
      print("Entrando bucle -------");
      for (ScanResult r in results) {
        print('${r.device.name} found! rssi: ${r.rssi}');
      }
      print("Saliendo bucle -------");
    });

// Stop scanning
    flutterBlue.stopScan();
    return Scaffold();
  }
}
