import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../models/battery.dart';

class BatteryStatus extends StatelessWidget {
  final Battery battery;

  const BatteryStatus({
    super.key,
    required this.battery,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Transform.rotate(
            angle: math.pi / 2,
            child: Icon(
              battery.icon,
              size: 80,
              color: battery.iconColor,
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          Text(battery.id),
          const SizedBox(
            width: 20,
            height: 0,
          ),
          Text('Current voltage: ${battery.voltage} V'),
        ],
      ),
    );
  }
}
