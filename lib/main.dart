import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        primaryColor: Color.fromARGB(129, 6, 123, 26),
      ),
      home: const SplashScreen(),
    );
  }
}
