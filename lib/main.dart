import 'package:energy_pilot/widgets/Footer.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    App(),
  );
}

class App extends StatelessWidget {
  static const String _title = 'EnergyPilot';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(_title),
        ),
        body: Container(
          child: Center(
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Text('Hello'),
            ),
          ),
        ),
        bottomNavigationBar: const Footer(),
      ),
    );
  }
}
