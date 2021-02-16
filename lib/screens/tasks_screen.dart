import 'package:flutter/material.dart';

import './add_task_screen.dart';
import '../widgets/logo.dart';
import '../widgets/tasks_list.dart';

class TasksScreen extends StatelessWidget {
  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: AddTaskScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlueAccent,
        child: Icon(Icons.add),
        onPressed: () => _showModalBottomSheet(context),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Logo(),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: mediaQuery * .02),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(mediaQuery * .03),
                    topLeft: Radius.circular(mediaQuery * .03),
                  ),
                ),
                child: TasksList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
