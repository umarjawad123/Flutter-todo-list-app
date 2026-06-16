import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/models/task_model.dart';

class TaskProvider extends ChangeNotifier {
  final List<TaskModel> _tasks = [];

  List<TaskModel> get tasks => _tasks;

  TaskProvider() {
    _initialize();
  }

  void _initialize() {
    loadTasks();
  }

  Future<void> addTasks(String title) async {
    if (title.trim().isEmpty) {
      return;
    }

    _tasks.add(TaskModel(task: title.trim()));
    await saveTasks();
    notifyListeners();
  }

  Future<void> deleteTask(int index) async {
    _tasks.removeAt(index);
    await saveTasks();
    notifyListeners();
  }

  Future<void> toggleTask(int index) async {
    _tasks[index].isDone = !_tasks[index].isDone;
    await saveTasks();
    notifyListeners();
  }

  Future<void> saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> encodedTasks = _tasks
        .map((task) => jsonEncode(task.toJson()))
        .toList();

    await prefs.setStringList("myTasks", encodedTasks);
  }

  Future<void> loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> savedTasks = prefs.getStringList("myTasks") ?? [];

    _tasks.clear();

    _tasks.addAll(
      savedTasks.map((task) {
        return TaskModel.fromJson(jsonDecode(task));
      }),
    );
    notifyListeners();
  }
}
