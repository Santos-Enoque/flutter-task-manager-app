import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:task_manager_hive_getx/app/modules/home/widgets/task_widget.dart';
import 'package:task_manager_hive_getx/app/shared/models/task.dart';

var tasks = [
  Task.create(name: '🛍 Go Shopping'),
  Task.create(name: '👨🏼‍💻 Code'),
  Task.create(name: '🦮 Walk the dog'),
  Task.create(name: '💪 Exercise'),
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
                        child: ListTile(
                            title: TextField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter task name'),
                              onSubmitted: (value) {
                                Navigator.pop(context);
                              },
                              autofocus: true,
                            ),
                            trailing: IconButton(
                                onPressed: () {
                                  print('click click');
                                  Navigator.pop(context);
                                  DatePicker.showDateTimePicker(context,
                              showTitleActions: true,
                              minTime: DateTime.now(),
                              maxTime: DateTime(2019, 6, 7), onChanged: (date) {
                            print('change $date');
                          }, onConfirm: (date) {
                            print('confirm $date');
                          }, currentTime: DateTime.now());
                                },
                                icon: Icon(Icons.alarm))),
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
