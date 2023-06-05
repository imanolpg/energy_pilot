import 'cell.dart';

class Battery {
  String batteryId;
  double maxVoltage = 4.2;
  double minVoltage = 3.3;
  double maxAmps = 20.0;

  List<Cell> cells;

  Battery({required this.batteryId, required this.cells});
}
