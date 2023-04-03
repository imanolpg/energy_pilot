import 'package:flutter/foundation.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BluetoothProvider extends ChangeNotifier {
  BluetoothDevice? _device;
  BluetoothService? _service;
  BluetoothCharacteristic? _characteristic;

  BluetoothDevice? get device => _device;

  void setDevice(BluetoothDevice device) async {
    _device = device;
    await _device?.connect();
    subscribeToCharacteristic();
    notifyListeners();
  }

  void subscribeToCharacteristic() async {
    final device = _device;
    if (device != null) {
      List<BluetoothService> services = await device.discoverServices();
      for (BluetoothService service in services) {
        if (service.uuid.toString() == "4fafc201-1fb5-459e-8fcc-c5c9c331914b") {
          _service = service;
          break;
        }
      }

      final service = _service;
      if (service != null) {
        List<BluetoothCharacteristic> characteristics = service.characteristics;
        for (BluetoothCharacteristic bluetoothCharacteristic
            in characteristics) {
          List<int> value = await bluetoothCharacteristic.read();
          print("Valor leido de la característica");
          print(value);
          ByteData data = ByteData.sublistView(Uint8List.fromList(value));
          print(data.getFloat32(0, Endian.little));
        }
      }
    }
  }
}
