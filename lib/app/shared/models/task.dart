import 'package:uuid/uuid.dart';
import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject{
  Task({required this.id, required this.name,required this.createdAt,required this.isCompleted});
  
  factory Task.create({required String name, DateTime? createdAt }) =>
  Task(id: Uuid().v1(),
           name: name, 
           createdAt: createdAt ?? DateTime.now(),
           isCompleted: false);

  @HiveField(0)
  final String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  final DateTime createdAt;

  @HiveField(3)
  bool isCompleted;

}