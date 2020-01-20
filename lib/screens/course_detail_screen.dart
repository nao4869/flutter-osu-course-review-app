// This file will display the meals for the chosen category
import 'package:flutter/material.dart';
import '../widgets/course_detail.dart';
//import '../widgets/course_list_item.dart';
//import '../data/sample_courses_data.dart';
//import '../widgets/course_list_item.dart';
import '../models/course.dart';

class CourseDetailScreen extends StatefulWidget {
  static const routeName = '/course-detail';
  final List<Course> displayCourseDetail;
  CourseDetailScreen(this.displayCourseDetail);

  @override
  _CourseDetailScreenState createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  String courseName;
  List<Course> selectedCourse;
  var _loadedInitData = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_loadedInitData == false) {
      final routeArgs = ModalRoute.of(context).settings.arguments
          as Map<String, String>; // way to get args from main.dart
      courseName = routeArgs['courseName'];
      final courseId = routeArgs['id'];
      selectedCourse = widget.displayCourseDetail.where((course) {
        return course.id.contains(courseId);
      }).toList();
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(courseName),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return CourseDetail(
            id: selectedCourse[index].id,
            courseName: selectedCourse[index].courseName,
            courseContent: selectedCourse[index].courseName,
            prerequisite: selectedCourse[index].prerequisite,
            proctoredexams: selectedCourse[index].proctoredexams,
            groupwork: selectedCourse[index].groupwork,
            textbook: selectedCourse[index].textbook,
          );
        },
        itemCount: selectedCourse.length,
      ),
    );
  }
}
