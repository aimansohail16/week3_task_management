import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:week3_task_management/shared_prefernces.dart';
import 'package:week3_task_management/task.dart';
import 'package:week3_task_management/task_management/add_task.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  final taskStorage _storage = taskStorage();
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    tasks = await _storage.loadTasks();
    setState(() {});
  }

  Future<void> _saveTasks() async {
    await _storage.saveTasks(tasks);
  }

  void _addTask(String title) {
    setState(() {
      tasks.add(Task(title: title));
      _saveTasks();
    });
  }

  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
      _saveTasks();
    });
  }

  void _toggleTask(int index) {
    setState(() {
      tasks[index].isCompleted = !tasks[index].isCompleted;
      _saveTasks();
    });
  }

  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (context) => AddTask(onAddTask: _addTask),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Task Manager",
          style: GoogleFonts.acme(color: Colors.black, fontSize: 25),
        ),
        backgroundColor: Colors.amber,
        shadowColor: Colors.black,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child:
                  tasks.isEmpty
                      ? Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/task.png",
                              height: 100,
                              width: 50,
                            ),
                            SizedBox(height: 30),
                            Text(
                              "No Tasks",
                              style: TextStyle(
                                color: Colors.black45,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      )
                      : ListView.builder(
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          final task = tasks[index];
                          return ListTile(
                            leading: Checkbox(
                              value: task.isCompleted,
                              onChanged: (_) => _toggleTask(index),
                              fillColor: WidgetStateProperty.resolveWith<Color>(
                                (Set<WidgetState> states) {
                                  if (states.contains(WidgetState.selected)) {
                                    return Colors.amber; // Color when checked
                                  }
                                  return Colors.white; // Color when unchecked
                                },
                              ),
                            ),
                            title: Text(
                              task.title,
                              style: TextStyle(
                                decoration:
                                    task.isCompleted
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Color.fromARGB(255, 112, 92, 31),
                              ),
                              onPressed: () => _deleteTask(index),
                            ),
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        backgroundColor: Colors.amber,
        elevation: 2,
        child: Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}
