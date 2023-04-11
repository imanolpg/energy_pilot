import 'dart:async';

import 'package:energy_pilot/models/bluetooth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:provider/provider.dart';

class BluetoothProvider extends ChangeNotifier {
  // bluetooth object
  final Bluetooth _bluetooth = Bluetooth();
  // array of available devices when are scanned
  final List<BluetoothDevice> _availableDevices = [];
  // StreamController for the body
  final StreamController<BluetoothState> _bodyBluetoothStateStream = StreamController<BluetoothState>();
  // StreamController for the floatingActionButton
  final StreamController<BluetoothState> _floatingActionButtonBluetoothStateStream = StreamController<BluetoothState>();

  /// begin Getters and setters
  Bluetooth get bluetooth => _bluetooth;
  FlutterBlue get flutterBlue => _bluetooth.flutterBlue;
  Stream<BluetoothState> get bodyBluetoothStateStream => _bodyBluetoothStateStream.stream;
  Stream<BluetoothState> get floatingActionButtonBluetoothStateStream => _floatingActionButtonBluetoothStateStream.stream;
  bool get isScanning => bluetooth.isScanning;
  void setIsScanning(bool isScanning) {
    _bluetooth.setIsScanning(isScanning);
    notifyListeners();
  }

  List<BluetoothDevice> get availableDevices => _availableDevices;
  BluetoothDevice? get device => bluetooth.device;
  //// end Getters and Setters

  BluetoothProvider() {
    // two StreamProviders are used and we have to create two streams from the
    // stream in flutterBlue.instance.state
    // set _bodyBluetoothStateStream stream
    StreamProvider<BluetoothState>(
      create: (_) => _bodyBluetoothStateStream.stream,
      initialData: BluetoothState.unknown,
    );
    // set _floatingActionButtonBluetoothStateStream stream
    StreamProvider<BluetoothState>(
      create: (_) => _floatingActionButtonBluetoothStateStream.stream,
      initialData: BluetoothState.unknown,
    );
    // broadcast the data to the other listeners
    bluetooth.flutterBlue.state.listen((data) {
      _bodyBluetoothStateStream.add(data);
      _floatingActionButtonBluetoothStateStream.add(data);
      if (data != BluetoothState.on) {
        setDevice(null);
      }
    });

    // the first time we create the bluetooth object we have to check if there is
    // a device connected
    bluetooth.flutterBlue.connectedDevices.then((connectedDevices) async {
      print("construyendo... $connectedDevices");
      // connected devices are checked
      for (BluetoothDevice connectedDevice in connectedDevices) {
        // get the services of the particular device
        List<BluetoothService> services = await connectedDevice.discoverServices();
        // search for the specific server
        for (BluetoothService service in services) {
          if (service.uuid.toString() == bluetooth.serviceUuid) {
            // if the desired service is found we have to set the device, service
            // and we have to subscribe to characteristics
            print("Servicio ${service.uuid}");
            bluetooth.setDevice(connectedDevice);
            bluetooth.subscribeToCharacteristics();
            break;
          }
        }
      }
    });
  }

  void scanForAvailableDevices() async {
    try {
      _availableDevices.clear();
      setIsScanning(true);
      // scan for devices
      await flutterBlue.startScan(timeout: const Duration(seconds: 4));

      flutterBlue.scanResults.listen((scanResults) async {
        // get the connected devices
        List<BluetoothDevice> connectedDevices = await flutterBlue.connectedDevices;

        for (ScanResult scanResult in scanResults) {
          print("Dispositivo escaneado: ${scanResult.device.name}");

          // check if the device is connected. If it is connected and a new
          // connection is made an error is thrown
          if (!connectedDevices.contains(scanResult.device)) {
            print("Dispositivo no conectado");
            // connect to device to see the services
            // if there is an error no connection is made
            bool connectionDone = false;
            try {
              await scanResult.device.connect();
              connectionDone = true;
            } catch (e) {
              print("An error when connecting to device");
            }

            if (connectionDone) {
              // get the connected device services
              List<BluetoothService> deviceServices = await scanResult.device.discoverServices();

              // search if the wanted service is offered by the device
              for (BluetoothService service in deviceServices) {
                if (service.uuid.toString() == bluetooth.serviceUuid) {
                  // the service is available in the device
                  if (!_availableDevices.contains(scanResult.device)) {
                    _availableDevices.add(scanResult.device);
                    notifyListeners();
                  }
                  break;
                }
              }

              // once the device has been analyzed it is disconnected
              await scanResult.device.disconnect();
              print("Dispositivo desconectado");
            }
          } else {
            print("Dispositivo ya conectado");
          }
        }
      });
    } catch (e) {
      print("Error");
    } finally {
      setIsScanning(false);
    }
  }

  /// Connect to device for monitoring
  void connectToDevice(BluetoothDevice device) async {
    bluetooth.setDevice(device);
    BluetoothDevice? bluetoothDevice = bluetooth.device;
    // establish connection with the device
    if (bluetoothDevice != null) {
      await bluetoothDevice.connect(); // connect to the device
      bluetooth.subscribeToCharacteristics(); // subscribe to characteristics
    }
    notifyListeners();
  }

  void setDevice(BluetoothDevice? device) async {
    if (device != null) {
      bluetooth.setDevice(device);
      await device.connect();
      bluetooth.subscribeToCharacteristics();
    } else {
      BluetoothDevice? deviceAux = bluetooth.device;
      if (deviceAux != null) {
        await deviceAux.disconnect();
      }
      bluetooth.setDevice(null);
    }
    notifyListeners();
  }
}
