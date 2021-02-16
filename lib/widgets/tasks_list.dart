import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './task_tile.dart';
import '../models/tasks.dart';

class TasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<Tasks>(context, listen: false).getDataFromDB(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return Consumer<Tasks>(
            builder: (context, tasksData, child) {
              if (tasksData.isEmpty) {
                return Center(
                  child: Text('You did not add any task yet'),
                );
              }
              return ListView.builder(
                itemCount: tasksData.tasksCount,
                itemBuilder: (context, index) {
                  final task = tasksData.tasks[index];
                  return TaskTile(
                    taskTitle: task.title,
                    isChecked: task.isDone,
                    onChange: (newValue) {
                      Provider.of<Tasks>(context, listen: false)
                          .updateTask(task);
                    },
                    onLongPress: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Are you Sure'),
                          content: Text('Do you want to delete the task?'),
                          actions: <Widget>[
                            TextButton(
                              child: Text('No'),
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                            ),
                            TextButton(
                              child: Text('Yes'),
                              onPressed: () {
                                Provider.of<Tasks>(context, listen: false)
                                    .deleteTask(task);
                                Navigator.of(context).pop(true);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        }
        return Text('Error Loading Data!');
      },
    );
  }
}
