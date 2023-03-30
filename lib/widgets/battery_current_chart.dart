import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AmpChart extends StatefulWidget {
  const AmpChart({Key? key}) : super(key: key);

  @override
  State<AmpChart> createState() => _AmpChartState();
}

class _AmpChartState extends State<AmpChart> {
  late List<LiveData> chartData;
  late ChartSeriesController _chartSeriesController;

  @override
  void initState() {
    chartData = getChartData();
    // Timer.periodic(const Duration(milliseconds: 1000), updateDataSource);
    super.initState();
  }

  List<LiveData> getChartData() {
    return <LiveData>[
      LiveData(0, 20),
      LiveData(1, 16),
      LiveData(2, 21),
      LiveData(3, 20),
      LiveData(4, 30),
      LiveData(5, 4),
      LiveData(6, 7),
      LiveData(7, 13),
      LiveData(8, 13),
      LiveData(9, 18),
      LiveData(10, 21),
      LiveData(11, 20),
      LiveData(12, 17),
      LiveData(13, 2),
      LiveData(14, 19),
      LiveData(15, 8),
      LiveData(16, 14),
      LiveData(17, 23),
      LiveData(18, 15)
    ];
  }

  int time = 19;
  void updateDataSource(Timer timer) {
    chartData.add(LiveData(time++, (math.Random().nextInt(30))));
    chartData.removeAt(0);
    _chartSeriesController.updateDataSource(
        addedDataIndex: chartData.length - 1, removedDataIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      margin: const EdgeInsets.only(top: 30, bottom: 30, left: 10, right: 10),
      series: <LineSeries<LiveData, int>>[
        LineSeries<LiveData, int>(
          onRendererCreated: (ChartSeriesController controller) {
            _chartSeriesController = controller;
          },
          dataSource: chartData,
          color: const Color.fromRGBO(192, 108, 132, 1),
          xValueMapper: (LiveData measurement, _) => measurement.time,
          yValueMapper: (LiveData measurement, _) => measurement.current,
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
