import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:week3_task_management/task.dart';

class taskStorage {
  static const String _taskKey = 'task';

  Future<List<Task>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? taskList = prefs.getString(_taskKey);
    if (taskList == null) return [];
    return (json.decode(taskList) as List)
        .map((task) => Task.fromJson(task))
        .toList();
  }

  Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final taskJson = json.encode(tasks.map((task) => task.toJson()).toList());
    await prefs.setString(_taskKey, taskJson);
  }
}
