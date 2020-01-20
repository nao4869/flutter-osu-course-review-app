// This file will display the meals for the chosen category
import 'package:flutter/material.dart';
import '../data/sample_courses_data.dart';
import '../widgets/course_list_item.dart';
import '../models/course.dart';

class CourseDetailScreen extends StatefulWidget {
  @override
  _CourseDetailScreenState createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test'),
      ),
      body: Center(
        child: Text('Your Courses'),
      ),
    );
  }
}
