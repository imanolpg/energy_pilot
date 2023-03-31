import 'package:energy_pilot/providers/amp_chart_data_provider.dart';
import 'package:energy_pilot/providers/battery_provider.dart';
import 'package:energy_pilot/providers/bluetooth_provider.dart';
import 'package:energy_pilot/screens/home.dart';
import 'package:energy_pilot/screens/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<BatteryProvider>(
          create: (_) => BatteryProvider(),
        ),
        ChangeNotifierProvider<AmpChartDataProvider>(
          create: (_) => AmpChartDataProvider(),
        ),
        ChangeNotifierProvider<BluetoothProvider>(
          create: (_) => BluetoothProvider(),
        ),
      ],
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
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
