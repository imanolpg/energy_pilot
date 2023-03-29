import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Battery {
  late String id;
  late double voltage;
  late IconData icon;
  final double maxVoltage = 4.2;
  final double minVoltage = 3.3;

  void setIconFromVoltage() {
    double range = maxVoltage - minVoltage;
    double interval = range / 8.0;

    double first = (interval * 7) + minVoltage;

    print('Voltage: $voltage');
    print('Range: $range');
    print('Interval: $interval');
    print('First: $first');

    if (voltage <= (interval * 1) + minVoltage) {
      icon = Icons.battery_0_bar;
    } else if (voltage <= (interval * 2) + minVoltage) {
      icon = Icons.battery_1_bar;
    } else if (voltage <= (interval * 3) + minVoltage) {
      icon = Icons.battery_2_bar;
    } else if (voltage <= (interval * 4) + minVoltage) {
      icon = Icons.battery_3_bar;
    } else if (voltage <= (interval * 5) + minVoltage) {
      icon = Icons.battery_4_bar;
    } else if (voltage <= (interval * 6) + minVoltage) {
      icon = Icons.battery_5_bar;
    } else if (voltage <= (interval * 7) + minVoltage) {
      icon = Icons.battery_6_bar;
    } else if (voltage <= (interval * 8) + minVoltage) {
      icon = Icons.battery_full;
    } else {
      icon = Icons.battery_unknown;
    }
  }

  void setVoltage(double newVoltage) {
    voltage = newVoltage;
    setIconFromVoltage();
  }

  Battery({required this.id});
}
