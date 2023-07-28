import 'package:flutter/material.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  // Sample list of tasks (replace with your actual data)
  List<StatusItem> tasks = [
    StatusItem(title: 'Task 1', isDone: false),
    StatusItem(title: 'Task 2', isDone: true),
    StatusItem(title: 'Task 3', isDone: false),
  ];

  @override
  Widget build(BuildContext context) {
    final username = "John Doe"; // Replace this with the actual username

    return Scaffold(
      backgroundColor: Color.fromARGB(
          255, 148, 95, 209), // Replace with your desired background color
      appBar: AppBar(title: Text("Dashboard")),
      body: Column(
        children: [
          Container(
            height: 70,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  "Hi, $username",
                  style: TextStyle(
                    fontFamily: "Chalkboard SE",
                    fontSize: MediaQuery.of(context).size.width * 0.09,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.settings,
                  size: 30,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 50,
                      spreadRadius: 0,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return TaskListItem(
                      task: tasks[index],
                      onCheckChanged: (value) {
                        setState(() {
                          tasks[index].isDone =
                              value ?? false; // Handle null value
                        });
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StatusItem {
  final String title;
  bool isDone;

  StatusItem({required this.title, required this.isDone});
}

class TaskListItem extends StatelessWidget {
  final StatusItem task;
  final ValueChanged<bool?> onCheckChanged; // Change to accept nullable bool

  TaskListItem({required this.task, required this.onCheckChanged});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: task.isDone,
        onChanged: onCheckChanged,
      ),
      title: Text(task.title),
    );
  }
}
