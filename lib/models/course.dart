import 'package:flutter/material.dart';

class Course {
  final String id;
  final String courseName;
  final String courseContent;
  final String prerequisite;
  final String proctoredexams;
  final String groupwork;
  final String textbook;

  const Course({
    @required this.id, 
    @required this.courseName, 
    @required this.courseContent, 
    @required this.prerequisite,
    @required this.proctoredexams, 
    @required this.groupwork, 
    @required this.textbook, 
  });
}