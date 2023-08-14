// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intro_to_flutter/wip/home_page.dart';
import 'package:intro_to_flutter/wip/log_page.dart';
import '../core_app_pages/bottom_navigation_bar.dart';
import '../core_app_pages/learn/learn_screen.dart';
import '../core_app_pages/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.userUID}) : super(key: key);

  final String userUID;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  late List<Widget> _pages; // Declare the _pages list

  final List<String> _appBarTitles = [
    'Home',
    'Log',
    'Learn',
    'Profile',
  ];

  @override
  void initState() {
    super.initState();

    _pages = [
      HomePage(
        userUID: widget.userUID,
      ),
      LogPage(),
      LearnPage(),
      ProfilePage(),
    ];
  }

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
        backgroundColor: Color.fromARGB(255, 65, 117, 33),
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
