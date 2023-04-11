import 'dart:async';
import 'dart:math' as math;

import 'package:energy_pilot/models/battery.dart';
import 'package:energy_pilot/models/cell.dart';
import 'package:flutter/cupertino.dart';

class BatteryProvider extends ChangeNotifier {
  final Battery _battery = Battery(batteryId: "battery", cells: [
    Cell(id: "cel_1"),
    Cell(id: "cel_2"),
    Cell(id: "cel_3"),
  ]);

  void addRandomVoltajes() {
    _battery.cells[0].setVoltage((math.Random().nextDouble() * 0.9) + 3.3);
    _battery.cells[1].setVoltage((math.Random().nextDouble() * 0.9) + 3.3);
    _battery.cells[2].setVoltage((math.Random().nextDouble() * 0.9) + 3.3);
    notifyListeners();
  }

  BatteryProvider() {
    Timer.periodic(const Duration(milliseconds: 5000), (_) {
      addRandomVoltajes();
    });
  }

  Battery get battery => _battery;
}
