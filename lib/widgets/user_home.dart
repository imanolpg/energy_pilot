import 'package:energy_pilot/providers/user_provider.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';

class UserHome extends StatelessWidget {
  UserHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 20.0, right: 40.0, left: 40.0),
          child: Center(
            child: Text(
              "Hello! You are logged in as ${User().username is String ? User().username : 's'}",
              style: const TextStyle(
                fontSize: 30.0,
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 20.0, right: 40.0, left: 40.0),
          child: const Center(
            child: Text(
              "You data is being uploaded to the website. Log out to stop saving information",
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(right: 16.0, left: 16.0, top: 42.0, bottom: 12.0),
          child: TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              padding: const EdgeInsets.only(right: 16.0, left: 16.0, top: 12.0, bottom: 12.0),
              textStyle: const TextStyle(fontSize: 20),
              backgroundColor: Colors.red,
            ),
            onPressed: () {
              UserProvider().logout();
            },
            child: const Text("Logout"),
          ),
        )
      ],
    );
  }
}
