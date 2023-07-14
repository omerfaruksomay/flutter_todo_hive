import 'package:hive_flutter/adapters.dart';

class TodoDatabase {
  List<String> toDoList = [];

  final _myBox = Hive.box('mybox');

  void createInitialData() {
    toDoList = [];
  }

  void loadData() {
    toDoList = _myBox.get("TODOLIST");
  }

  void updateDatabase() {
    _myBox.put("TODOLIST", toDoList);
  }
}
