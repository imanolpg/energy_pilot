import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/battery_provider.dart';
import '../widgets/Footer.dart';
import '../widgets/battery_config.dart';
import '../widgets/battery_current_chart.dart';
import '../widgets/cell_status.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    BatteryProvider batteryProvider = context.watch<BatteryProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          const AmpChart(),
          Expanded(
            child: Column(
              children: batteryProvider.battery.cells
                  .map(
                    (cell) => CellStatus(
                      cell: cell,
                    ),
                  )
                  .toList(),
            ),
          ),
          BatteryConfig(
            battery: batteryProvider.battery,
          ),
        ],
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
