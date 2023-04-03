import 'package:energy_pilot/widgets/scanned_devices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class ScanDevices extends StatefulWidget {
  @override
  _ScanDevicesState createState() => _ScanDevicesState();
}

class _ScanDevicesState extends State<ScanDevices> {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  List<BluetoothDevice> devices = [];
  bool _scanning = false;

  @override
  void initState() {
    super.initState();
    _startScan();
  }

  Future<void> _startScan() async {
    try {
      setState(() => _scanning = true);

      // Start scanning
      await flutterBlue.startScan(timeout: Duration(seconds: 4));

      // Listen for scan results
      flutterBlue.scanResults.listen((results) async {
        for (ScanResult r in results) {
          // Connect to device
          List<BluetoothDevice> connectedDevices =
              await flutterBlue.connectedDevices;

          print("Evaluando dispositivo: ${r.device.name}");

          if (connectedDevices.contains(r.device)) {
            print("Dispositivo ya conectado(${r.device.name})");
          } else {
            await r.device.connect();
            print("Conectando (${r.device.name})");

            // Discover services and characteristics
            List<BluetoothService> services = await r.device.discoverServices();
            print("Servicios obtenidos (${r.device.name})");

            for (BluetoothService service in services) {
              print(
                  "UUID del servvidio: ${service.uuid.toString()} disp (${r.device.name})");
              if (service.uuid.toString() ==
                  "4fafc201-1fb5-459e-8fcc-c5c9c331914b") {
                await flutterBlue
                    .stopScan(); // Stop scanning if desired characteristic is found
                setState(() {
                  devices.add(r.device);
                }); // Return the device
                print("SE HA ANIADIDO EL DISPOSITIVO ${r.device.name}");
              }
            }

            // Disconnect from device
            await r.device.disconnect();
          }
        }
      });
    } catch (e) {
      print('Error scanning for devices: $e');
    } finally {
      setState(() => _scanning = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Scan for Device'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!_scanning && devices.isNotEmpty)
              Center(
                child: ScannedDevices(devices: devices),
              )
            else
              Column(
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(height: 10,),
                  Center(
                    child: Text("Scanning dvices.."),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    flutterBlue.stopScan();
    super.dispose();
  }
}
