import 'package:energy_pilot/models/battery.dart';
import 'package:energy_pilot/models/cell.dart';
import 'package:flutter/cupertino.dart';

class BatteryProvider extends ChangeNotifier {
  final Battery _battery = Battery(batteryId: "battery", cells: [
    Cell(id: "cel_1"),
    Cell(id: "cel_2"),
    Cell(id: "cel_3"),
  ]);

  static BatteryProvider? _instance;

  BatteryProvider._();

  factory BatteryProvider() => _instance ??= BatteryProvider._();

  Battery get battery => _battery;

  void addVoltage(int cell, double voltage) {
    _battery.cells[cell].setVoltage(voltage);
    notifyListeners();
  }
}
