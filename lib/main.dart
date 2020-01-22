import 'package:flutter/material.dart';
import 'package:osu_course_review/data/sample_courses_data.dart';
//import './screens/list_courses_screen.dart';

import './screens/course_detail_screen.dart';
import './screens/tabs_screen.dart';
import './screens/create_course_screen.dart';
import './screens/create_review_screen.dart';

import './models/course.dart';
import './models/review.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyApp> {
  List<Course> _allCourses= SAMPLE_COURSES.toList();
  List<Review> _allReviews= SAMPLE_REVIEWS.toList();
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OSU Course Review',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            body1: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            body2: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            title: TextStyle(
              fontSize: 20,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
            )),
      ),
      // Lists of available routes in the application
      routes: {
        '/': (context) => TabScreen(), // home route
        CourseDetailScreen.routeName: (context) => CourseDetailScreen(_allCourses, _allReviews),
        CreateCourseScreen.routeName: (context) => CreateCourseScreen(),
        CreateReviewScreen.routeName: (context) => CreateReviewScreen(),
      },
    );
  }
}
