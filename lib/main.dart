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
import './models/theme_provider.dart';
import "package:intl/intl.dart";

void main() {
  runApp(
    ChangeNotifierProvider(
      builder: (_) => ThemeProvider(isLightTheme: true),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String createdAt = DateFormat("y/m/d").format(new DateTime.now());

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    const title = 'University Course Search';

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
          title: title,
          theme: themeProvider.getThemeData,
          home: TabScreen(),
          routes: {
            ListInstitutionScreen.routeName: (context) =>
                ListInstitutionScreen(),
            ListMajorsScreen.routeName: (context) => ListMajorsScreen(),
            ListCoursesScreen.routeName: (context) => ListCoursesScreen(),
            CourseDetailScreen.routeName: (context) => CourseDetailScreen(),
            CreateCourseScreen.routeName: (context) => CreateCourseScreen(),
            CreateReviewScreen.routeName: (context) => CreateReviewScreen(),
            CreateMajorScreen.routeName: (context) => CreateMajorScreen(),
          },
        ),
      ),
    );
  }
}
