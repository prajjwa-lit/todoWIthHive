import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TodoDatabase {
  List todoList = [];

  //ref our box
  final _myBox = Hive.box('mybox');

  // run this method if this is the 1st time ever opening this app
  void createInitialData() {
    todoList = [
      ["My Nigga, Let's Go🚀", false],
      ["Lift some 🏋️", false],
      ["Build cool shit🍾👑", false],
    ];
  }

  // load the data from database
  void loadData() {
    todoList = _myBox.get("TODOLIST");
  }

  // update the database
  void updateDataBase() {
    _myBox.put("TODOLIST", todoList);
  }
}
