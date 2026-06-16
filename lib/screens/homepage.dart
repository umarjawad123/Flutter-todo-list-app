import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/providers/task_provider.dart';
import 'package:todo_list/utils/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController taskscontroller = TextEditingController();

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
                onPressed: () async {
                  if (taskscontroller.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please enter a task")),
                    );

                    return;
                  }

                  await context.read<TaskProvider>().addTasks(
                    taskscontroller.text,
                  );

                  taskscontroller.clear();
                },
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
            child: Consumer<TaskProvider>(
              builder: (context, provider, child) {
                return provider.tasks.isEmpty
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
                        child: Consumer<TaskProvider>(
                          builder: (context, provider, child) {
                            return ListView.builder(
                              itemCount: provider.tasks.length,

                              itemBuilder: (context, index) {
                                final task = provider.tasks[index];

                                return Card(
                                  child: ListTile(
                                    leading: IconButton(
                                      onPressed: () {
                                        provider.toggleTask(index);
                                      },

                                      icon: task.isDone
                                          ? const Icon(Icons.check_circle)
                                          : const Icon(Icons.circle_outlined),

                                      color: AppColors.accent,
                                    ),

                                    title: Text(
                                      task.task,

                                      style: TextStyle(
                                        decoration: task.isDone
                                            ? TextDecoration.lineThrough
                                            : TextDecoration.none,
                                      ),
                                    ),

                                    trailing: IconButton(
                                      onPressed: () {
                                        provider.deleteTask(index);
                                      },

                                      icon: Icon(Icons.delete),

                                      color: Colors.red,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
