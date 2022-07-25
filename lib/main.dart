import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sid_workout/settings_tab.dart';
import 'package:sid_workout/workout_tab.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'F.A.P', // Fitness Assistant for Pasricha
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const MyHomePage(title: 'Fitness Assistant for Pasricha (FAP)'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _nutritionTab() {
    return Icon(Icons.restaurant);
  }

  Widget _workoutTab() {
    return Workout();
  }

  Widget _settingsTab() {
    return Settings();
  }

  Widget _getTab(int tabIndex) {
    switch (tabIndex) {
      case 0:
        return _nutritionTab();
      case 1:
        return _workoutTab();
      case 2:
        return _settingsTab();
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.deepOrange,
      ),
      bottomNavigationBar: CupertinoTabBar(
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        activeColor: Colors.deepOrange,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: "Nutrition",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: "Workout",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
      body: _getTab(_selectedIndex),
    );
  }
}
