import 'package:flutter/material.dart';
import 'package:intro_to_flutter/core_app_pages/log/exercise_screen.dart';
import 'package:intro_to_flutter/core_app_pages/log/log_page.dart';
import './tip_screen.dart';
import './video_screen.dart';
import '../home/home_page.dart';
import '../../core_app_pages/profile_screen.dart';

class LearnPage extends StatefulWidget {
  const LearnPage({Key? key}) : super(key: key);

  @override
  State<LearnPage> createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
  // Function to navigate to FoodPage
  void _goToFoodPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LogPage()),
    );
  }

  // Function to navigate to ExercisePage
  void _goToExercisePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ExercisePage()),
    );
  }

  void _onTap(int index) {
    if (index == 0) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    }

    if (index == 1) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => LogPage()));
    }

    if (index == 2) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LearnPage()));
    }

    if (index == 3) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => ProfilePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Learn Page"),
        backgroundColor: Color.fromARGB(255, 65, 117, 33),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Advice
            Padding(
              padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TipPage()),
                  );
                },
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.asset(
                        'assets/images/tip.JPG',
                        height: 150,
                        width: 270,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Positioned(
                      bottom: 5.0,
                      right: 15.0,
                      child: Text(
                        'Tips',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Positioned(
                    //   top: 10.0,
                    //   left: 10.0,
                    //   child: Icon(
                    //     Icons.food_bank_rounded,
                    //     size: 130.0,
                    //     color: Colors.white,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VideoPage()),
                  );
                },
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.asset(
                        'assets/images/video.JPG',
                        height: 150,
                        width: 500,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 5.0,
                      right: 15.0,
                      child: Text(
                        'Videos',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Positioned(
                    //   top: 10.0,
                    //   left: 10.0,
                    //   child: Icon(
                    //     Icons.sports_gymnastics,
                    //     size: 130.0,
                    //     color: Colors.white,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 65, 117, 33),
        selectedItemColor: Color.fromARGB(255, 2, 50, 10),
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        onTap: _onTap,
        items: [
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
      ),
    );
  }
}
