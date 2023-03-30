import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

class ConnectDevice extends StatefulWidget {
  const ConnectDevice({Key? key}) : super(key: key);

  @override
  State<ConnectDevice> createState() => _ConnectDeviceState();
}

class _ConnectDeviceState extends State<ConnectDevice> {
  final flutterReactiveBle = FlutterReactiveBle();
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
