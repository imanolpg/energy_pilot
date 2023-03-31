class AmpChartData {
  List<Data> ampChartData = [
    Data(time: 0, current: 20),
    Data(time: 1, current: 16),
    Data(time: 2, current: 21),
    Data(time: 3, current: 20),
    Data(time: 4, current: 30),
    Data(time: 5, current: 4),
    Data(time: 6, current: 7),
    Data(time: 7, current: 13),
    Data(time: 8, current: 13),
    Data(time: 9, current: 18),
    Data(time: 10, current: 21),
    Data(time: 11, current: 20),
    Data(time: 12, current: 17),
    Data(time: 13, current: 2),
    Data(time: 14, current: 19),
    Data(time: 15, current: 8),
    Data(time: 16, current: 14),
    Data(time: 17, current: 23),
    Data(time: 18, current: 15)
  ];

  int lastTimeAdded = 18;

  AmpChartData();

  void addData({required int current}) {
    ampChartData.removeAt(0);
    ampChartData.add(Data(time: lastTimeAdded++, current: current));
  }
}

class Data {
  int time;
  int current;
  Data({required this.time, required this.current});
}
