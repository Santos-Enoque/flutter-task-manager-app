import 'package:uuid/uuid.dart';

class Task {
  Task({required this.id, required this.name,required this.createdAt,required this.isCompleted});
  final String id;
  final String name;
  final DateTime createdAt;
  final bool isCompleted;

  factory Task.create({required String name, DateTime? createdAt }) =>
  Task(id: Uuid().v1(),
           name: name, 
           createdAt: createdAt ?? DateTime.now(),
           isCompleted: false);


}