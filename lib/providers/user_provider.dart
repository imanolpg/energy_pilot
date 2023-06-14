import 'dart:convert';

import 'package:energy_pilot/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class UserProvider extends ChangeNotifier {
  final String userLoginUrl = "https://energypilot.imanol.org/api/auth/login";
  final String userLogoutUrl = "https://energypilot.imanol.org/api/auth/logout";
  final String addCurrentUrl = "https://localhost/api/user/addCurrent";
  final String addVoltageUrl = "https://localhost/api/user/addVoltaje";

  static UserProvider? _instance;

  factory UserProvider() => _instance ??= UserProvider._();

  UserProvider._();

  static String userAuthCookie = "";

  String? extractHttpOnlyCookie(String? setCookieHeader) {
    if (setCookieHeader != null) {
      var cookieParts = setCookieHeader.split(';');
      var cookieValue = cookieParts[0];
      return cookieValue;
    }
    return null;
  }

  Future<void> login(String username, String password) async {
    String hashedPassword = await User().hashPasswordWithPublicSalt(password);

    print("Username: $username");
    print("Password: $password");
    var body = jsonEncode({"userName": username, "password": hashedPassword});

    final response = await http.post(Uri.parse(userLoginUrl), headers: {"Content-Type": "application/json"}, body: body);

    // check the request status
    if (response.statusCode == 200) {
      // login correct

      // extract the httponly cookie
      String? cookie = response.headers['set-cookie'];
      print(response.headers);
      cookie = extractHttpOnlyCookie(cookie);
      if (cookie is! String) {
        print("Cookie is null");
        Fluttertoast.showToast(msg: "Error when logging");
        return;
      }
      // save the auth string
      userAuthCookie = cookie;
      print(userAuthCookie);

      Fluttertoast.showToast(msg: "Logged in");
      print("Login correct");
      User().setUsername(username);
    } else {
      // login incorrect
      Fluttertoast.showToast(msg: "Error when login");
    }
    notifyListeners();
  }

  Future<void> logout() async {
    print(userAuthCookie);
    final response = await http.post(Uri.parse(userLogoutUrl), headers: {'cookie': userAuthCookie});

    print("User status: ${response.statusCode}");

    // check request status
    if (response.statusCode == 200) {
      // logout correct
      Fluttertoast.showToast(msg: "Logged out");
      print("Logged out correctly");
      User().setUsername(null);
    } else {
      // logout incorrect
      Fluttertoast.showToast(msg: "Error when logout");
      print("Error: ${response.body}");
    }
    notifyListeners();
  }
}
