import 'package:flutter/material.dart';

class YourCourses extends StatefulWidget {
  static const routeName = '/user-favorites';

  @override
  _YourCoursesState createState() => _YourCoursesState();
}

class _YourCoursesState extends State<YourCourses> {
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
