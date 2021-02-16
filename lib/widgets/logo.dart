import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/models/tasks.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.only(
        top: mediaQuery * .05,
        right: mediaQuery * .05,
        bottom: mediaQuery * .05,
        left: mediaQuery * .05,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            radius: mediaQuery * .04,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.list,
              size: mediaQuery * .05,
              color: Colors.lightBlueAccent,
            ),
          ),
          SizedBox(height: mediaQuery * .02),
          Text(
            'Todoey',
            style: TextStyle(
              color: Colors.white,
              fontSize: 48,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            '${Provider.of<Tasks>(context).tasksCount} tasks',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
