import 'package:flutter/foundation.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../models/amp_chart_data.dart';

class AmpChartDataProvider extends ChangeNotifier {
  final AmpChartData _ampChartData = AmpChartData();
  late ChartSeriesController chartSeriesController;

  AmpChartDataProvider();

  AmpChartData get ampChartData => _ampChartData;

  Future<void> addData({required int current}) async {
    _ampChartData.addData(current: current);
  }
}
