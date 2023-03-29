import 'package:flutter/material.dart';

import '../models/battery.dart';

class BatteryConfig extends StatelessWidget {
  final Battery battery;

  const BatteryConfig({
    Key? key,
    required this.battery,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20.0),
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      color: Colors.grey[600],
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: 10,
              bottom: 10,
            ),
            child: Row(
              children: [
                const Spacer(),
                Column(
                  children: [
                    const Text(
                      'Min voltage',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[900]),
                          hintText: '${battery.minVoltage} V',
                          fillColor: Colors.white70,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    const Text(
                      'Max voltage',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[900]),
                          hintText: "${battery.maxVoltage} V",
                          fillColor: Colors.white70,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 10.0,
              bottom: 10.0,
            ),
            child: Center(
              child: Column(
                children: [
                  const Text(
                    'Max voltage',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[900]),
                        hintText: "${battery.maxAmps} A",
                        fillColor: Colors.white70,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            width: 200,
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(16.0),
                textStyle: const TextStyle(fontSize: 20),
                backgroundColor: Colors.blueAccent,
              ),
              onPressed: () {},
              child: const Text("Aplicar"),
            ),
          ),
        ],
      ),
    );
  }
}
