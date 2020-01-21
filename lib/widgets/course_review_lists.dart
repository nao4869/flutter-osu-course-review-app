import 'package:flutter/material.dart';
//import 'package:osu_course_review/widgets/course_list_item.dart';
//import '../models/course.dart';
//import '../screens/course_detail_screen.dart';

class CourseReviewLists extends StatelessWidget {
  final String id;
  final String courseId;
  final String reviewsContent;

  CourseReviewLists({
    @required this.id,
    @required this.courseId,
    @required this.reviewsContent,
  });

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
                _buildChildContainer('$reviewsContent'),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}