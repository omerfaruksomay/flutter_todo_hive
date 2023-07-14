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
    // TODO: implement initState
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  void checkBoxChanged(bool? value, int index) {
    final todoModel = Todo.fromJson(db.toDoList[index]);
    print(todoModel);
    setState(() {
      todoModel.taskCompleted = !todoModel.taskCompleted;
    });
    print(todoModel);
    db.updateDatabase();
  }

  void addNewTask() {
    final todoModel = Todo(
      title: _titleController.text,
      desc: _descController.text,
    );

    final jsonModel = todoModel.toJson();

    setState(() {
      db.toDoList.add(jsonModel);
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
                final model = Todo.fromJson(db.toDoList[index]);
                return ToDoTile(
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
