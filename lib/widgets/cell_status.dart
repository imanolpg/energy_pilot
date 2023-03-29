import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../models/cell.dart';

class CellStatus extends StatelessWidget {
  final Cell cell;

  const CellStatus({
    super.key,
    required this.cell,
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
              cell.icon,
              size: 70,
              color: cell.iconColor,
            ),
          ),
        ),
        const Spacer(),
        Text(cell.id),
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
                  text: '${cell.voltage.toStringAsFixed(2)}V',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
