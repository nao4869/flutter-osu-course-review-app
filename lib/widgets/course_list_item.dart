import 'package:flutter/material.dart';
import 'package:osu_course_review/screens/course_detail_screen.dart';
import 'package:provider/provider.dart';
import '../screens/create_course_screen.dart';

import '../models/courses_provider.dart';
import '../models/course.dart';

class CourseListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // retrieving providers objects
    final course = Provider.of<Course>(context, listen: false);

    return Container(
      padding: EdgeInsets.only(bottom: 10),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
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
                        course.courseName,
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
                            arguments: course.id);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.edit),
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                            CreateCourseScreen.routeName,
                            arguments: course.id);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () {
                        Provider.of<Courses>(context, listen: false)
                            .deleteCourse(course.id);
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
