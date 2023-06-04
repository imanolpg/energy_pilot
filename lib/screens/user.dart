import 'package:energy_pilot/widgets/user_login.dart';
import 'package:flutter/material.dart';

import '../widgets/footer.dart';

class User extends StatelessWidget {
  const User({super.key});

  @override
  Widget build(BuildContext context) {
    //UserProvider userProvider = context.watch<UserProvider>();

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('User'),
      ),
      body: const UserLogin(),
      bottomNavigationBar: const Footer(),
    );
  }
}
