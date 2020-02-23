// This file will display the meals for the chosen category
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:core';

import '../models/courses_provider.dart';
import '../models/review.dart';
import '../models/reviews_provider.dart';
import '../models/star_display.dart';
import '../models/theme_provider.dart';
import '../widgets/course_review_item.dart';

class CourseDetailScreen extends StatefulWidget {
  static const routeName = '/course-detail';

  @override
  _CourseDetailScreenState createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  var _isLoading = false;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      setState(() {
        _isLoading = true;
      });

      final courseId = ModalRoute.of(context).settings.arguments as String;
      print(courseId);

      Provider.of<Reviews>(context).retrieveReviewData(courseId).then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    });
    super.initState();
  }

  Widget buildSectionTitle(
      BuildContext context, String text, ThemeProvider theme) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: TextStyle(
          color: theme.getThemeData == lightTheme ? Colors.black : Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget subHeader(String courseName, String text, ThemeProvider theme) {
    const separator = '/ ';
    const displayReview = ' review';
    return Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(5, 5, 0, 10),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/');
            },
            child: Icon(
              Icons.home,
              color: theme.getThemeData == lightTheme
                  ? Colors.black
                  : Colors.white,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(3, 0, 0, 0),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/');
            },
            child: Text(
              text + ' ',
              style: TextStyle(
                color: theme.getThemeData == lightTheme
                    ? Colors.black
                    : Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ),
        Expanded(
          child: Text(
            separator + courseName + displayReview,
            style: TextStyle(
              color: theme.getThemeData == lightTheme
                  ? Colors.black
                  : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            maxLines: 1,
          ),
        ),
      ],
    );
  }

  Widget displayCourseName(String courseName, ThemeProvider theme) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Text(
        courseName,
        style: TextStyle(
          color: theme.getThemeData == lightTheme ? Colors.black : Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        maxLines: 1,
      ),
    );
  }

  Widget displayStarAndScoreNumber(
      int starScore, num scoreNumber, ThemeProvider theme) {
    return Row(
      children: <Widget>[
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.fromLTRB(30, 10, 0, 0),
          child: StarDisplayWidget(
            value: starScore,
            filledStar: Icon(Icons.star, color: Colors.amber, size: 20),
            unfilledStar: Icon(Icons.star_border, color: Colors.grey),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(5, 10, 0, 0),
          child: Text(
            '$scoreNumber',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: theme.getThemeData == lightTheme
                  ? Colors.black
                  : Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
              fontFamily: 'roboto',
            ),
          ),
        ),
      ],
    );
  }

  Widget displayCourseDescription(
      String courseDescription, ThemeProvider theme) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(30, 10, 20, 15),
      child: Text(
        courseDescription,
        textAlign: TextAlign.left,
        style: TextStyle(
          color: theme.getThemeData == lightTheme ? Colors.black : Colors.white,
          fontSize: 15,
        ),
      ),
    );
  }

  Widget progreeIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _displayListOfReviews(List<Review> reviews) {
    return Flexible(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
        itemCount: reviews.length,
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          value: reviews[i],
          child: CourseReviewItem(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final courseId = ModalRoute.of(context).settings.arguments
        as String; // retrieving ID from routes passed
    final loadedCourse = Provider.of<Courses>(context).findById(courseId);

    final reviewList = Provider.of<Reviews>(context);
    final reviews = reviewList.reviews;

    final theme = Provider.of<ThemeProvider>(context);

    // map to obtain each reviews star score
    final total = reviews.map((rv) => rv.starScore).toList();

    // retrieve sum of star score
    final sum = total.fold(0, (a, b) => a + b);

    // round to decimal 2 point
    final scoreToDisplay = (sum / reviews.length);
    var intScore = int.tryParse(scoreToDisplay.toStringAsFixed(1)) ?? 5;
    final finalScore = num.parse(scoreToDisplay.toStringAsFixed(1));

    const headerName = 'HOME';

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedCourse.courseName),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  subHeader(loadedCourse.courseName, headerName, theme),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(20),
                      color: theme.getThemeData == lightTheme
                          ? Colors.white
                          : Colors.black26,
                    ),
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(5),
                    width: double.infinity,
                    child: Column(
                      children: <Widget>[
                        displayCourseName(loadedCourse.courseName, theme),
                        displayStarAndScoreNumber(intScore, finalScore, theme),
                        displayCourseDescription(
                            loadedCourse.courseContent, theme),
                      ],
                    ),
                  ),
                  buildSectionTitle(context, 'Course Reviews', theme),
                  _isLoading
                      ? progreeIndicator()
                      : _displayListOfReviews(reviews),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/');
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.home,
          color: Colors.white,
        ),
      ), //
    );
  }
}
