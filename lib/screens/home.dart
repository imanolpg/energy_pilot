import 'package:energy_pilot/widgets/Footer.dart';
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
      battery.setVoltage(3.2);
    }
  }

  @override
  Widget build(BuildContext context) {
    setBatteriesData();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Container(
        child: Column(
          children: [
            const Text('Aqui va la gráfica'),
            Column(
              children: batteries
                  .map((battery) => BatteryStatus(
                        id: battery.id,
                        icon: battery.icon,
                        voltage: battery.voltage,
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
