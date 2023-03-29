import 'dart:math';

import 'package:energy_pilot/widgets/Footer.dart';
import 'package:energy_pilot/widgets/battery_config.dart';
import 'package:energy_pilot/widgets/battery_status.dart';
import 'package:flutter/material.dart';

import '../models/battery.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Battery> batteries = [
    Battery(
      id: "bat_1",
    ),
    Battery(
      id: "bat_2",
    ),
    Battery(
      id: "bat_3",
    ),
  ];

  void setBatteriesData() {
    for (Battery battery in batteries) {
      double randomVoltage =
          double.parse((3.2 + Random().nextDouble()).toStringAsFixed(2));
      battery.setVoltage(randomVoltage);
    }
  }

  @override
  Widget build(BuildContext context) {
    setBatteriesData();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          const Text('Aquí va la gráfica'),
          Column(
            children: batteries
                .map(
                  (battery) => BatteryStatus(
                    battery: battery,
                  ),
                )
                .toList(),
          ),
          BatteryConfig(
            batteries: batteries,
          ),
        ],
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
