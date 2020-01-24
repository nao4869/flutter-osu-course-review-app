// The file which is to create new course from user input
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http; // for http request
import './course.dart';
import '../models/http_exception.dart';

class Courses with ChangeNotifier {
  List<Course> _courses = [
    Course(
      id: 'c1',
      courseName: 'CS160 - Computer Orientation',
      courseContent:
          'Introduction to the computer science field and profession. Team problem solving. Introduction to writing computer programs.',
      prerequisite: 'None',
      proctoredexams: 'None',
      groupwork: 'None',
      textbook: 'None',
      color: Colors.purple,
    ),
    Course(
      id: 'c2',
      courseName: 'CS161 - Intro to computer science1',
      courseContent:
          'Overview of fundamental concepts of computer science. Introduction to problem solving, software engineering, and object-oriented programming. Includes algorithm design and program development. Students write small programs in C++.',
      prerequisite: 'None',
      proctoredexams: 'Yes',
      groupwork: 'None',
      textbook: 'Starting Out with C++: Early Objects (9th edition)',
      color: Colors.red,
    ),
    Course(
      id: 'c3',
      courseName: 'CS162 - Intro to computer science2',
      courseContent:
          'Introduces data structures, algorithms, and requires students to produce weekly labs and larger bi-weekly projects in C++.',
      prerequisite: 'CS161',
      proctoredexams: 'No',
      groupwork:
          'One group project halfway through the quarter where a team of about 5 students implements a given program in C++',
      textbook: 'Starting Out with C++: Early Objects (9th edition)',
      color: Colors.orange,
    ),
    Course(
      id: 'c4',
      courseName: 'CS261 - Data Structures',
      courseContent:
          'Teaches abstract data types, dynamic arrays, linked lists, trees and graphs, binary search trees, hash tables, storage management, complexity analysis of data structures. Classwork is done in C (not C++).',
      prerequisite: 'CS162 or CS165 and CS225',
      proctoredexams: 'Yes',
      groupwork:
          'Weekly worksheets to complete and discuss in a small group. Must submit typed meeting minutes to Piazza each week.',
      textbook: 'C Programming Language (2nd edition)',
      color: Colors.amber,
    ),
    Course(
      id: 'c5',
      courseName: 'CS271 - Assembly Language',
      courseContent:
          'Introduction to functional organization and operation of digital computers. Coverage of assembly language; addressing, stacks, argument passing, arithmetic operations, decisions, macros, modularization, linkers and debuggers.',
      prerequisite: 'CS161 or CS165',
      proctoredexams: 'Yes',
      groupwork: 'None',
      textbook: 'Assembly Language for x86 Processors (7th edition)',
      color: Colors.blue,
    ),
    Course(
      id: 'c6',
      courseName: 'CS290 - Web development',
      courseContent:
          'How to design and implement a multi-tier application using web technologies: creation of extensive custom client- and server-side code, consistent with achieving a high-quality software architecture.',
      prerequisite: 'CS162 or CS165',
      proctoredexams: 'Yes',
      groupwork: 'None',
      textbook:
          'Eloquent JavaScript, 2nd Ed.: A Modern Introduction to Programming (2nd edition)',
      color: Colors.green,
    ),
  ];

  // getter for course
  List<Course> get courses {
    return [..._courses];
  }

  //Comparing ID of each products with id of the arguments
  Course findById(String id) {
    return _courses.firstWhere((cs) => cs.id == id);
  }

  Future<void> addCourse(Course course) async {
    const url = 'https://osu-course-search.firebaseio.com/courses.json';

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'courseName': course.courseName,
          'courseContent': course.courseContent,
          'prerequisite': course.prerequisite,
          'proctoredexams': course.proctoredexams,
          'groupwork': course.groupwork,
          'textbook': course.textbook,
        }),
      );

      final newCourse = Course(
        courseName: course.courseName,
        courseContent: course.courseContent,
        prerequisite: course.prerequisite,
        proctoredexams: course.proctoredexams,
        groupwork: course.proctoredexams,
        textbook: course.textbook,
        id: json.decode(response.body)['name'],
      );
      _courses.add(newCourse);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateCourse(String id, Course newCourse) async {
    final courseIdenx = _courses.indexWhere((cs) => cs.id == id);

    if (courseIdenx >= 0) {
      // target URL
      final url = 'https://osu-course-search.firebaseio.com/courses/$id.json';
      await http.patch(url,
          body: json.encode({
            'courseName': newCourse.courseName,
            'courseContent': newCourse.courseContent,
            'prerequisite': newCourse.prerequisite,
            'proctoredexams': newCourse.proctoredexams,
            'groupwork': newCourse.groupwork,
            'textbook': newCourse.textbook,
          }));
      _courses[courseIdenx] = newCourse;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteCourse(String id) async {
    final url = 'https://osu-course-search.firebaseio.com/courses/$id.json';
    final existingCourseIndex = _courses.indexWhere((cs) => cs.id == id);
    var existingCourse = _courses[existingCourseIndex];
    _courses.removeAt(existingCourseIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _courses.insert(existingCourseIndex, existingCourse);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    existingCourse = null;
  }
}
