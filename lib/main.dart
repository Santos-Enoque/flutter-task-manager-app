import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:task_manager_hive_getx/models/task.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: AppBarTheme(
              elevation: 0.0,
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.black))),
      home: HomeView(),
    );
  }
}

var tasks = [
  Task(name: '🛍 Go Shopping', createdAt: '7:00 am', isCompleted: false),
  Task(name: '👨🏼‍💻 Code', createdAt: '12:00 pm', isCompleted: true),
  Task(name: '🦮 Walk the dog', createdAt: '7:00 pm', isCompleted: false),
  Task(name: '💪 Exercise', createdAt: '8:00 pm', isCompleted: false),
];

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        title: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Container(
              margin: EdgeInsets.only(left: 6),
              child: Text(
                'What\'s up for Today?',
                style: TextStyle(color: Colors.black),
              ),
            )),
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child:     ListTile(
                              title: TextField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter task name'),
                              onSubmitted: (value) {
                                Navigator.pop(context);
                              },
                              autofocus: true,
                            ),
                            trailing: IconButton(onPressed: (){}, icon: Icon(Icons.alarm))
                            
                            ),
                      );
                    });
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
              background: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.delete_outline,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text('This task was deleted',
                      style: TextStyle(
                        color: Colors.grey,
                      ))
                ],
              ),
              onDismissed: (direction) {
                print('hey');
              },
              key: Key('as$index'),
              child: TaskWidget(task: tasks[index]));
        },
      ),
    );
  }
}

class TaskWidget extends StatefulWidget {
  const TaskWidget({Key? key, required this.task}) : super(key: key);

  final Task task;

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  TextEditingController taskController = TextEditingController();
  @override
  void initState() {
    super.initState();
    taskController.text = widget.task.name;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(.1),
                offset: Offset(0, 4),
                blurRadius: 10)
          ]),
      child: ListTile(
          leading: Container(
            decoration: BoxDecoration(
                color: widget.task.isCompleted ? Colors.green : Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey, width: .8)),
            child: Icon(
              Icons.check,
              color: Colors.white,
            ),
          ),
          title: widget.task.isCompleted
              ? Text(
                  taskController.text,
                  style: TextStyle(
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough),
                ) : TextField(
                  controller: taskController,
                  decoration: InputDecoration(border: InputBorder.none),
                )
              ,
          trailing: Text(
            widget.task.createdAt,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          )),
    );
  }
}
