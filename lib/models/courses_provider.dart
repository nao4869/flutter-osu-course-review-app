// The file which is to create new course from user input
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http; // for http request
import './course.dart';
import '../models/http_exception.dart';

class Courses with ChangeNotifier {
  List<Course> _courses = [];

  String _courseId = 'LzKmxO3QJLd4R6kenZ9';

  // getter for course
  List<Course> get courses {
    return [..._courses];
  }

  //Comparing ID of each products with id of the arguments
  Course findById(String id) {
    return _courses.firstWhere((cs) => cs.id == id);
  }

  String get courseId {
    return _courseId;
  }

  Future<void> retrieveCourseData() async {
    const url = 'https://osu-course-search.firebaseio.com/courses.json';
    try {
      final response = await http.get(url); // get for fetching from DB
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      if (extractedData == null) {
        return;
      }
      
      final List<Course> loadedCourses = [];

      extractedData.forEach((courseId, courseData) {
        loadedCourses.add(Course(
          id: courseId,
          courseName: courseData['courseName'],
          courseContent: courseData['courseContent'],
          prerequisite: courseData['prerequisite'],
          proctoredexams: courseData['proctoredexams'],
          groupwork: courseData['groupwork'],
          textbook: courseData['textbook'],
        ));
      });
      _courses = loadedCourses;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
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
