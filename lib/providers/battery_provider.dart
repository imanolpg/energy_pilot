import 'package:energy_pilot/models/battery.dart';
import 'package:energy_pilot/models/cell.dart';
import 'package:energy_pilot/providers/bluetooth_provider.dart';
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

  String getMinVoltage() {
    return _battery.minVoltage.toString();
  }

  String getMaxVoltage() {
    return _battery.maxVoltage.toString();
  }

  String getMaxCurrent() {
    return _battery.maxAmps.toString();
  }

  String applyBatteryConfig(String minVoltage, String maxVoltage, String maxCurrent) {
    double minVoltageParsed;
    double maxVoltageParsed;
    double maxCurrentParsed;

    try {
      minVoltageParsed = double.parse(minVoltage);
      maxVoltageParsed = double.parse(maxVoltage);
      maxCurrentParsed = double.parse(maxCurrent);
    } catch (e) {
      return ("Error parsing values");
    }

    // save the values to the battery object
    _battery.minVoltage = minVoltageParsed;
    _battery.maxVoltage = maxVoltageParsed;
    _battery.maxAmps = maxCurrentParsed;

    BluetoothProvider().sendBatteryConfigurationToBoard(minVoltageParsed, maxVoltageParsed, maxCurrentParsed);

    notifyListeners();

    return "";
  }
}
