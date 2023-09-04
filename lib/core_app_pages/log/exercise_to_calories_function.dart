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
    double heartRate, double weightInKg, int age, double time) {
  // Formula for calories per minute : MET * 3.5 * (body weight in kg) / 200

  // MET = oxygen consump during activity / oxygen consump at rest

  double intensityLevel = 11.5;
  double oxyAtRest = 3.5 * weightInKg + 10.1;
  double oxyDuringActivity = oxyAtRest * intensityLevel;
  double met = oxyDuringActivity / oxyAtRest;

  double activeCaloriesPerMinute = met * 3.5 * weightInKg / 200.0;
  double activeCalories = activeCaloriesPerMinute * time;
  return activeCalories;
}

double exerciseToCalories(double heightInInches, double weightInLbs,
    double minutesExercised, double bpm, int age, String gender) {
  double weightInKg = poundsToKilograms(weightInLbs);
  double heightInCm = inchesToCentimeters(heightInInches);

  double bmr = getBMRForExerciseDuration(
      weightInKg, heightInCm, age, gender, minutesExercised);
  double activeCalories =
      getActiveCalories(bpm, weightInKg, age, minutesExercised);

  return bmr + activeCalories;
}

void main() {
  double height = 71;
  double weight = 140;
  double mins = 60;
  double bpm = 0;
  int age = 70;
  print(exerciseToCalories(height, weight, mins, bpm, age, "Male"));
}
