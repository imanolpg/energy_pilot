import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class ScanDevices extends StatefulWidget {
  @override
  _ScanDevicesState createState() => _ScanDevicesState();
}

class _ScanDevicesState extends State<ScanDevices> {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  List<BluetoothDevice> devices = [];

  @override
  void initState() {
    super.initState();
    _startScan();
  }

  Future<void> _startScan() async {
    flutterBlue.startScan(timeout: Duration(seconds: 4));

    flutterBlue.scanResults.listen((results) {
      for (ScanResult r in results) {
        if (!devices.contains(r.device)) {
          setState(() {
            devices.add(r.device);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan for Devices'),
      ),
      body: ListView.builder(
        itemCount: devices.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(devices[index].name),
            subtitle: Text(devices[index].id.toString()),
            trailing: ElevatedButton(
              onPressed: () async {
                await devices[index].connect();
                Navigator.pop(context, devices[index]);
              },
              child: Text('Connect'),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    flutterBlue.stopScan();
    super.dispose();
  }
}
