import 'package:flutter/material.dart';
import 'package:osu_course_review/screens/course_detail_screen.dart';
import 'package:provider/provider.dart';
import '../screens/create_course_screen.dart';

import '../models/courses_provider.dart';

class CourseListItem extends StatelessWidget {
  final String id;
  final String title;

  CourseListItem(this.id, this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.purple),
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      width: 200,
                      child: Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.search),
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                            CourseDetailScreen.routeName,
                            arguments: id);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.edit),
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                            CreateCourseScreen.routeName,
                            arguments: id);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () {
                        Provider.of<Courses>(context, listen: false)
                            .deleteCourse(id);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
