import 'dart:math' as math;

import 'package:flutter/material.dart';

class BatteryStatus extends StatelessWidget {
  final String id;
  final IconData icon;
  final double voltage;

  const BatteryStatus({
    super.key,
    required this.id,
    required this.icon,
    required this.voltage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Row(
        children: [
          Transform.rotate(
            angle: math.pi / 2,
            child: Icon(
              icon,
              size: 80,
            ),
          ),
          SizedBox(
            width: 30,
          ),
          Text('$id'),
          SizedBox(
            width: 20,
          ),
          Text('Current voltage: $voltage V'),
        ],
      ),
    );
  }
}
