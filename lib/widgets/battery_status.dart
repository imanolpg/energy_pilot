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
    return Row(
      children: [
        const Spacer(),
        Transform.rotate(
          angle: math.pi / 2,
          child: SizedBox(
            height: 40.0,
            child: Icon(
              battery.icon,
              size: 70,
              color: battery.iconColor,
            ),
          ),
        ),
        const Spacer(),
        Text(battery.id),
        const Spacer(),
        RichText(
          text: TextSpan(
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.black,
            ),
            children: [
              const TextSpan(text: 'Voltage:  '),
              TextSpan(
                  text: '${battery.voltage.toStringAsFixed(2)}V',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
