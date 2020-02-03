import 'package:flutter/material.dart';
import 'package:osu_course_review/screens/list_courses_screen.dart';
import 'package:provider/provider.dart';
import 'dart:math';

import '../models/major.dart';

class MajorListItem extends StatefulWidget {
  @override
  _MajorListItemState createState() => _MajorListItemState();
}

class _MajorListItemState extends State<MajorListItem> {
  List colors = [
    Colors.pink,
    Colors.red,
    Colors.deepOrange,
    Colors.orange,
    Colors.amber,
    Colors.yellow,
    Colors.lime,
    Colors.lightGreen,
    Colors.lightGreenAccent,
    Colors.green,
    Colors.greenAccent,
    Colors.teal,
    Colors.tealAccent,
    Colors.cyan,
    Colors.cyanAccent,
    Colors.lightBlue,
    Colors.lightBlueAccent,
    Colors.indigo,
    Colors.purple,
    Colors.deepPurple,
    Colors.blueGrey,
  ];

  Random random = new Random();

  int index = 0;

  void changeIndex() {
    setState(() => index = random.nextInt(21));
  }

  @override
  void didChangeDependencies() {
    changeIndex();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final major = Provider.of<Major>(context, listen: false);

    return Container(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 100,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(ListCoursesScreen.routeName,
                    arguments: major.majorName);
                //print(major.majorName);
              },
              splashColor: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(15),
              child: Container(
                padding: const EdgeInsets.all(15),
                child: Text(
                  major.majorName,
                  style: Theme.of(context).textTheme.title,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      colors[index].withOpacity(0.7),
                      colors[index],
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
