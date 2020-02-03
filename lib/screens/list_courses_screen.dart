// Control the entire contents of the first screens
// Displays lsit of loadedMajorCourses for the application

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/create_review_screen.dart';
import '../screens/create_course_screen.dart';
import '../screens/course_detail_screen.dart';
import '../models/courses_provider.dart';
import '../models/course.dart';
import '../widgets/course_list_item.dart';
import '../widgets/main_drawer.dart';

class ListCoursesScreen extends StatefulWidget {
  static const routeName = '/list-loadedMajorCourses-screen';

  @override
  _ListCoursesScreenState createState() => _ListCoursesScreenState();
}

class _ListCoursesScreenState extends State<ListCoursesScreen> {
  var _isLoading = false;

  @override
  void initState() {
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
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  var _currentSelectedValue;

  @override
  Widget build(BuildContext context) {
    final majorName = ModalRoute.of(context).settings.arguments
        as String; // retrieving majorName passed from list majors screen
    final loadedMajorCourses = Provider.of<Courses>(context).findByMajor(
        majorName); // findByMajor returns list of courses where condition match
    var ddv;

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          DropdownButton<Course>(
            value: ddv,
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            elevation: 0,
            underline: null,
            onChanged: (Course newValue) {
              setState(() {
                ddv = newValue;
                Navigator.of(context).pushNamed(CourseDetailScreen.routeName,
                    arguments: ddv.id);
              });
            },
            items: loadedMajorCourses.map((Course value) {
              return DropdownMenuItem<Course>(
                value: value,
                child: Text(
                  value.courseName.toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 13,
                  ),
                ),
              );
            }).toList(),
          ),
          IconButton(
            icon: Icon(
              Icons.add,
            ),
            iconSize: 24,
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
              itemCount: loadedMajorCourses.length,
              itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                value: loadedMajorCourses[i],
                child: CourseListItem(),
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pushNamed(CreateReviewScreen.routeName);
        },
        label: Text(
          'New-Review',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        icon: Icon(
          Icons.create,
          color: Colors.white,
        ),
      ),
    );
  }
}
