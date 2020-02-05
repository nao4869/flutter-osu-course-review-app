import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../models/review.dart';

class Course with ChangeNotifier {
  final String id;
  final String courseName;
  final String courseContent;
  final String prerequisite;
  final String proctoredexams;
  final String groupwork;
  final String textbook;
  final String language;
  final String major;
  final String institutionId;

  //String _courseId;

  Course({
    @required this.id,
    @required this.courseName,
    @required this.courseContent,
    @required this.prerequisite,
    @required this.proctoredexams,
    @required this.groupwork,
    @required this.textbook,
    this.language,
    @required this.major,
    @required this.institutionId,
  });
}
