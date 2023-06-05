import 'package:energy_pilot/providers/battery_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BatteryConfig extends StatelessWidget {
  BatteryConfig({Key? key}) : super(key: key);

  // text input controllers
  String minVoltageText = "";
  String maxVoltageText = "";
  String maxCurrentText = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20.0),
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      color: Colors.blueAccent,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: 5,
              bottom: 5,
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
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          hintStyle: const TextStyle(color: Colors.black),
                          hintText: '${BatteryProvider().battery.minVoltage} V',
                          fillColor: Colors.white,
                        ),
                        onChanged: (text) {
                          minVoltageText = text;
                        },
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
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          hintStyle: const TextStyle(color: Colors.black),
                          hintText: "${BatteryProvider().battery.maxVoltage} V",
                          fillColor: Colors.white,
                        ),
                        onChanged: (text) {
                          maxVoltageText = text;
                        },
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
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        hintStyle: const TextStyle(color: Colors.black),
                        hintText: "${BatteryProvider().battery.maxAmps} A",
                        fillColor: Colors.white,
                      ),
                      onChanged: (text) {
                        maxCurrentText = text;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            width: 200,
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                padding: const EdgeInsets.all(16.0),
                textStyle: const TextStyle(fontSize: 20),
                backgroundColor: Colors.greenAccent,
              ),
              onPressed: () {
                String response = BatteryProvider().applyBatteryConfig(minVoltageText, maxVoltageText, maxCurrentText);
                if (response == "") {
                  // everything is fine
                  minVoltageText = "";
                  maxVoltageText = "";
                  maxCurrentText = "";
                } else {
                  Fluttertoast.showToast(
                    msg: 'Fill all the config fields',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                  );
                }
              },
              child: const Text("Apply"),
            ),
          ),
        ],
      ),
    );
  }
}
