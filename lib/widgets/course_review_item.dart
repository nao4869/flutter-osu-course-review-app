import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/create_review_screen.dart';

import '../models/reviews_provider.dart';
import '../models/review.dart';

class CourseReviewItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // retrieving providers objects
    final review = Provider.of<Review>(context, listen: false);

    return Container(
      padding: EdgeInsets.only(bottom: 10),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.purple),
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      width: 200,
                      child: Text(
                        review.reviewsContent,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    // IconButton(
                    //   icon: Icon(Icons.search),
                    //   color: Theme.of(context).primaryColor,
                    //   onPressed: () {
                    //     Navigator.of(context).pushNamed(
                    //         CourseDetailScreen.routeName,
                    //         arguments: review.id);
                    //   },
                    // ),
                    IconButton(
                      icon: Icon(Icons.edit),
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                            CreateReviewScreen.routeName,
                            arguments: review.id);
                      },
                    ),
                    // IconButton(
                    //   icon: Icon(Icons.delete),
                    //   color: Theme.of(context).errorColor,
                    //   onPressed: () {
                    //     Provider.of<Reviews>(context, listen: false)
                    //         .deleteCourse(review.id);
                    //   },
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
