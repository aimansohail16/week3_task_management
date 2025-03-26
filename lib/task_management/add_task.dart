import 'package:flutter/material.dart';

class AddTask extends StatelessWidget {
  final Function(String) onAddTask;
  const AddTask({super.key, required this.onAddTask});

  @override
  Widget build(BuildContext context) {
    String task = "";
    return AlertDialog(
      backgroundColor: Colors.amber,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Text("Add Tasks", style: TextStyle(color: Colors.black)),
      content: Container(
        child: SizedBox(
          width: 400,
          height: 100,
          child: Column(
            children: [
              TextField(
                onChanged: (value) => task = value,
                decoration: const InputDecoration(hintText: 'Enter task'),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Cancel", style: TextStyle(color: Colors.black)),
        ),
        TextButton(
          onPressed: () {
            if (task.isNotEmpty) {
              onAddTask(task); // Call the function to add task
            }
            Navigator.pop(context);
          },
          child: Text("Add", style: TextStyle(color: Colors.black)),
        ),
      ],
    );
  }
}
