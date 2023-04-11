import 'package:flutter/material.dart';

class Footer extends StatefulWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  int _selectedIndex = 1;

  void setSelectedIndex() {
    Navigator.popUntil(context, (route) {
      if (route.settings.name == '/') {
        _selectedIndex = 0;
      } else if (route.settings.name == '/user') {
        _selectedIndex = 1;
      } else {
        _selectedIndex = 0;
      }
      return true;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      switch (index) {
        case 0:
          {
            Navigator.pushReplacementNamed(context, '/');
          }
          break;
        case 1:
          {
            Navigator.pushReplacementNamed(context, '/user');
          }
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setSelectedIndex();
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }
}
