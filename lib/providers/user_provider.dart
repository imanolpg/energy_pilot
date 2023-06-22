import 'dart:convert';

import 'package:energy_pilot/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class UserProvider extends ChangeNotifier {
  static UserProvider? _instance;

  factory UserProvider() => _instance ??= UserProvider._();

  UserProvider._();

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

    final response = await http.post(Uri.parse(User().loginEndpoint), headers: {"Content-Type": "application/json"}, body: body);

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
      User().userAuthCookie = cookie;
      print(User().userAuthCookie);

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
    final response = await http.post(Uri.parse(User().logoutEndpoint), headers: {'cookie': User().userAuthCookie});

    print("User status: ${response.statusCode}");

    // check response status
    if (response.statusCode == 200) {
      // logout correct
      Fluttertoast.showToast(msg: "Logged out");
      print("Logged out correctly");
      User().setUsername(null);
    } else {
      // logout incorrect
      Fluttertoast.showToast(msg: "Error when logout");
      print("Error: ${response.body}");
      User().setUsername(null);
    }
    notifyListeners();
  }

  Future<void> addVoltage(int cellNumber, double voltage) async {
    print("Adding voltage");
    print("strung: ${User().username}");
    if (User().username is String) {
      final now = DateTime.now();
      String date = DateFormat('MM/dd/yyyy').format(now);
      print("sending new date: $date");
      try {
        final response = await http.post(
          Uri.parse(User().addVoltageEndpoint),
          headers: {'cookie': User().userAuthCookie, "Content-Type": "application/json"},
          body: json.encode({"date": date, "lecture": voltage, "cellNumber": cellNumber}),
        );

        // check response
        if (response.statusCode != 200) {
          print("Error when adding voltage to the API: ${response.body}");
        }
      } on Exception catch (e) {
        print("AddVoltage exception caught: $e");
      }
    }
  }

  Future<void> addCurrent(double current) async {
    if (User().username is String) {
      final now = DateTime.now();
      String date = DateFormat('MM/dd/yyyy').format(now);
      print({"date": date, "lecture": current});
      try {
        final response = await http.post(
          Uri.parse(User().addCurrentEndpoint),
          headers: {'cookie': User().userAuthCookie, "Content-Type": "application/json"},
          body: json.encode({"date": date, "lecture": current}),
        );

        // check response
        if (response.statusCode != 200) {
          print("Error when adding current to the API: ${response.body}");
        }
      } on Exception catch (e) {
        print("AddCurrent exception caught: $e");
      }
    }
  }
}
