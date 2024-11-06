import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/what_todo/bloc/todo_bloc.dart';
import 'package:todo/what_todo/repository/todo_repository.dart';
import 'package:todo/what_todo/screens/todo_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => TodoBloc(todoRepository: WhatTodoRepository()),
        child: const TodoScreen(),
      ),
    );
  }
}
