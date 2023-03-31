import 'dart:math' as math;

class AmpChartData {
  List<Data> ampChartData = [];
  int lastTimeAdded = 0;

  AmpChartData();

  void addData({required int current}) {
    // check if array has elements to remove
    if (ampChartData.length > 20) {
      ampChartData.removeAt(0);
    }

    // We create a random value near the last one to simulate
    // The working thing is the next line
    // ampChartData.add(Data(time: lastTimeAdded++, current: current));
    int randomNearValue;
    if (ampChartData.isNotEmpty) {
      if (math.Random().nextBool()) {
        randomNearValue =
            ampChartData.last.current + (math.Random().nextInt(2));
        if (randomNearValue > 30) {
          randomNearValue = 30;
        }
      } else {
        randomNearValue =
            ampChartData.last.current - (math.Random().nextInt(2));
        if (randomNearValue < 0) {
          randomNearValue = 0;
        }
      }
    } else {
      randomNearValue = 10;
    }
    ampChartData.add(Data(lastTimeAdded++, randomNearValue));
  }
}

class Data {
  int time;
  int current;
  Data(this.time, this.current);
}
