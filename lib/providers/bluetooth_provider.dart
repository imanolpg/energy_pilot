import 'package:flutter/foundation.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BluetoothProvider extends ChangeNotifier {
  BluetoothDevice? _device;
  BluetoothCharacteristic? _characteristic;

  BluetoothDevice? get device => _device;

  set device(BluetoothDevice? device) {
    _device = device;
    notifyListeners();
  }

  BluetoothCharacteristic? get characteristic => _characteristic;

  set characteristic(BluetoothCharacteristic? characteristic) {
    _characteristic = characteristic;
    notifyListeners();
  }

  void disconnect() {
    _device?.disconnect();
    _device = null;
    _characteristic = null;
    notifyListeners();
  }
}
