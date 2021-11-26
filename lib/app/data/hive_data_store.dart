import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_manager_hive_getx/app/shared/models/task.dart';

class HiveDataStore {
  static const taskBoxName = 'tasks';
  final Box<Task> box = Hive.box<Task>(taskBoxName);


  Future<void> addTask({required Task task})async{
    await box.put(task.id, task);
  }

  Future<Task?> getTask({required String id})async{
    return box.get(id);
  }

  Future<void> updateTask({required Task task})async{
    await task.save();
  }

  Future<void> deleteTask({required Task task})async{
    await task.delete();
  }

    ValueListenable<Box<Task>> listenToTasks(){
    return Hive.box<Task>(taskBoxName).listenable();
  }
}