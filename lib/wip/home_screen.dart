// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intro_to_flutter/wip/home_page.dart';
import 'package:intro_to_flutter/wip/log_page.dart';
import '../core_app_pages/bottom_navigation_bar.dart';
import '../core_app_pages/learn/learn_screen.dart';
import '../core_app_pages/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    LogPage(),
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
