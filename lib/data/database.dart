import 'package:hive_flutter/adapters.dart';
import 'package:todo_hive/models/todo.dart';

class TodoDatabase {
  List<Todo> toDoList = [];

  final _myBox = Hive.box('mybox');

  void createInitialData() {
    toDoList = [];
  }

  loadData() {
    return _myBox.get("TODOLIST");
  }

  void updateDatabase() {
    _myBox.put("TODOLIST", toDoList);
  }
}
