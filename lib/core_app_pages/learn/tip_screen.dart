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
    'Exercise tip 1',
    'Exercise tip 2',
    'Exercise tip 3',
    'Exercise tip 4',
    'Exercise tip 5',
    'Exercise tip 6',
    'Exercise tip 7',
    'Exercise tip 8',
    'Exercise tip 9',
    'Exercise tip 10',
    'Exercise tip 11',
    'Exercise tip 12',
    'Exercise tip 13',
    'Exercise tip 14',
    'Exercise tip 15',
    'Exercise tip 16',
    'Exercise tip 17',
    'Exercise tip 18',
    'Exercise tip 19',
    'Exercise tip 20',
    'Exercise tip 21',
    'Exercise tip 22',
    'Exercise tip 23',
    'Exercise tip 24',
    'Exercise tip 25',
  ];

  List<String> foodList = [
    'Food tip 1',
    'Food tip 2',
    'Food tip 3',
    'Food tip 4',
    'Food tip 5',
    'Food tip 6',
    'Food tip 7',
    'Food tip 8',
    'Food tip 9',
    'Food tip 10',
    'Food tip 11',
    'Food tip 12',
    'Food tip 13',
    'Food tip 14',
    'Food tip 15',
    'Food tip 16',
    'Food tip 17',
    'Food tip 18',
    'Food tip 19',
    'Food tip 20',
    'Food tip 21',
    'Food tip 22',
    'Food tip 23',
    'Food tip 24',
    'Food tip 25',
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
