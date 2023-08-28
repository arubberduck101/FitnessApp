import 'package:flutter/material.dart';

class CustomProgressBar extends StatelessWidget {
  final double currentLevel;
  final double goal;

  CustomProgressBar({required this.currentLevel, required this.goal});

  double calculateProgress(double currentLevel, double goal) {
    if (currentLevel > goal) {
      return 1.0;
    }
    return currentLevel / goal;
  }

  @override
  Widget build(BuildContext context) {
    double progressPercentage = calculateProgress(currentLevel, goal);

    return Container(
      height: 40.0,
      width: goal.toDouble(), // Set a fixed width for the progress bar
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.black, width: 2.0),
      ),
      child: FractionallySizedBox(
        widthFactor: progressPercentage,
        alignment: Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
