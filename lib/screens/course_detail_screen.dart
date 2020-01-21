// This file will display the meals for the chosen category
import 'package:flutter/material.dart';
import '../widgets/course_detail.dart';
import '../widgets/course_review_lists.dart';
import '../models/course.dart';
import '../models/review.dart';

class CourseDetailScreen extends StatefulWidget {
  static const routeName = '/course-detail';
  final List<Course> displayCourseDetail;
  final List<Review> displayCourseReviews;

  CourseDetailScreen(this.displayCourseDetail, this.displayCourseReviews);

  @override
  _CourseDetailScreenState createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  String courseName;
  List<Course> selectedCourse;

  String reviewsContent;
  List<Review> selectedCourseReviews;

  var _loadedInitData = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_loadedInitData == false) {
      // Retrieving loaded course and translate to list
      final routeArgs = ModalRoute.of(context).settings.arguments
          as Map<String, String>; // way to get args from main.dart
      courseName = routeArgs['courseName'];
      final courseId = routeArgs['id'];
      selectedCourse = widget.displayCourseDetail.where((course) {
        return course.id.contains(courseId);
      }).toList();

      // Retrieving reviews of loaded course and translate to list
      selectedCourseReviews = widget.displayCourseReviews.where((review) {
        return review.courseId.contains(courseId);
      }).toList();

      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.title,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      height: 250,
      width: double.infinity,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(courseName),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            buildSectionTitle(context, 'Course Detail'),
            buildContainer(
              ListView.builder(
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
            ),
            buildSectionTitle(context, 'Reviews for $courseName'),
            Container(
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(5),
              height: 500,
              width: double.infinity,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Container(
                    width: double.infinity,
                    height: 100,
                    child: CourseReviewLists(
                      id: selectedCourseReviews[index].id,
                      courseId: selectedCourseReviews[index].courseId,
                      reviewsContent:
                          selectedCourseReviews[index].reviewsContent,
                    ),
                  );
                },
                itemCount: selectedCourseReviews.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
