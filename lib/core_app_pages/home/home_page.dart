import 'package:flutter/material.dart';
import 'package:intro_to_flutter/core_app_pages/profile_screen.dart';
import 'package:intro_to_flutter/core_app_pages/log/log_page.dart';
import 'progressBar.dart';
import '../../firebase/db.dart';
import '../learn/learn_screen.dart';
import '../log/exercise_to_calories_function.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String _userName = 'Placeholder';
  double currentCaloriesIn = 0;
  double currentCaloriesOut = 0;
  double BMR = 0;
  double goalCaloriesIn = 0;

  double goalCaloriesOut = 0;
  Map? userInfo;
  String? username;

  double netCalories = 0;
  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

  _getUserInfo() async {
    Map? temp = await getUserInfo();
    setState(() {
      userInfo = temp;
      _userName = userInfo!["Name"].toString();
    });

    if (userInfo?["Height"] == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (BuildContext context) => ProfilePage()),
      );
    } else {
      setCaloriesIn(userInfo!);
      setCaloriesOut(userInfo!);
    }
    BMR = getBMR(userInfo!);
    goalCaloriesIn = BMR;
    goalCaloriesOut = BMR;

    netCalories = currentCaloriesIn - (currentCaloriesOut + BMR);
  }

  void setCaloriesIn(Map userInfoMap) {
    if (userInfoMap['foodLog'].length != 0) {
      List<dynamic> foodLog = userInfoMap['foodLog'];
      double totalCalories = 0;
      DateTime now = DateTime.now();
      DateTime today = DateTime(now.year, now.month, now.day);
      for (var foodEntry in foodLog) {
        DateTime entryDate = DateTime.parse(foodEntry['date']);
        if (entryDate.year == today.year &&
            entryDate.month == today.month &&
            entryDate.day == today.day) {
          totalCalories += foodEntry['calories'];
        }
      }
      currentCaloriesIn = totalCalories;
    }
  }

  double getBMR(Map userInfo) {
    double bmr = 0;

    double weightInPounds = userInfo["Weight"];
    double weightInKg = poundsToKilograms(weightInPounds);

    double heightInInches = userInfo["Height"];
    double heightInCm = inchesToCentimeters(heightInInches);
    String gender = userInfo["Gender"];
    int age = userInfo["Age"];
    if (gender == "Male") {
      bmr =
          88.362 + (weightInKg * 13.397) + (4.799 * heightInCm) - (5.677 * age);
    } else {
      bmr =
          447.593 + (weightInKg * 9.247) + (3.098 * heightInCm) - (4.330 * age);
    }

    return bmr;
  }

  void setCaloriesOut(Map userInfoMap) {
    if (userInfoMap['Exercises'].length != 0) {
      List<dynamic> Exercises = userInfoMap['Exercises'];
      double totalCalories = 0;
      DateTime now = DateTime.now();
      DateTime today = DateTime(now.year, now.month, now.day);
      for (var exerciseEntry in Exercises) {
        DateTime entryDate = DateTime.parse(exerciseEntry['date']);
        if (entryDate.year == today.year &&
            entryDate.month == today.month &&
            entryDate.day == today.day) {
          totalCalories += exerciseEntry['Calories'];
        }
      }
      currentCaloriesOut = totalCalories;
    }
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
        title: Text("Home"),
        backgroundColor: Color.fromARGB(255, 65, 117, 33),
      ),
      backgroundColor: Color.fromARGB(255, 54, 54, 54),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                "Welcome, $_userName",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 50.0),
              Text(
                "Calories In",
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              CustomProgressBar(
                  currentLevel: currentCaloriesIn, goal: goalCaloriesIn),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  "Current Calories In: $currentCaloriesIn",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  "Goal Calories In: $goalCaloriesIn",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              if (currentCaloriesIn >= goalCaloriesIn)
                Text(
                  "Congratulations! You met your calories in goal",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              if (currentCaloriesIn < goalCaloriesIn)
                Text(
                  "You should eat more",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
              ),
              SizedBox(height: 32),
              Text(
                "Calories Out",
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              CustomProgressBar(
                  currentLevel: currentCaloriesOut, goal: goalCaloriesOut),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  "Current Calories Out: $currentCaloriesOut",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  "Goal Calories Out: $goalCaloriesOut",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              if (currentCaloriesOut > goalCaloriesOut - 100 &&
                  currentCaloriesOut < goalCaloriesOut + 100)
                Text(
                  "Congratulations, you met your calorie outtake goal",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              if (currentCaloriesOut <= goalCaloriesOut - 100)
                Text(
                  "try to exercise more",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              if (currentCaloriesOut >= goalCaloriesOut + 100)
                Text(
                  "you are exersise too much",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              SizedBox(height: 50),
              if (netCalories > 0)
                Text(
                  "you gained " + netCalories.toString() + " extra calories",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              if (netCalories < 0)
                Text(
                  "you burned " + netCalories.toString() + " extra calories",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              if (netCalories == 0)
                Text(
                  "Good control of your calories!",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
            ],
          ),
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
