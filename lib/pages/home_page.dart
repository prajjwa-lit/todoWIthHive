import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo1/data/database.dart';
import 'package:todo1/utils/dialog_box.dart';
import '../utils/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Box _myBox;
  TodoDatabase db = TodoDatabase();

  @override
  void initState() {
    super.initState(); // Move super.initState() here
    _initHiveAndLoadData();
  }

  // Initialize Hive and load data
  Future<void> _initHiveAndLoadData() async {
    try {
      _myBox = await Hive.openBox('mybox');
      if (_myBox.get("TODOLIST") == null) {
        db.createInitialData();
      } else {
        db.loadData();
      }
      setState(() {}); // Refresh the UI after data is loaded
    } catch (e) {
      print("Error opening Hive box: $e");
    }
  }

  //text controller
  final _controller = TextEditingController();

  //create new task
  createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }

  //delete a task
  void deleteTask(int index) {
    setState(() {
      db.todoList.removeAt(index);
    });
  }

  //if check box is tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });
  }

  void saveNewTask() {
    setState(() {
      db.todoList.add([_controller.text, false]);
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow[300],
        appBar: AppBar(
          backgroundColor: Colors.yellow,
          title: Center(child: Text('TO DO APP')),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewTask,
          child: Icon(Icons.add),
        ),
        body: ListView.builder(
            itemCount: db.todoList.length,
            itemBuilder: (context, index) {
              return TodoTile(
                taskName: db.todoList[index][0],
                taskDone: db.todoList[index][1],
                onChanged: (value) => checkBoxChanged(value, index),
                deleteFunction: (context) => deleteTask(index),
              );
            }));
  }
}
