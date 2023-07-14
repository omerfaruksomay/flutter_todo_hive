import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_hive/data/database.dart';
import 'package:todo_hive/widgets/dialog_box.dart';
import 'package:todo_hive/widgets/todo_tile.dart';

import '../models/todo.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box('mybox');
  TodoDatabase db = TodoDatabase();

  @override
  void initState() {
    super.initState();
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
  }

  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  void checkBoxChanged(bool? values, int index) {
    setState(() {
      db.toDoList[index].taskCompleted = values!;
    });
  }

  void addNewTask() {
    final todoModel = Todo(
      title: _titleController.text,
      desc: _descController.text,
    );

    setState(() {
      db.toDoList.add(todoModel);
    });
    _descController.clear();
    _titleController.clear();
    db.updateDatabase();
    Navigator.of(context).pop();
  }

  void removeTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDatabase();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          onSave: addNewTask,
          onCancel: () => Navigator.of(context).pop(),
          titleController: _titleController,
          descController: _descController,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Todo'),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      body: db.toDoList.isEmpty
          ? Center(
              child: Text(
                'Please add some todos!',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            )
          : ListView.builder(
              itemCount: db.toDoList.length,
              itemBuilder: (context, index) {
                var model = db.toDoList[index];
                return ToDoTile(
                  todoModel: model,
                  taskName: model.title,
                  taskDesc: model.desc,
                  taskCompleted: model.taskCompleted,
                  onChanged: (value) => checkBoxChanged(value, index),
                  deleteFunction: (context) => removeTask(index),
                );
              },
            ),
    );
  }
}
