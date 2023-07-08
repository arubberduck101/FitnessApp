import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Dashboard
            Padding(
              padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
              child: GestureDetector(
                onTap: () {},
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                        height: 150,
                        color: Color.fromARGB(255, 65, 117, 33),
                      ),
                    ),
                    Positioned(
                      bottom: 5.0,
                      right: 15.0,
                      child: Text(
                        'Dashboard',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10.0,
                      left: 10.0,
                      child: Icon(
                        Icons.notes_rounded,
                        size: 130.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Status
            Padding(
              padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
              child: GestureDetector(
                onTap: () {},
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                        height: 150,
                        color: Color.fromARGB(255, 65, 117, 33),
                      ),
                    ),
                    Positioned(
                      bottom: 5.0,
                      right: 15.0,
                      child: Text(
                        'Status',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10.0,
                      left: 10.0,
                      child: Icon(
                        Icons.notes_rounded,
                        size: 130.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Recommendations
            Padding(
              padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
              child: GestureDetector(
                onTap: () {},
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                        height: 150,
                        color: Color.fromARGB(255, 65, 117, 33),
                      ),
                    ),
                    Positioned(
                      bottom: 5.0,
                      right: 15.0,
                      child: Text(
                        'Recommendations',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10.0,
                      left: 10.0,
                      child: Icon(
                        Icons.notes_rounded,
                        size: 130.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
