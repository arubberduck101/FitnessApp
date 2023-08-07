import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TipPage extends StatefulWidget {
  const TipPage({Key? key}) : super(key: key);

  @override
  State<TipPage> createState() => _TipPageState();
}

class _TipPageState extends State<TipPage> {
  // Hardcoded list of 25 exercise tips
  List<String> exerciseList = [
    'Start slow, build consistency, avoid overexertion.',
    'Mix cardio, strength, flexibility for balanced workouts.',
    'Prioritize form to prevent injuries during exercises.',
    'Set realistic goals, track progress, celebrate achievements.',
    'Warm up and cool down to optimize workout effectiveness.',
    'Stay hydrated; water fuels your body during workouts.',
    'Vary routines to keep workouts engaging and effective.',
    'Rest days are crucial for muscle recovery and growth.',
    'Incorporate proper nutrition to support fitness goals.',
    'Listen to your body; adjust intensity and rest when needed.',
    'Stay consistent with your workout routine for lasting results.',
    'Include both aerobic and strength exercises for well-rounded fitness.',
    'Prioritize stretching to maintain flexibility and prevent muscle tightness.',
    'Gradually increase weights and reps to avoid plateaus in progress.',
    'Use proper footwear to support your feet during various activities.',
    'Practice deep breathing to enhance oxygen flow during workouts.',
    'Incorporate balance exercises to improve stability and coordination.',
    'Focus on core strength to support posture and overall body stability.',
    'Engage in activities you enjoy to make exercising a fun habit.',
    'Mix up high-intensity and low-intensity workouts for variety.',
    'Get adequate sleep; rest is essential for muscle repair.',
    'Stay mindful of your body signals don not push through pain.',
    'Hydrate before, during, and after workouts to stay energized.',
    'Find a workout buddy for motivation and mutual accountability.',
    'Consider cross-training to prevent overuse injuries and boredom.',
  ];

  List<String> foodList = [
    'Hydrate: Drink water before meals for better digestion and satiety.',
    'Colorful Plate: Include diverse veggies for a balanced nutrient intake.',
    'Portion Control: Enjoy treats, but in moderation for a healthy diet.',
    'Protein Power: Opt for lean sources to aid muscle growth and repair.',
    'Whole Grains: Choose whole over refined for higher fiber and nutrients.',
    'Mindful Eating: Eat slowly, savor flavors, and recognize fullness cues.',
    'Healthy Fats: Prioritize avocados, nuts, and olive oil for heart health.',
    'Sugar Awareness: Limit added sugars to prevent energy crashes and cravings.',
    'Cook at Home: Control ingredients, portions, and cooking methods easily.',
    'Balanced Meals: Combine carbs, proteins, fats for sustained energy and satisfaction.',
    'Fiber Boost: Choose beans, fruits, and whole grains for better digestion.',
    'Mix Nutrients: Combine different food groups for a well-rounded meal.',
    'Snack Wisely: Reach for nuts, yogurt, or fruits for healthier snacking.',
    'Limit Sodium: Reduce salt intake to support heart and kidney health.',
    'Breakfast Fuel: Start the day with protein and complex carbs for energy.',
    'Diverse Proteins: Include fish, eggs, and plant-based sources for variety.',
    'Veggie Swaps: Use zucchini noodles or cauliflower rice as healthier alternatives.',
    'Read Labels: Check ingredient lists for hidden sugars and additives.',
    'Herbal Spices: Flavor with turmeric, cinnamon, and ginger for health benefits.',
    'Mindful Indulgence: Savor a small treat guilt-free every now and then.',
    'Prebiotics & Probiotics: Consume yogurt, kefir, and fiber-rich foods for gut health.',
    'Frozen Fruits: Stock up for smoothies and a nutritious dessert option.',
    'Listen to Hunger: Eat when hungry, stop when satisfied, not overly full.',
    'Grilled or Baked: Opt for cooking methods that use less added fats.',
    'Homemade Dressing: Control ingredients and avoid excess sugars in salads.',
    'Eat when hungry',
  ];

  // Function to generate 3 random numbers within the range of 0 to (lengthOfList - 1)
  List<int> generate3UniqueRandomNumbers(int lengthOfList) {
    if (lengthOfList < 3) {
      // If the list length is less than 3, return all indices from 0 to (lengthOfList - 1).
      return List<int>.generate(lengthOfList, (index) => index);
    }

    Set<int> randomIndices = {};
    Random random = Random();

    while (randomIndices.length < 3 && randomIndices.length < lengthOfList) {
      int randomNumber = random.nextInt(lengthOfList);
      if (!randomIndices.contains(randomNumber)) {
        randomIndices.add(randomNumber);
      }
    }

    return randomIndices.toList();
  }

  // Function to generate a map with 3 random exercise tips
  Map<String, List<String>> generateExerciseTipMap() {
    List<int> randomIndices = generate3UniqueRandomNumbers(exerciseList.length);
    List<String> randomExerciseTips =
        randomIndices.map((index) => exerciseList[index]).toList();
    return {'exercise': randomExerciseTips};
  }

  // Function to generate a map with 3 random food tips
  Map<String, List<String>> generateFoodTipMap() {
    List<int> randomIndices = generate3UniqueRandomNumbers(foodList.length);
    List<String> randomFoodTips =
        randomIndices.map((index) => foodList[index]).toList();
    return {'food': randomFoodTips};
  }

  List<String> randomExerciseTips = [];
  List<String> randomFoodTips = [];

  @override
  void initState() {
    super.initState();
    // Generate the random exercise and food tips when the widget initializes.
    randomExerciseTips = generateExerciseTipMap()['exercise']!;
    randomFoodTips = generateFoodTipMap()['food']!;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Tip Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: ListView(
            children: [
              Container(
                height: height * 0.4,
                padding: const EdgeInsets.all(10),
                color: const Color(0xFFDABA7C),
                child: Column(
                  children: [
                    Text(
                      'Exercise Tips',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: 3,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: ListTile(
                            title: Text(randomExerciseTips[index]),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: height * 0.4,
                padding: const EdgeInsets.all(10),
                color: const Color(0xFFA0D794),
                child: Column(
                  children: [
                    Text(
                      'Food/Diet Tips',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: 3,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: ListTile(
                            title: Text(randomFoodTips[index]),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
