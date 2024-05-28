  import 'package:flutter/material.dart';
import 'package:todo1/utils/dialog_box.dart';
  import '../utils/todo_tile.dart';

  class HomePage extends StatefulWidget {
    const HomePage({super.key});

    @override
    State<HomePage> createState() => _HomePageState();
  }

  class _HomePageState extends State<HomePage> {

    final _controller = TextEditingController();


    List todoList=[
      ["Make t", false],
      ["Make blueberry" , true]
    ];

    //create new task
    createNewTask(){
      showDialog(context: context, builder: (context){
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );

      });
    }

    //delete a task
    void deleteTask(int index){
      setState(() {
        todoList.removeAt(index);
      });
    }


    //if check box is tapped
    void checkBoxChanged( bool? value, int index){
        setState(() {
          todoList[index][1]=!todoList[index][1];
        });
    }

    void saveNewTask() {
      setState(() {
        todoList.add([ _controller.text, false]);
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
        floatingActionButton: FloatingActionButton(onPressed:createNewTask,
        child: Icon(Icons.add),),
        body: ListView.builder(
            itemCount: todoList.length,
            itemBuilder: (context,index){
              return TodoTile(
                  taskName: todoList[index][0],
                  taskDone: todoList[index][1],
                  onChanged: (value) => checkBoxChanged(value, index),
                  deleteFunction: (context)=> deleteTask(index),
              );
            }
        )
      );
    }
  }
