import '../../firebase/db.dart';
import 'add_food_log_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FoodLogPage extends StatefulWidget {
  const FoodLogPage({Key? key}) : super(key: key);

  @override
  State<FoodLogPage> createState() => _FoodLogPageState();
}

class _FoodLogPageState extends State<FoodLogPage> {
  List _foodLog = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLogs();
  }

  getLogs() async {
    List temp = await getFoodLog();

    setState(() {
      _foodLog = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Food Log"),
        backgroundColor: Color.fromARGB(255, 65, 117, 33),
      ),
      body: Container(
        color: const Color(0xFFC4BCB2),
        child: Center(
          child: ListView(
            children: [
              Container(
                  color: const Color.fromRGBO(227, 219, 218, 1.0),
                  height: height * .12,
                  child: Image.asset('assets/images/logo.png',
                      fit: BoxFit.fitHeight)),
              const SizedBox(
                height: 20,
              ),
              _foodLog.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: _foodLog!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                              child: ListTile(
                            leading: Text(_foodLog![index]['date']),
                            title: Text("${_foodLog![index]['food']}"),
                          ));
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(),
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        SizedBox(height: 100),
                        Center(
                          child: Text('There is not food record'),
                        ),
                      ],
                    )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFE7A563),
        child: const Icon(Icons.add_chart_outlined),
        onPressed: () {
          Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddFoodLogPage()))
              .then((value) => getLogs());
        },
      ),
    );
  }
}
