import 'package:flutter/foundation.dart';
import 'package:flutter_blue/flutter_blue.dart';

import '../models/bluetooth.dart';

class BluetoothProvider extends ChangeNotifier {
  final Bluetooth _bluetooth = Bluetooth(flutterBlue: FlutterBlue.instance);

  Bluetooth get bluetooth => _bluetooth;
  FlutterBlue get flutterBlue => _bluetooth.flutterBlue;

  Future<void> setBtDevice({required Bluetooth bluetooth}) async {}
}
