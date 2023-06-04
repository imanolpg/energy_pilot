import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier {
  final String userLoginUrl = "https://energypilot.imanol.org/api/auth/login";
  final String userLogoutUrl = "https://energypilot.imanol.org/api/auth/logout";
  final String addCurrentUrl = "https://localhost/api/user/addCurrent";
  final String addVoltageUrl = "https://localhost/api/user/addVoltaje";

  static UserProvider? _instance;

  factory UserProvider() => _instance ??= UserProvider._();

  UserProvider._();

  Future<void> login(String username, String password) async {}
}
