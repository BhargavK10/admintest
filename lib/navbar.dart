import 'package:admintest/homepage.dart';
import 'package:admintest/profile.dart';
import 'package:admintest/stats.dart';
import 'package:flutter/material.dart';
import 'topbar.dart';
// import 'homepage.dart';
// import 'settingspage.dart';
// import 'profilepage.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    HomePage(),
    StatisticsPage(),
    ProfilePage()
  ];

  void _onItemTapped(int index){
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topBar(context, 'Dashboard'),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        backgroundColor: const Color.fromARGB(255, 98, 98, 98),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Statistics'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
        unselectedItemColor: Colors.black,
      ),
    );
  }
}