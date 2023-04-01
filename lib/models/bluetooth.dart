import 'package:flutter_blue/flutter_blue.dart';

class Bluetooth {
  final FlutterBlue flutterBlue;

  late BluetoothDevice device;

  Bluetooth({required this.flutterBlue});
}
