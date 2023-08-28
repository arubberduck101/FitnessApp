import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intro_to_flutter/wip/log_page.dart';
import './exercise_to_calories_function.dart';

class ExercisePage extends StatefulWidget {
  const ExercisePage({Key? key}) : super(key: key);

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}
//you stink

class _ExercisePageState extends State<ExercisePage> {
  String? textInput1;
  String? dropdownValue1;
  String? dropdownValue2;
  String? dropdownValue3;

  final List<String> exercises = [
    'Running',
    'Swimming',
    'Walking',
    'Hiking',
    'Spinning',
    'Kickboxing',
    'Skiing',
    'Jumping',
  ];

  final List<String> time = [
    '15 minutes',
    '30 minutes',
    '45 minutes',
    '1 hour',
  ];

  final List<String> bpm = [
    '50+ bpm',
    '60+ bpm',
    '70+ bpm',
    '80+ bpm',
    '90+ bpm',
  ];

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('Users');

  void submitToFirestore() {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      print('Not authenticated user.');
      return;
    }

    if (dropdownValue3 == null ||
        dropdownValue1 == null ||
        dropdownValue2 == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Missing Fields'),
            content: Text('Please fill out all the fields.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    final userID = currentUser.uid;
    double calories = 0;

//banana
    int age = 0;
    double weight = 0;
    double height = 0;
    String gender = " ";
    try {
      usersCollection.doc(userID).get().then((snapshot) {
        if (snapshot.exists) {
          // If the document exists, get the existing 'Exercises' array
          int? ageFromFireStore =
              (snapshot.data() as Map<String, dynamic>?)?['Age'] as int?;
          print("Values updated to Firestore successfully!");
          age = ageFromFireStore! as int;
          double? weightFromFireStore =
              (snapshot.data() as Map<String, dynamic>?)?['Weight'] as double?;
          print("Values updated to Firestore successfully!");
          weight = weightFromFireStore!;
          double? heightFromFireStore =
              (snapshot.data() as Map<String, dynamic>?)?['Height'] as double?;
          print("Values updated to Firestore successfully!");
          height = heightFromFireStore!;
          String? genderFromFireStore =
              (snapshot.data() as Map<String, dynamic>?)?['Gender'] as String?;
          print("Values updated to Firestore successfully!");
          gender = genderFromFireStore!;
        }
      });
    } catch (e) {
      print("Failed to update values to Firestore.");
    }

    // (double heightInInches, double weightInLbs,
    // double minutesExercised, double bpm, int age, String gender)
    // double duration

    double duration = 0;

    if (dropdownValue1 == "15 minutes") {
      duration = 15;
    } else if (dropdownValue1 == "30 minutes") {
      duration = 30;
    } else if (dropdownValue1 == "45 minutes") {
      duration = 45;
    } else {
      duration = 60;
    }

    String bpmNumberString = dropdownValue2!.substring(0, 2);

    double bpmNumberDouble = double.parse(bpmNumberString);

    print(bpmNumberDouble.toString());

    calories = exerciseToCalories(
        height, weight, duration, bpmNumberDouble, age, gender);
    //I am a banana
    //how s your day

    final Map<String, dynamic> newExerciseData = {
      'Exercise': dropdownValue3,
      'Duration': dropdownValue1,
      'BPM': dropdownValue2,
      'Calories': calories

      //:(
    };
    try {
      // Fetch the existing 'Exercises' data from Firestore
      usersCollection.doc(userID).get().then((snapshot) {
        if (snapshot.exists) {
          // If the document exists, get the existing 'Exercises' array
          List<dynamic>? existingExercisesArray = (snapshot.data()
              as Map<String, dynamic>?)?['Exercises'] as List<dynamic>?;

          if (existingExercisesArray != null) {
            // If the 'Exercises' array already exists, append the new exercise data to it
            existingExercisesArray.add(newExerciseData);
          } else {
            // If the 'Exercises' array does not exist, create a new array with the new exercise data
            existingExercisesArray = [newExerciseData];
          }

          // Update the 'Exercises' field in Firestore with the updated array
          usersCollection.doc(userID).set(
            {'Exercises': existingExercisesArray},
            SetOptions(merge: true),
          );

          print("Values updated to Firestore successfully!");
          Navigator.pop(context);
        } else {
          // If the document doesn't exist, create a new document with the 'Exercises' array
          usersCollection.doc(userID).set(
            {
              'Exercises': [newExerciseData]
            },
            SetOptions(merge: true),
          );

          print("Values added to Firestore successfully!");
          Navigator.pop(context);
        }
      });
    } catch (e) {
      print("Failed to update values to Firestore.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exercises"),
        backgroundColor: Color.fromARGB(255, 65, 117, 33),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Exercise(s)",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              DropdownButton<String>(
                value: dropdownValue3,
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue3 = newValue!;
                  });
                },
                items: exercises.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 20.0),
              Text(
                "Duration",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              DropdownButton<String>(
                value: dropdownValue1,
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue1 = newValue!;
                  });
                },
                items: time.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 20.0),
              Text(
                "Performance",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              DropdownButton<String>(
                value: dropdownValue2,
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue2 = newValue!;
                  });
                },
                items: bpm.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  submitToFirestore();
                },
                child: Text(
                  'Submit',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
