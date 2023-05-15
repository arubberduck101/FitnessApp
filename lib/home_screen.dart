import 'package:flutter/material.dart';
import 'package:intro_to_flutter/signup_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen();

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(
      child: Text('Home', 
            style: TextStyle(fontSize: 24))));
  }
}
