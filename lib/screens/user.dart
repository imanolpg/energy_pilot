import 'package:flutter/material.dart';

import '../widgets/footer.dart';

class User extends StatefulWidget {
  const User({Key? key}) : super(key: key);

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('User'),
      ),
      body: const Center(
        child: Text("User"),
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
