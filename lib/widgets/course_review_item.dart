import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/star_display.dart';
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
              border: Border.all(color: Colors.white),
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.fromLTRB(17, 10, 0, 0),
                  child: StarDisplayWidget(
                    value: review.starScore,
                    filledStar: Icon(Icons.star, color: Colors.amber, size: 20),
                    unfilledStar: Icon(Icons.star_border, color: Colors.grey),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 7,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                        child: Text(
                          review.reviewsContent,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  padding: EdgeInsets.fromLTRB(0, 10, 15, 5),
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
