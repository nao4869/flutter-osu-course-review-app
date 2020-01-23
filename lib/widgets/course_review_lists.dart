import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/review.dart';

class CourseReviewLists extends StatelessWidget {
  
  Widget _buildChildContainer(String text) {
    return Container(
      margin: EdgeInsets.fromLTRB(40, 3, 2, 3),
      alignment: Alignment.topLeft,
      child: Text(
        text,
        style: TextStyle(fontSize: 14.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final courseReviews = Provider.of<Review>(context, listen: false);

    return Card(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.purple),
          borderRadius: BorderRadius.circular(20),
        ),
        height: 200,
        child: Row(children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _buildChildContainer('${courseReviews.reviewsContent}'),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}