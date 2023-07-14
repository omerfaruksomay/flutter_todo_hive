import 'package:flutter/material.dart';
import 'package:todo_hive/models/todo.dart';

class TodoDetailsScreen extends StatelessWidget {
  const TodoDetailsScreen({super.key, required this.todoModel});
  final Todo todoModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        centerTitle: true,
        title: Text(todoModel.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          todoModel.desc,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
