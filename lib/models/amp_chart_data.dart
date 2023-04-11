class AmpChartData {
  List<Data> ampChartData = [];
  int lastTimeAdded = 0;
  static AmpChartData? _instance;

  factory AmpChartData() => _instance ??= AmpChartData._();

  AmpChartData._();

  void addData({required int current}) {
    // check if array has elements to remove
    if (ampChartData.length > 20) {
      ampChartData.removeAt(0);
    }

    // We create a random value near the last one to simulate
    ampChartData.add(Data(lastTimeAdded++, current));
  }
}

class Data {
  int time;
  int current;
  Data(this.time, this.current);
}
