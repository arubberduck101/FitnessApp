import 'package:flutter/material.dart';
import '../core_app_pages/exercise_screen.dart';
import '../core_app_pages/food_screen.dart';
import 'log_screen.dart';
import '../core_app_pages/learn_screen.dart';
import '../core_app_pages/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen();

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

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

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
    } else {
      NavigationService.navigateToAndRemoveUntil(_pages[_selectedIndex]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitles[_selectedIndex]),
      ),
      body: Navigator(
        key: NavigationService.navigatorKey,
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(builder: (BuildContext context) {
            return _pages[_selectedIndex];
          });
        },
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.blue, // Set the desired canvas color to blue
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Log',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.lightbulb),
              label: 'Learn',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped, // Set the fixed color to blue
          backgroundColor: Colors.blue,
          selectedItemColor: Colors.blue[700],
          unselectedItemColor: Colors.white,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static void navigateTo(Widget destination) {
    navigatorKey.currentState
        ?.push(MaterialPageRoute(builder: (_) => destination));
  }

  static void navigateToReplacement(Widget destination) {
    navigatorKey.currentState
        ?.pushReplacement(MaterialPageRoute(builder: (_) => destination));
  }

  static void navigateToAndRemoveUntil(Widget destination) {
    navigatorKey.currentState?.pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => destination),
        (Route<dynamic> route) => false);
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DashboardSection(),
          StatusSection(),
          RecommendationSection(),
        ],
      ),
    );
  }
}

class DashboardSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dashboard',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          // This is where you would add your dashboard contents
        ],
      ),
    );
  }
}

class StatusSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Status',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          // This is where you would add your status contents
        ],
      ),
    );
  }
}

class RecommendationSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recommendations',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          // This is where you would add your recommendation contents
        ],
      ),
    );
  }
}
