import 'package:flutter/material.dart';

class CourseDetail extends StatelessWidget {
  final String id;
  final String courseName;
  final String courseContent;
  final String prerequisite;
  final String proctoredexams;
  final String groupwork;
  final String textbook;

  CourseDetail({
    @required this.id,
    @required this.courseName,
    @required this.courseContent,
    @required this.prerequisite,
    @required this.proctoredexams,
    @required this.groupwork,
    @required this.textbook,
  });

  Widget _buildChildContainerBold(String text) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
      alignment: Alignment.topCenter,
      child: Text(
        text,
        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
      ),
    );
  }

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
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(30),
        ),
        width: double.infinity,
        height: double.infinity,
        child: Row(children: <Widget>[
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _buildChildContainerBold('$courseName'),
                _buildChildContainer('Course Content: $courseContent'),
                _buildChildContainer('Pre-requisite of course: $prerequisite'),
                _buildChildContainer('Proctored Exams: $proctoredexams'),
                _buildChildContainer('Group Work: $groupwork'),
                _buildChildContainer('Textbook: $textbook'),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
