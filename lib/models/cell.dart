import 'package:flutter/material.dart';

class Cell {
  late String id = "";
  late double voltage = 0.0;
  late IconData icon = Icons.battery_unknown;
  late Color iconColor = Colors.black;
  double maxVoltage = 4.2;
  double minVoltage = 3.3;

  Cell({required this.id});

  void setIconFromVoltage() {
    double range = maxVoltage - minVoltage;
    double interval = range / 8.0;

    if (voltage <= (interval * 1) + minVoltage) {
      icon = Icons.battery_0_bar;
      iconColor = Colors.redAccent;
    } else if (voltage <= (interval * 2) + minVoltage) {
      icon = Icons.battery_1_bar;
      iconColor = Colors.redAccent;
    } else if (voltage <= (interval * 3) + minVoltage) {
      icon = Icons.battery_2_bar;
      iconColor = Colors.deepOrangeAccent;
    } else if (voltage <= (interval * 4) + minVoltage) {
      icon = Icons.battery_3_bar;
      iconColor = Colors.deepOrangeAccent;
    } else if (voltage <= (interval * 5) + minVoltage) {
      icon = Icons.battery_4_bar;
      iconColor = Colors.green;
    } else if (voltage <= (interval * 6) + minVoltage) {
      icon = Icons.battery_5_bar;
      iconColor = Colors.green;
    } else if (voltage <= (interval * 7) + minVoltage) {
      icon = Icons.battery_6_bar;
      iconColor = Colors.green;
    } else if (voltage <= (interval * 8) + minVoltage) {
      icon = Icons.battery_full;
      iconColor = Colors.green;
    } else {
      icon = Icons.battery_unknown;
      iconColor = Colors.black;
    }
  }

  void setVoltage(double newVoltage) {
    voltage = newVoltage;
    setIconFromVoltage();
  }
}
