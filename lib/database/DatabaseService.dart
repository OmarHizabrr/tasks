import 'package:firebase_database/firebase_database.dart';

import '../models/task.dart';

class DatabaseService {
  final DatabaseReference _tasksRef = FirebaseDatabase.instance.ref().child('tasks');

  
  Future<void> addTask(Task task) async {
    await _tasksRef.push().set(task.toJson());
  }

 
  Future<void> updateTask(String key, Task task) async {
    await _tasksRef.child(key).update(task.toJson());
  }

  
  Future<void> deleteTask(String key) async {
    await _tasksRef.child(key).remove();
  }


  Stream<List<Task>> getTasks() {
    return _tasksRef.onValue.map((event) {
      final map = event.snapshot.value as Map<dynamic, dynamic>?;
      if (map == null) {
        return [];
      }
      return map.entries.map((entry) {
        return Task.fromJson(Map<String, dynamic>.from(entry.value), key: entry.key);
      }).toList();
    });
  }
}