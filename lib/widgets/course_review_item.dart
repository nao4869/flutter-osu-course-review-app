import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "package:intl/intl.dart";

import '../models/review.dart';

class CourseReviewItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // retrieving providers objects
    final review = Provider.of<Review>(context, listen: false);

    return Container(
      padding: EdgeInsets.only(bottom: 15),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.purple),
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                      width: 350,
                      child: Text(
                        review.reviewsContent,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  padding: EdgeInsets.fromLTRB(0, 0, 15, 5),
                  child: Text(
                    review.createdAt,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// IconButton(
//   icon: Icon(Icons.edit),
//   color: Theme.of(context).primaryColor,
//   onPressed: () {
//     Navigator.of(context).pushNamed(
//         CreateReviewScreen.routeName,
//         arguments: review.courseId);
//   },
// ),
// IconButton(
//   icon: Icon(Icons.delete),
//   color: Theme.of(context).errorColor,
//   onPressed: () {
//     // retrieve the loaded course id
//     final courseId = ModalRoute.of(context).settings.arguments as String;
//     Provider.of<Reviews>(context, listen: false)
//         .deleteReview(courseId);
//   },
// ),
