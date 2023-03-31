import 'dart:math';

import 'package:energy_pilot/widgets/Footer.dart';
import 'package:energy_pilot/widgets/battery_config.dart';
import 'package:energy_pilot/widgets/cell_status.dart';
import 'package:flutter/material.dart';

import '../models/battery.dart';
import '../models/cell.dart';
import '../widgets/battery_current_chart.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Battery battery = Battery(batteryId: "Bateria1", cells: [
    Cell(
      id: "bat_1",
    ),
    Cell(
      id: "bat_2",
    ),
    Cell(
      id: "bat_3",
    ),
  ]);

  void setBatteriesData() {
    for (Cell cell in battery.cells) {
      double randomVoltage =
          double.parse((3.2 + Random().nextDouble()).toStringAsFixed(2));
      cell.setVoltage(randomVoltage);
    }
  }

  @override
  void initState() {
    super.initState();
    setBatteriesData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          const AmpChart(),
          Expanded(
            child: Column(
              children: battery.cells
                  .map(
                    (cell) => CellStatus(
                      cell: cell,
                    ),
                  )
                  .toList(),
            ),
          ),
          BatteryConfig(
            battery: battery,
          ),
        ],
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
