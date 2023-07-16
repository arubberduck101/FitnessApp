import 'package:flutter/material.dart';
import 'package:intro_to_flutter/core_app_pages/exercise_screen.dart';
import 'package:intro_to_flutter/wip/log_page.dart';
import './tip_screen.dart';
import './video_screen.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
