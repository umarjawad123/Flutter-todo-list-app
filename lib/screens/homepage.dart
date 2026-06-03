import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/utils/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> tasks = [];
  TextEditingController taskscontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'To-Do List',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.primary,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 40,
              bottom: 10,
            ),
            child: TextField(
              controller: taskscontroller,
              decoration: InputDecoration(
                label: Text('Enter a new task'),
                filled: true,
                fillColor: Colors.white,
                border: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppColors.primary, width: 1),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
              bottom: 10,
            ),
            child: SizedBox(
              height: 40,
              width: double.infinity,

              child: ElevatedButton(
                onPressed: addTasks,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  'Add Task',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: tasks.isEmpty
                ? Center(
                    child: Text(
                      'No Tasks yet!',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(
                      top: 40,
                      left: 10,
                      right: 10,
                    ),
                    child: ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            leading: IconButton(
                              onPressed: () {
                                setState(() {
                                  tasks[index]["isDone"] =
                                      !tasks[index]["isDone"];
                                });
                              },
                              icon: tasks[index]["isDone"]
                                  ? const Icon(Icons.check_circle)
                                  : const Icon(Icons.circle_outlined),
                              color: AppColors.accent,
                            ),
                            title: Text(
                              tasks[index]["task"],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                decoration: tasks[index]["isDone"]
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                            trailing: IconButton(
                              onPressed: () => deleteTasks(index),
                              icon: Icon(Icons.delete),
                              color: Colors.red,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  void addTasks() {
    if (taskscontroller.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Please enter a task")));

      return;
    }

    setState(() {
      tasks.add({"task": taskscontroller.text.trim(), "isDone": false});
    });

    saveTasks();

    taskscontroller.clear();
  }

  void deleteTasks(int index) {
    setState(() {
      tasks.removeAt(index);
    });
    saveTasks();
  }

  // shared_preferences SaveTasks Logic
  void saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> encodedTasks = tasks.map((task) => jsonEncode(task)).toList();
    prefs.setStringList("myTasks", encodedTasks);
  }

  // shared_preferences LoadTasks logic
  void loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> savedTasks = prefs.getStringList("myTasks") ?? [];
    setState(() {
      tasks = savedTasks
          .map((tasks) => Map<String, dynamic>.from(jsonDecode(tasks)))
          .toList();
    });
  }
}
