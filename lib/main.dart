import 'package:flutter/material.dart';
import 'package:intro_to_flutter/signup_screen.dart';
import 'splash_screen.dart';
import 'signup_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  //widget

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Excerise Project",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
