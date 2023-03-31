import 'dart:async';
import 'dart:math' as math;

import 'package:energy_pilot/providers/amp_chart_data_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../models/amp_chart_data.dart';

class AmpChart extends StatefulWidget {
  const AmpChart({Key? key}) : super(key: key);

  @override
  State<AmpChart> createState() => _AmpChartState();
}

class _AmpChartState extends State<AmpChart> {
  late AmpChartDataProvider ampChartDataProvider;
  late ChartSeriesController _chartSeriesController;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ampChartDataProvider =
          Provider.of<AmpChartDataProvider>(context, listen: false);
    });
    Timer.periodic(const Duration(milliseconds: 1000), updateDataSource);
    super.initState();
  }

  int time = 19;
  void updateDataSource(Timer timer) {
    if (ampChartDataProvider != null) {
      ampChartDataProvider.addData(current: (math.Random().nextInt(30)));
      _chartSeriesController.updateDataSource(
          addedDataIndex:
              ampChartDataProvider.ampChartData.ampChartData.length - 1,
          removedDataIndex: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    AmpChartDataProvider ampChartDataProvider =
        context.watch<AmpChartDataProvider>();

    return SfCartesianChart(
      margin: const EdgeInsets.only(top: 30, bottom: 30, left: 10, right: 10),
      series: <LineSeries<Data, int>>[
        LineSeries<Data, int>(
          onRendererCreated: (ChartSeriesController controller) {
            _chartSeriesController = controller;
          },
          dataSource: ampChartDataProvider.ampChartData.ampChartData,
          color: const Color.fromRGBO(192, 108, 132, 1),
          xValueMapper: (Data measurement, _) => measurement.time,
          yValueMapper: (Data measurement, _) => measurement.current,
        ),
      ],
      primaryXAxis: NumericAxis(
        majorGridLines: const MajorGridLines(width: 0),
        edgeLabelPlacement: EdgeLabelPlacement.shift,
        interval: 3,
        title: AxisTitle(text: 'Tiempo (segundos)'),
      ),
      primaryYAxis: NumericAxis(
        axisLine: const AxisLine(width: 0),
        majorTickLines: const MajorTickLines(size: 0),
        title: AxisTitle(text: 'Corriente (Amperios)'),
      ),
    );
  }
}

class LiveData {
  LiveData(this.time, this.current);
  final int time;
  final num current;
}
