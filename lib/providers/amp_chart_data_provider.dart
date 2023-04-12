import 'package:flutter/foundation.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../models/amp_chart_data.dart';

class AmpChartDataProvider extends ChangeNotifier {
  final AmpChartData _ampChartData = AmpChartData();
  late ChartSeriesController _chartSeriesController;
  static AmpChartDataProvider? _instance;

  AmpChartDataProvider._();

  factory AmpChartDataProvider() => _instance ??= AmpChartDataProvider._();

  List<Data> get ampChartData => _ampChartData.ampChartData;
  ChartSeriesController get chartSeriesController => _chartSeriesController;

  void addData(int current) async {
    _ampChartData.addData(current: current);
    notifyListeners();
  }
}
