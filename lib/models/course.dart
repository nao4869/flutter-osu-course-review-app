import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Course with ChangeNotifier {
  final String id;
  final String courseName;
  final String courseContent;
  final String prerequisite;
  final String proctoredexams;
  final String groupwork;
  final String textbook;

  //String _courseId;

  Course({
    @required this.id,
    @required this.courseName,
    @required this.courseContent,
    @required this.prerequisite,
    @required this.proctoredexams,
    @required this.groupwork,
    @required this.textbook,
  });

  // String get courseId {
  //   return _courseId;
  // }
}
