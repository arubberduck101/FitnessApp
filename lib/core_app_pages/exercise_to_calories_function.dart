import 'dart:math';

double poundsToKilograms(double weightInLbs) {
  return weightInLbs * 0.45359237;
}

double inchesToCentimeters(double heightInInches) {
  return heightInInches * 2.54;
}

double getBMRForExerciseDuration(double weightInLbs, double heightInInches,
    int age, String gender, double exerciseDurationInMinutes) {
  double weightInKg = poundsToKilograms(weightInLbs);
  double heightInCm = inchesToCentimeters(heightInInches);

  double bmr;

  if (gender == "Male") {
    bmr = 88.362 + (weightInKg * 13.397) + (4.799 * heightInCm) - (5.677 * age);
  } else {
    bmr = 447.593 + (weightInKg * 9.247) + (3.098 * heightInCm) - (4.330 * age);
  }

  double BMRForExerciseDuration = (exerciseDurationInMinutes / 14400.0) * bmr;
  return BMRForExerciseDuration;
}

double getActiveCalories(
    double heartRate, double weightInLbs, int age, double time) {
  double weightInKg = poundsToKilograms(weightInLbs);
  double calories =
      (((heartRate - 80) * 1.0) / ((220 - age) * 1.0)) * weightInKg;
  double totalCalories = calories * time;
  return totalCalories;
}

double exerciseToCalories(double heightInInches, double weightInLbs,
    double minutesExercised, double bpm, int age, String gender) {
  double calories;

  calories = getBMRForExerciseDuration(
          weightInLbs, heightInInches, age, gender, minutesExercised) +
      getActiveCalories(bpm, weightInLbs, age, minutesExercised);

  return calories;
}

void main() {
  print(exerciseToCalories(70, 147, 60, 110, 20, "Male"));
}
