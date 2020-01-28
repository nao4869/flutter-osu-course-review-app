// This file will display the meals for the chosen category
import 'package:flutter/material.dart';
import 'package:osu_course_review/screens/create_review_screen.dart';
import 'package:osu_course_review/widgets/course_review_item.dart';
import 'package:provider/provider.dart';

import '../models/courses_provider.dart';
import '../models/reviews_provider.dart';

class CourseDetailScreen extends StatelessWidget {
  static const routeName = '/course-detail';

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final courseId = ModalRoute.of(context).settings.arguments
        as String; // retrieving ID from routes passed
    final loadedCourse = Provider.of<Courses>(context).findById(courseId);

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedCourse.courseName),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            buildSectionTitle(context, 'Course Detail'),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromRGBO(255, 255, 255, 1)),
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(5),
              height: 300,
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Text(
                      loadedCourse.courseName,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(30, 10, 0, 15),
                    child: Text(
                      'Course Content: ${loadedCourse.courseContent}',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(30, 0, 0, 5),
                    child: Text(
                      'Pre-requisite: ${loadedCourse.prerequisite}',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(30, 0, 0, 5),
                    child: Text(
                      'Proctored Exams: ${loadedCourse.proctoredexams}',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(30, 0, 0, 5),
                    child: Text(
                      'Group Work: ${loadedCourse.groupwork}',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(30, 0, 0, 5),
                    child: Text(
                      'Textbook: ${loadedCourse.textbook}',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            buildSectionTitle(context, 'Create Course Reviews'),
            FlatButton(
              child: Text('Create Course Reviews'),
              onPressed: () {
                Navigator.of(context).pushNamed(CreateReviewScreen.routeName);
              },
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              textColor: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
