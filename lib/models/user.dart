import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

class User {
  final String _loginEndpoint = "https://energypilot.imanol.org/api/auth/login";
  final String _logoutEndpoint = "https://energypilot.imanol.org/api/auth/logout";
  final String _addCurrentEndpoint = "https://energypilot.imanol.org/api/user/addCurrent";
  final String _addVoltageEndpoint = "https://energypilot.imanol.org/api/user/addVoltage";
  final String _getPublicSaltEndpoint = "https://energypilot.imanol.org/api/auth/publicSalt";
  static String _userAuthCookie = "";

  static User? _instance;

  factory User() => _instance ??= User._();

  User._();

  String? _username;

  String get loginEndpoint => _loginEndpoint;
  String get logoutEndpoint => _logoutEndpoint;
  String get addCurrentEndpoint => _addCurrentEndpoint;
  String get addVoltageEndpoint => _addVoltageEndpoint;
  String get userAuthCookie => _userAuthCookie;
  set userAuthCookie(String value) {
    _userAuthCookie = value;
  }

  // begin getters and setters
  String? get username => _username;
  void setUsername(String? value) {
    _username = value;
  }
  // end getters and setters

  Future<dynamic> hashPasswordWithPublicSalt(String password) async {
    // fist the public salt is received
    final response = await http.get(Uri.parse(User()._getPublicSaltEndpoint));

    // check if response is successful
    if (response.statusCode == 200 && response.body != "") {
      // response ok
      String salt = response.body;

      var bytes = utf8.encode("$password$salt");
      var hash = sha256.convert(bytes).toString();

      return hash;
    } else {
      // response error
      print("Response failed");
      return (null);
    }
  }
}
