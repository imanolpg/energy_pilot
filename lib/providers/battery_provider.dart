import 'package:energy_pilot/models/battery.dart';
import 'package:energy_pilot/models/cell.dart';
import 'package:flutter/cupertino.dart';

class BatteryProvider extends ChangeNotifier {
  Battery _battery = Battery(batteryId: "battery", cells: [
    Cell(id: "cel_1"),
    Cell(id: "cel_2"),
    Cell(id: "cel_3"),
  ]);

  BatteryProvider();

  Battery get battery => _battery;

  Future<void> setBattery({required Battery battery}) async {
    _battery = battery;
  }
}
