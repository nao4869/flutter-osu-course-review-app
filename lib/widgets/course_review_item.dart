import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/star_display.dart';
import '../models/review.dart';

class CourseReviewItem extends StatelessWidget {
  Widget _displayStarScore(int score) {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.fromLTRB(17, 10, 0, 0),
      child: StarDisplayWidget(
        value: score,
        filledStar: Icon(Icons.star, color: Colors.amber, size: 20),
        unfilledStar: Icon(Icons.star_border, color: Colors.grey),
      ),
    );
  }

  Widget _displayReviewsContent(String reviewContent) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 7,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
            child: Text(
              reviewContent,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _displayDateTime(dynamic createdAt) {
    return Container(
      alignment: Alignment.bottomRight,
      padding: EdgeInsets.fromLTRB(0, 10, 15, 5),
      child: Text(
        createdAt,
        style: TextStyle(
          color: Colors.black,
          fontSize: 15,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                _displayStarScore(review.starScore),
                _displayReviewsContent(review.reviewsContent),
                _displayDateTime(review.createdAt),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
