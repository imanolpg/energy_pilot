import 'package:flutter/material.dart';

class UserLogin extends StatelessWidget {
  const UserLogin({Key? key}) : super(key: key);

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
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "User",
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: TextField(
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Password",
            ),
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
            onPressed: () {},
            child: const Text("Login"),
          ),
        ),
      ],
    );
  }
}
