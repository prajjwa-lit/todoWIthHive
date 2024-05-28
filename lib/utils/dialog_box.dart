import 'package:flutter/material.dart';
import 'package:todo1/utils/my_buttons.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[300],
      content: Container(
        height: 120,
        child: Column(
          children: [
            //Input user tasks
            TextField(
              controller: controller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Enter Your Task'),
            ),
            Row(
              children: [
                //save button
                Expanded(child: MyButton(text: 'Save', onPressed:onSave)),
                SizedBox(width: 10,),
                //cancel button
                Expanded(child: MyButton(text: "Cancel", onPressed: onCancel))
              ],
            )
          ],
        ),
      ),
    );
  }
}
