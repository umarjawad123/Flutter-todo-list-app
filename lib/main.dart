import 'package:flutter/material.dart';
import 'package:todo_list/screens/homepage.dart';
import 'package:todo_list/utils/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo List',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: AppColors.background
      ),
      home: const HomePage(),
    );
  }
}