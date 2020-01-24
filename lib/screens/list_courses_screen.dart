// Control the entire contents of the first screens
// Displays lsit of courses for the application

import 'package:flutter/material.dart';
import 'package:osu_course_review/screens/create_course_screen.dart';
import 'package:provider/provider.dart';

import '../models/courses_provider.dart';
import '../widgets/course_list_item.dart';
import '../widgets/main_drawer.dart';

class ListCoursesScreen extends StatefulWidget {
  @override
  _ListCoursesScreenState createState() => _ListCoursesScreenState();
}

class _ListCoursesScreenState extends State<ListCoursesScreen> {
  var _isLoading = false;

  @override
  void initState() {
    // Provider.of<Products>(context).fetchAndSetProducts(); // not work
    Future.delayed(Duration.zero).then((_) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<Courses>(context).retrieveCourseData().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final coursesList = Provider.of<Courses>(context);
    final courses = coursesList.courses;
    return Scaffold(
      appBar: AppBar(
        title: Text('OSU Course Search'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(CreateCourseScreen.routeName);
            },
          )
        ],
      ),
      drawer: MainDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(25),
              itemCount: courses.length,
              itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                value: courses[i],
                child: CourseListItem(
                  coursesList.courses[i].id,
                  coursesList.courses[i].courseName,
                ),
              ),
            ),
    );
  }
}
