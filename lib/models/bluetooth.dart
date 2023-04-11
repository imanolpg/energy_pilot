import 'dart:typed_data';

import 'package:flutter_blue/flutter_blue.dart';

class Bluetooth {
  // flutter_blue instance
  final FlutterBlue _flutterBlue = FlutterBlue.instance;
  // variable to check if devices are being scanned
  bool _isScanning = false;
  // ble connected device
  BluetoothDevice? _device;

  // ble connected device service
  late BluetoothService _service;
  // ble service uuid
  final String serviceUuid = "4fafc201-1fb5-459e-8fcc-c5c9c331914b";

  // current live data characteristic of service ble
  late BluetoothCharacteristic _currentCharacteristic;
  // current live data characteristic uuid of service ble
  final String currentCharacteristicUuid =
      "beb5483e-36e1-4688-b7f5-ea07361b26a8";
  late double current;

  // bat_1 voltage live data characteristic of service ble
  late BluetoothCharacteristic _bat1Characteristic;
  // bat_1 voltage live data characteristic uuid of service ble
  final String bat1CharacteristicUuid = "a2bdef65-f783-490d-b6ed-5ec887c85958";
  late double bat1;

  // bat_2 voltage live data characteristic of service ble
  late BluetoothCharacteristic _bat2Characteristic;
  // bat_2 voltage live data characteristic uuid of service ble
  final String bat2CharacteristicUuid = "d04f3a17-c31b-40df-a4ae-4693d7315527";
  late double bat2;

  // bat_3 voltage live data characteristic of service ble
  late BluetoothCharacteristic _bat3Characteristic;
  // bat_3 voltage live data characteristic uuid of service ble
  final String bat3CharacteristicUuid = "7b0a924a-7cac-4ebc-9eab-08ed6944b9f7";
  late double bat3;

  // Getter for _flutterBlue
  FlutterBlue get flutterBlue => _flutterBlue;

  // Getter and Setter for _isScanning
  bool get isScanning => _isScanning;
  void setIsScanning(bool isScanning) {
    _isScanning = isScanning;
  }

  // Getter and Setter for _device
  BluetoothDevice? get device => _device;
  void setDevice(BluetoothDevice? device) {
    _device = device;
  }

  // Getter and Setter for _service
  BluetoothService get service => _service;
  void setService(BluetoothService service) {
    _service = service;
  }

  void subscribeToCharacteristics() async {
    // create a local variable for null analysis
    try {
      final BluetoothDevice? device = _device;
      if (device != null) {
        // get the connected devices
        List<BluetoothDevice> connectedDevices =
            await flutterBlue.connectedDevices;
        // ensure it is connected
        if (!connectedDevices.contains(device)) {
          await device.connect();
        }
        // get the services of the device
        List<BluetoothService> services = await device.discoverServices();
        for (BluetoothService currentService in services) {
          if (currentService.uuid.toString() ==
              "4fafc201-1fb5-459e-8fcc-c5c9c331914b") {
            _service = currentService;
            break;
          }

          // get the characteristics of the service
          List<BluetoothCharacteristic> characteristics =
              service.characteristics;
          for (BluetoothCharacteristic bluetoothCharacteristic
              in characteristics) {
            // subscribe to the currentCharacteristic
            if (bluetoothCharacteristic.uuid.toString() ==
                currentCharacteristicUuid) {
              _currentCharacteristic = bluetoothCharacteristic;
              _currentCharacteristic.setNotifyValue(true);
              _currentCharacteristic.value.listen((value) {
                if (value.isNotEmpty) {
                  ByteData data =
                      ByteData.sublistView(Uint8List.fromList(value));
                  current = data.getFloat32(0, Endian.little);
                  print("Current: $current A");
                }
              });
            } else if (bluetoothCharacteristic.uuid.toString() ==
                bat1CharacteristicUuid) {
              print("Bat1 subscribed");
              _bat1Characteristic = bluetoothCharacteristic;
              _bat1Characteristic.value.listen((value) {
                if (value.isNotEmpty) {
                  ByteData data =
                      ByteData.sublistView(Uint8List.fromList(value));
                  bat1 = data.getFloat32(0, Endian.little);
                  print("Bat1: $bat1 V");
                }
              });
            }
          }
        }
      }
    } catch (e) {
      print("Error $e");
    }
  }
}
