import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp/screens/weather_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final _screens = [
    Center(child: Text('home'),),
    WeatherScreen(),
    Center(child: Text('settings'),),
  ];


  final _destinations = [
    NavigationDestination(icon: Icon(Icons.home_outlined), label: '',selectedIcon: Icon(Icons.home),),
    NavigationDestination(icon: Icon(Icons.wb_sunny_outlined), label: '',selectedIcon: Icon(Icons.sunny),),
    NavigationDestination(icon: Icon(Icons.settings_outlined), label: '',selectedIcon: Icon(Icons.settings),),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('HomeScreen'),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        destinations: _destinations,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        selectedIndex: _currentIndex,
        indicatorColor: Colors.transparent,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}