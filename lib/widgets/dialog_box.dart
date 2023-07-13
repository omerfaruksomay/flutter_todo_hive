import 'package:flutter/material.dart';
import 'package:todo_hive/widgets/custom_button.dart';

class DialogBox extends StatelessWidget {
  DialogBox({
    super.key,
    required this.controller,
    required this.onCancel,
    required this.onSave,
  });
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[200],
      content: Container(
        height: 120,
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add a new task",
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(onPressed: onCancel, text: "Cancel"),
                  SizedBox(width: 10),
                  CustomButton(onPressed: onSave, text: "Add Todo"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
