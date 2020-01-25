import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/course_detail_screen.dart';
import './screens/list_courses_screen.dart';
import './screens/create_course_screen.dart';

import './models/course.dart';
import './models/courses_provider.dart';
import './models/reviews_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Courses(),
        ),
        ChangeNotifierProxyProvider<Course, Reviews>(
          builder: (ctx, course, previousReviews) => Reviews(course.courseId,
              previousReviews == null ? [] : previousReviews.reviews),
        ),
      ],
      child: MaterialApp(
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
          home: ListCoursesScreen(),
          // Lists of available routes in the application
          routes: {
            CourseDetailScreen.routeName: (context) => CourseDetailScreen(),
            CreateCourseScreen.routeName: (context) => CreateCourseScreen(),
          }),
    );
  }
}
