import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/course_detail_screen.dart';
import './screens/list_courses_screen.dart';
import './screens/create_course_screen.dart';
import './screens/create_review_screen.dart';
import './screens/create_major_screen.dart';
import './screens/list_majors_screen.dart';
import './screens/list_institutions_screen.dart';
import './screens/tabs_screen.dart';

import './models/auth.dart';
import './models/courses_provider.dart';
import './models/reviews_provider.dart';
import './models/major_provider.dart';
import './models/language_provider.dart';
import './models/institution_provider.dart';
import "package:intl/intl.dart";

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var createdAt = DateFormat("y/m/d").format(new DateTime.now());

  @override
  Widget build(BuildContext context) {
    final insitutionName = 'Oregon State University';
    final majorName = 'Computer Science';
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Courses>(
          builder: (ctx, auth, previousCourses) => Courses(
              auth.token,
              auth.userId,
              previousCourses == null ? [] : previousCourses.courses),
        ),
        ChangeNotifierProvider.value(
          value: Majors(),
        ),
        ChangeNotifierProvider.value(
          value: Languages(),
        ),
        ChangeNotifierProvider.value(
          value: Institutions(),
        ),
        ChangeNotifierProxyProvider<Courses, Reviews>(
          builder: (ctx, courses, previousReviews) => Reviews(
              courses.insitutionName,
              courses.courseId,
              createdAt,
              previousReviews == null ? [] : previousReviews.reviews),
        ),
      ],
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: MaterialApp(
            title: 'OSU Course Review',
            theme: ThemeData(
              primarySwatch: Colors.red,
              accentColor: Colors.amberAccent,
              canvasColor: Color.fromRGBO(250, 245, 240, 1),
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
                    ),
                  ),
            ),
            home: TabScreen(),
            routes: {
              ListInstitutionScreen.routeName: (context) => ListInstitutionScreen(),
              ListMajorsScreen.routeName: (context) => ListMajorsScreen(),
              ListCoursesScreen.routeName: (context) => ListCoursesScreen(),
              CourseDetailScreen.routeName: (context) => CourseDetailScreen(),
              CreateCourseScreen.routeName: (context) => CreateCourseScreen(),
              CreateReviewScreen.routeName: (context) => CreateReviewScreen(),
              CreateMajorScreen.routeName: (context) => CreateMajorScreen(),
            }),
      ),
    );
  }
}
