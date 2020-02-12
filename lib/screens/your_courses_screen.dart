import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/courses_provider.dart';

class YourCourses extends StatefulWidget {
  static const routeName = '/user-favorites';

  @override
  _YourCoursesState createState() => _YourCoursesState();
}

class _YourCoursesState extends State<YourCourses> {
  // Future<void> _refreshCourses(BuildContext context) async {
  //   await Provider.of<Courses>(context, listen: false)
  //       .retrieveCourseData()(true);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('University Course Search'),
      ),
      body: Center(
        child: Text('In here, somehow display users favorite course'),
      ),
    );
  }
}
