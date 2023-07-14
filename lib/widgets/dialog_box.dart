import 'package:flutter/material.dart';
import 'package:todo_hive/widgets/custom_button.dart';

class DialogBox extends StatelessWidget {
  DialogBox({
    super.key,
    required this.titleController,
    required this.descController,
    required this.onCancel,
    required this.onSave,
  });
  final titleController;
  final descController;
  VoidCallback onSave;
  VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[200],
      content: Container(
        height: 200,
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Task name",
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: descController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Task Description",
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
