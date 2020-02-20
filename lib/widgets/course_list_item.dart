import 'package:flutter/material.dart';
import 'package:osu_course_review/models/language.dart';
import 'package:osu_course_review/screens/course_detail_screen.dart';
import 'package:provider/provider.dart';

import '../models/course.dart';
import '../models/auth.dart';

class CourseListItem extends StatefulWidget {
  @override
  _CourseListItemState createState() => _CourseListItemState();
}

class _CourseListItemState extends State<CourseListItem> {
  Widget _displayCourseNameAndFavIcon(
      BuildContext context, String courseName, Auth authData) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 0, 3),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              courseName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                fontFamily: 'Roboto',
              ),
              maxLines: 1,
              overflow: TextOverflow.clip,
              softWrap: false,
            ),
          ),
          Container(
            child: Consumer<Course>(
              builder: (ctx, course, child) => IconButton(
                icon: Icon(
                  course.isFavorite ? Icons.favorite : Icons.favorite_border,
                  size: 30,
                  color: course.isFavorite == true ? Colors.pink : Colors.grey,
                ),
                color: Theme.of(context).accentColor,
                onPressed: () {
                  course.toggleFavoriteStatus(authData.token, authData.userId);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _displayCourseSubItem(String text, String courseItem) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 0, 3),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              text + courseItem,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontFamily: 'Roboto',
              ),
              maxLines: 1,
              overflow: TextOverflow.clip,
              softWrap: false,
            ),
          ),
        ],
      ),
    );
  }

  Widget _displayRaisedButton(
      BuildContext context, String courseId, String buttonText) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(17, 0, 17, 0),
      child: ButtonTheme(
        minWidth: double.infinity,
        height: 30.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: RaisedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CourseDetailScreen(),
                settings: RouteSettings(arguments: courseId),
              ),
            );
          },
          child: Text(
            buttonText,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const language = 'Language: ';
    const prerequisite = 'Course Prerequisite: ';
    const buttonText = 'Check all reviews';
    final course = Provider.of<Course>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);

    return Container(
      padding: EdgeInsets.only(bottom: 5),
      child: Container(
        margin: EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        width: double.infinity,
        child: Column(
          children: <Widget>[
            _displayCourseNameAndFavIcon(context, course.courseName, authData),
            _displayCourseSubItem(prerequisite, course.prerequisite),
            _displayCourseSubItem(language, course.language),
            _displayRaisedButton(context, course.id, buttonText),
          ],
        ),
      ),
    );
  }
}
