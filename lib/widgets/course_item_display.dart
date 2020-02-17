import 'package:flutter/material.dart';
import 'package:osu_course_review/screens/course_detail_screen.dart';
import 'package:provider/provider.dart';

import '../models/course.dart';
import '../models/auth.dart';
import '../models/star_display.dart';

class CourseItemDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // retrieving providers objects
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
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 0, 3),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      course.courseName,
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
                          course.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          size: 30,
                          color: course.isFavorite == true
                              ? Colors.pink
                              : Colors.grey,
                        ),
                        color: Theme.of(context).accentColor,
                        onPressed: () {
                          course.toggleFavoriteStatus(
                              authData.token, authData.userId);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 3),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'Pre-requisite: ' + course.prerequisite,
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
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 3),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'Programming Language: ' + course.language,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Roboto',
                      ),
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
            Container(
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
                        settings: RouteSettings(arguments: course.id),
                      ),
                    );
                  },
                  child: Text(
                    "Check all reviews",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
