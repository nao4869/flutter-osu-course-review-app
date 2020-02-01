import 'package:flutter/material.dart';
import 'package:osu_course_review/screens/course_detail_screen.dart';
import 'package:provider/provider.dart';
import '../screens/create_course_screen.dart';

import '../models/courses_provider.dart';
import '../models/course.dart';
import '../models/star_display.dart';

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
              borderRadius: BorderRadius.circular(8),
            ),
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 8, 0, 0),
                      child: GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.looks_one,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 8, 0, 0),
                      width: 200,
                      child: Text(
                        course.courseName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.fromLTRB(17, 10, 0, 0),
                  child: StarDisplayWidget(
                    value: 5,
                    filledStar: Icon(Icons.star, color: Colors.amber, size: 20),
                    unfilledStar: Icon(Icons.star_border, color: Colors.grey),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(17, 5, 17, 0),
                  child: ButtonTheme(
                    minWidth: double.infinity,
                    height: 30.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                            CourseDetailScreen.routeName,
                            arguments: course.id);
                      },
                      child: Text(
                        "Check all reviews",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      color: Colors.purple,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
