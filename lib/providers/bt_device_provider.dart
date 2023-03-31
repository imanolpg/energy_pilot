import 'package:flutter/foundation.dart';

import '../models/bt_device.dart';

class BtDeviceProvider extends ChangeNotifier {
  late BtDevice _btDevice;

  get btDevice => _btDevice;

  Future<void> setBtDevice({required BtDevice btDevice}) async {
    _btDevice = btDevice;
  }
}
