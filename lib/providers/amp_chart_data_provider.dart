import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../models/amp_chart_data.dart';

class AmpChartDataProvider extends ChangeNotifier {
  final AmpChartData _ampChartData = AmpChartData();
  late ChartSeriesController _chartSeriesController;

  List<Data> get ampChartData => _ampChartData.ampChartData;
  ChartSeriesController get chartSeriesController => _chartSeriesController;

  Future<void> addData(int current) async {
    print("Added new data $current");
    _ampChartData.addData(current: current);
    notifyListeners();
  }
}
