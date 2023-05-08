import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen();

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Color.fromARGB(129, 6, 123, 26),
            body: Padding(
                padding: const EdgeInsets.all(100.0),
                child: Container(
                  height: 180,
                  width: 180,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("images/fitnessapp.png"))),
                ))));
  }
}

  
//T_T