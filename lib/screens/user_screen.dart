import 'package:energy_pilot/models/user.dart';
import 'package:energy_pilot/widgets/user_home.dart';
import 'package:energy_pilot/widgets/user_login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../widgets/footer.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.watch<UserProvider>();

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('User'),
      ),
      body: User().username is String ? UserHome() : UserLogin(),
      bottomNavigationBar: const Footer(),
    );
  }
}
