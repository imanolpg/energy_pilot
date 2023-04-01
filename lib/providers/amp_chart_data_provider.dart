import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../models/amp_chart_data.dart';

class AmpChartDataProvider extends ChangeNotifier {
  final AmpChartData _ampChartData = AmpChartData();
  late ChartSeriesController _chartSeriesController;

  AmpChartDataProvider() {
    Timer.periodic(
        const Duration(milliseconds: 100), (_) => addData(current: 12));
  }

  List<Data> get ampChartData => _ampChartData.ampChartData;
  ChartSeriesController get chartSeriesController => _chartSeriesController;

  Future<void> addData({required int current}) async {
    _ampChartData.addData(current: current);
    notifyListeners();
  }
}
