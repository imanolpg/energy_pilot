import 'package:energy_pilot/screens/home.dart';
import 'package:energy_pilot/screens/user.dart';
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
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        '/user': (context) => const User(),
      },
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(color: Colors.blueAccent),
        brightness: Brightness.light,
      ),
    );
  }
}
