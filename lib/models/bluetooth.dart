import 'dart:convert';
import 'dart:typed_data';

import 'package:energy_pilot/providers/battery_provider.dart';
import 'package:flutter_blue/flutter_blue.dart';

import '../providers/amp_chart_data_provider.dart';

class Bluetooth {
  // flutter_blue instance
  final FlutterBlue _flutterBlue = FlutterBlue.instance;
  // variable to check if devices are being scanned
  bool _isScanning = false;
  // ble connected device
  BluetoothDevice? _device;

  // ble service uuid
  final String serviceUuid = "4fafc201-1fb5-459e-8fcc-c5c9c331914b";
  // current live data characteristic uuid of service ble
  final String currentCharacteristicUuid = "beb5483e-36e1-4688-b7f5-ea07361b26a8";
  // bat_1 voltage live data characteristic uuid of service ble
  final String bat1CharacteristicUuid = "a2bdef65-f783-490d-b6ed-5ec887c85958";
  // bat_2 voltage live data characteristic uuid of service ble
  final String bat2CharacteristicUuid = "d04f3a17-c31b-40df-a4ae-4693d7315527";
  // bat_3 voltage live data characteristic uuid of service ble
  final String bat3CharacteristicUuid = "7b0a924a-7cac-4ebc-9eab-08ed6944b9f7";
  // min voltage board configuration characteristic uuid of service ble
  final String minVoltageBoardConfigurationCharacteristicUuid = "4c9b541d-0470-4018-ab66-03fcf89b613f";
  // max voltage board configuration characteristic uuid of service ble
  final String maxVoltageBoardConfigurationCharacteristicUuid = "304aa553-a662-4ffa-a9a7-4877acc36751";
  // max current board configuration characteristic uuid of service ble
  final String maxCurrentBoardConfigurationCharacteristicUuid = "067735e9-d435-46c6-ae3f-99d31253c7dc";

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

  void subscribeToCharacteristics() async {
    // create a local variable for null analysis
    try {
      final BluetoothDevice? device = _device;
      if (device != null) {
        // get the connected devices
        List<BluetoothDevice> connectedDevices = await flutterBlue.connectedDevices;
        // ensure it is connected
        if (!connectedDevices.contains(device)) {
          await device.connect();
        }
        // get the services of the device
        List<BluetoothService> services = await device.discoverServices();
        for (BluetoothService currentService in services) {
          // get the characteristics of the service
          List<BluetoothCharacteristic> characteristics = currentService.characteristics;
          for (BluetoothCharacteristic bluetoothCharacteristic in characteristics) {
            // subscribe to the characteristics
            if (bluetoothCharacteristic.uuid.toString() == currentCharacteristicUuid) {
              await bluetoothCharacteristic.setNotifyValue(true);
              bluetoothCharacteristic.value.listen((value) {
                if (value.isNotEmpty) {
                  ByteData data = ByteData.sublistView(Uint8List.fromList(value));
                  var current = data.getFloat32(0, Endian.little);
                  print("Current: $current A");
                  AmpChartDataProvider().addData(current.toInt());
                }
              });
            } else if (bluetoothCharacteristic.uuid.toString() == bat1CharacteristicUuid) {
              await bluetoothCharacteristic.setNotifyValue(true);
              bluetoothCharacteristic.value.listen((value) {
                if (value.isNotEmpty) {
                  ByteData data = ByteData.sublistView(Uint8List.fromList(value));
                  var bat1 = data.getFloat32(0, Endian.little);
                  BatteryProvider().addVoltage(0, bat1);
                  print("Bat1: $bat1 V");
                }
              });
            } else if (bluetoothCharacteristic.uuid.toString() == bat2CharacteristicUuid) {
              await bluetoothCharacteristic.setNotifyValue(true);
              bluetoothCharacteristic.value.listen((value) {
                if (value.isNotEmpty) {
                  ByteData data = ByteData.sublistView(Uint8List.fromList(value));
                  var bat2 = data.getFloat32(0, Endian.little);
                  BatteryProvider().addVoltage(1, bat2);
                  print("Bat2: $bat2 V");
                }
              });
            } else if (bluetoothCharacteristic.uuid.toString() == bat3CharacteristicUuid) {
              await bluetoothCharacteristic.setNotifyValue(true);
              bluetoothCharacteristic.value.listen((value) {
                if (value.isNotEmpty) {
                  ByteData data = ByteData.sublistView(Uint8List.fromList(value));
                  var bat3 = data.getFloat32(0, Endian.little);
                  BatteryProvider().addVoltage(2, bat3);
                  print("Bat3: $bat3 V");
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

  void sendBatteryConfigurationToBoard(double minVoltage, double maxVoltage, double maxCurrent) async {
    // create a local variable for null analysis
    try {
      final BluetoothDevice? device = _device;
      if (device != null) {
        // get the connected devices
        List<BluetoothDevice> connectedDevices = await flutterBlue.connectedDevices;
        // ensure it is connected
        if (!connectedDevices.contains(device)) {
          await device.connect();
        }
        // get the services of the device
        List<BluetoothService> services = await device.discoverServices();
        for (BluetoothService currentService in services) {
          // get the characteristics of the service
          List<BluetoothCharacteristic> characteristics = currentService.characteristics;
          for (BluetoothCharacteristic bluetoothCharacteristic in characteristics) {
            // subscribe to the characteristics
            if (bluetoothCharacteristic.uuid.toString() == minVoltageBoardConfigurationCharacteristicUuid) {
              List<int> value = utf8.encode(minVoltage.toString());
              await bluetoothCharacteristic.write(value);
              await bluetoothCharacteristic.setNotifyValue(true);
              await Future.delayed(const Duration(milliseconds: 500));
              print("Min voltage sent by bluetooth");
            } else if (bluetoothCharacteristic.uuid.toString() == maxVoltageBoardConfigurationCharacteristicUuid) {
              List<int> value = utf8.encode(maxVoltage.toString());
              await bluetoothCharacteristic.write(value);
              await bluetoothCharacteristic.setNotifyValue(true);
              await Future.delayed(const Duration(milliseconds: 500));
              print("Max voltage sent by bluetooth");
            } else if (bluetoothCharacteristic.uuid.toString() == maxCurrentBoardConfigurationCharacteristicUuid) {
              List<int> value = utf8.encode(maxCurrent.toString());
              await bluetoothCharacteristic.write(value);
              await bluetoothCharacteristic.setNotifyValue(true);
              await Future.delayed(const Duration(milliseconds: 500));
              print("Max current sent by bluetooth");
            }
          }
        }
      }
    } catch (e) {
      print("Error $e");
    }
  }
}
