// This file will display the meals for the chosen category
import 'package:flutter/material.dart';
import '../data/sample_courses_data.dart';
import '../widgets/course_list_item.dart';

class CourseDetailScreen extends StatelessWidget {
  static const routeName = '/course-detail';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Your Courses'),
    );
  }
}