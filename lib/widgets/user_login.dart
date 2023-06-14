import 'package:energy_pilot/providers/user_provider.dart';
import 'package:flutter/material.dart';

class UserLogin extends StatelessWidget {
  UserLogin({Key? key}) : super(key: key);

  // username and password fields
  String username = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(
            bottom: 20.0,
          ),
          child: const Center(
            child: Text(
              "Login",
              style: TextStyle(
                fontSize: 35.0,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: TextField(
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "User",
            ),
            onChanged: (text) {
              username = text;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: TextField(
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Password",
            ),
            onChanged: (text) {
              password = text;
            },
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          width: 200,
          child: TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              padding: const EdgeInsets.all(16.0),
              textStyle: const TextStyle(fontSize: 20),
              backgroundColor: Colors.blueAccent,
            ),
            onPressed: () {
              UserProvider().login(username, password);
            },
            child: const Text("Login"),
          ),
        ),
      ],
    );
  }
}
