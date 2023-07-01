// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../core_app_pages/bottom_navigation_bar.dart';
import '../core_app_pages/dashboard_page.dart';
import 'log_page.dart';
import '../core_app_pages/learn_screen.dart';
import '../core_app_pages/profile_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    SingleChildScrollView(
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
                      color: Color.fromARGB(255, 6, 123, 26),
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
                      color: Color.fromARGB(255, 6, 123, 26),
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
                      color: Color.fromARGB(255, 6, 123, 26),
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
    LogPage2(),
    LearnPage(),
    ProfilePage(),
  ];

  final List<String> _appBarTitles = [
    'Home',
    'Log',
    'Learn',
    'Profile',
  ];

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitles[_currentIndex]),
        backgroundColor: Color.fromARGB(255, 6, 123, 26),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
    );
  }
}
