import 'package:Manager/screens/home.dart';
import 'package:Manager/screens/login.dart';
import 'package:Manager/screens/settings.dart';
import 'package:Manager/screens/stats.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'login': (context) => LoginScreen(),
        'home': (context) => HomeScreen(),
        'stats': (context) => StatsScreen(),
        'settings': (context) => SettingsScreen(),
      },

      title: 'Webcast Manager',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
