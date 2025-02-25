import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Poppins",
      ),
      home: DayPlannerPage(),
    );
  }
}

class DayPlannerPage extends StatefulWidget {
  @override
  _DayPlannerPageState createState() => _DayPlannerPageState();
}

class _DayPlannerPageState extends State<DayPlannerPage> {
  List<Task> tasks = [
    Task("Meet for hackathon", "10:00 AM"),
    Task("Draft email to HOD", "1:00 PM"),
    Task("SC test", "6:00 PM"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.arrow_back, color: Colors.black, size: 28),
                  SizedBox(width: 10),
                  Text("Day Planner",
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.w600)),
                ],
              ),
              SizedBox(height: 8),
              Text("Every plan is a step to success, stay unstoppable",
                  style: TextStyle(fontSize: 19, color: Colors.grey)),
              SizedBox(height: 18),
              _buildDateSelector(),
              SizedBox(height: 18),
              Text("Today",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600)),
              Text("Feb, 2025",
                  style: TextStyle(color: Colors.grey, fontSize: 24)),
              SizedBox(height: 18),
              Expanded(child: _buildTaskList()),
              SizedBox(height: 8),
              _buildAddTaskButton(),
              SizedBox(height: 12),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: "Planner"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
    );
  }

  Widget _buildDateSelector() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _dateCard("Mon", "24", selected: true),
          _dateCard("Tue", "25"),
          _dateCard("Wed", "26"),
          _dateCard("Thu", "27"),
          _dateCard("Fri", "28"),
          _dateCard("Sat", "29"),
          _dateCard("Sun", "30"),
        ],
      ),
    );
  }

  Widget _dateCard(String day, String date, {bool selected = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: selected ? Colors.blue : Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            children: [
              Text(day,
                  style: TextStyle(
                      color: selected ? Colors.white : Colors.black,
                      fontSize: 18)),
              Text(date,
                  style: TextStyle(
                      color: selected ? Colors.white : Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTaskList() {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return _buildTaskCard(tasks[index], index);
      },
    );
  }

  Widget _buildAddTaskButton() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.amber[50],
      child: InkWell(
        onTap: () async {
          Task? newTask = await _showAddTaskDialog(context);
          if (newTask != null) {
            setState(() {
              tasks.add(newTask);
            });
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Add new tasks to today’s work",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
              Icon(Icons.add, color: Colors.black, size: 28),
            ],
          ),
        ),
      ),
    );
  }

  Future<Task?> _showAddTaskDialog(BuildContext context) async {
    TextEditingController titleController = TextEditingController();
    TextEditingController timeController = TextEditingController();

    return showDialog<Task>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add New Task"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: "Task Title")),
              TextField(
                  controller: timeController,
                  decoration:
                      InputDecoration(labelText: "Time (e.g., 10:00 AM)")),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context), child: Text("Cancel")),
            TextButton(
              onPressed: () {
                if (titleController.text.isNotEmpty &&
                    timeController.text.isNotEmpty) {
                  Navigator.pop(
                      context, Task(titleController.text, timeController.text));
                }
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTaskCard(Task task, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Column(
            children: [
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                width: 2,
                height: 60,
                color: Colors.amber,
              ),
            ],
          ),
          SizedBox(width: 12),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.amber[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: task.isCompleted,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        onChanged: (value) {
                          setState(() {
                            task.isCompleted = value!;
                          });
                          Future.delayed(Duration(milliseconds: 300), () {
                            setState(() {
                              tasks.removeAt(index);
                            });
                          });
                        },
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(task.title,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500)),
                          Text(task.time,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 18)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Task {
  String title;
  String time;
  bool isCompleted;
  Task(this.title, this.time, {this.isCompleted = false});
}
