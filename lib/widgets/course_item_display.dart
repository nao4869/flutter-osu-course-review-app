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
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      softWrap: false,
                    ),
                  ),
                ],
              ),
            ),
            // Star display
            Row(
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.fromLTRB(17, 5, 0, 0),
                  child: StarDisplayWidget(
                    value: 5,
                    filledStar: Icon(Icons.star, color: Colors.amber, size: 20),
                    unfilledStar: Icon(Icons.star_border, color: Colors.grey),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(5, 10, 0, 0),
                  child: Text(
                    '4.5',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'roboto',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(5, 10, 0, 0),
                  child: Consumer<Course>(
                    builder: (ctx, course, child) => IconButton(
                      icon: Icon(
                          course.isFavorite ? Icons.favorite : Icons.favorite_border),
                      color: Theme.of(context).accentColor,
                      onPressed: () {
                        course.toggleFavoriteStatus(authData.token, authData.userId);
                      },
                    ),
                  ),
                ),
              ],
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
