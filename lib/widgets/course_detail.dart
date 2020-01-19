import 'package:flutter/material.dart';
//import '../models/course.dart';
//import '../screens/course_detail_screen.dart';

class CourseDetail extends StatelessWidget {
  final String id;
  final String courseName;
  final String courseContent;
  final String prerequisite;
  final String proctoredexams;
  final String groupwork;
  final String textbook;

  CourseDetail({
    this.id,
    this.courseName,
    this.courseContent,
    this.prerequisite,
    this.proctoredexams,
    this.groupwork,
    this.textbook
  });

  /*
  void selectMeal(BuildContext context) {
    Navigator.of(context).pushNamed(
      MealDetailScreen.routeName,
      arguments: id,
    );
  */

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Course Detail'),
    );
  }
}
