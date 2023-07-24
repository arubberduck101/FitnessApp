import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TipPage extends StatefulWidget {
  const TipPage({Key? key}) : super(key: key);

  @override
  State<TipPage> createState() => _TipPageState();
}

class _TipPageState extends State<TipPage> {
  Map<String, List<String>> tips = {
    'exercise': ['tip1', 'tip2', 'tip3'],
    'food': ['tip1', 'tip2', 'tip3']
  };

// only display 3 tips to the user

// make another List with all the tips
  // exercise tip list - Harry
  // food tip list - Morgan
// every time tip screen is loaded, display 3 random tips from the list
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        // Add the AppBar with a back button
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
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
                      itemCount: tips['exercise']!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: ListTile(
                            title: Text(tips['exercise']![index]),
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
                      itemCount: tips['food']!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: ListTile(
                            title: Text(tips['food']![index]),
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
