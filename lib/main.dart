import 'package:flutter/material.dart';
import 'package:intro_to_flutter/signup_screen.dart';
import 'splash_screen.dart';
import 'signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MyApp());
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
