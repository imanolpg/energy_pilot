import 'package:energy_pilot/providers/amp_chart_data_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../models/amp_chart_data.dart';

class AmpChart extends StatelessWidget {
  const AmpChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AmpChartDataProvider ampChartDataProvider =
        context.watch<AmpChartDataProvider>();

    return SfCartesianChart(
      margin: const EdgeInsets.only(top: 30, bottom: 30, left: 10, right: 10),
      series: <LineSeries<Data, int>>[
        LineSeries<Data, int>(
          dataSource: ampChartDataProvider.ampChartData,
          color: const Color.fromRGBO(192, 108, 132, 1),
          xValueMapper: (Data measurement, _) => measurement.time,
          yValueMapper: (Data measurement, _) => measurement.current,
          animationDuration: 300,
        ),
      ],
      primaryXAxis: NumericAxis(
        isVisible: false,
      ),
      primaryYAxis: NumericAxis(
        rangePadding: ChartRangePadding.none,
        axisLine: const AxisLine(width: 0),
        majorTickLines: const MajorTickLines(size: 0),
        title: AxisTitle(text: 'Corriente (Amperios)'),
        minimum: 0,
        maximum: 32,
      ),
    );
  }
}

class LiveData {
  LiveData(this.time, this.current);
  final int time;
  final num current;
}
