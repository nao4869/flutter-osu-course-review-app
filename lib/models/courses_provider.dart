// The file which is to create new course from user input
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http; // for http request
import './course.dart';
import '../models/http_exception.dart';

class Courses with ChangeNotifier {
  List<Course> _courses = [];

  String _courseId;
  String _insitutionName;
  String _majorName;

  final String authToken;
  final String userId;

  Courses(
    this.authToken,
    this.userId,
    this._courses,
  );

  // getter for course
  List<Course> get courses {
    return [..._courses];
  }

  // function to return user favorite course
  List<Course> get favoriteItems {
    return _courses.where((cs) => cs.isFavorite == true).toList();
  }

  //Comparing ID of each courses with id of the arguments
  Course findById(String id) {
    return _courses.firstWhere((cs) => cs.id == id);
  }

  //Comparing major name of each courses with majorName of the arguments
  List<Course> findByMajor(String majorName) {
    return [..._courses.where((mj) => mj.major == majorName)];
  }

  String get courseId {
    return _courseId;
  }

  String get insitutionName {
    return _insitutionName;
  }

  String get majorName {
    return _majorName;
  }

  Future<void> retrieveCourseData() async {
    // print(filterByUser);
    // final filterString =
    //     filterByUser ? 'orderBy="courseId"&equalTo="/userFavorites/$userId.json"' : '';
    var url = 'https://osu-course-search.firebaseio.com/courses.json';
    try {
      final response = await http.get(url); // get for fetching from DB
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      if (extractedData == null) {
        return;
      }
      //final filterString = filterByUser ? 'orderBy="courseId"&equalTo="$userId"' : '';
      url =
          'https://osu-course-search.firebaseio.com/userFavorites/$userId.json?auth=$authToken';
      final favoriteResponse = await http.get(url);
      final favoriteData = json.decode(favoriteResponse.body);
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
          language: courseData['language'],
          major: courseData['major'],
          institutionName: courseData['institutionName'],
          isFavorite:
              favoriteData == null ? false : favoriteData[courseId] ?? false,
        ));
      });
      _courses = loadedCourses;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
  //test2@gmail.com
  Future<void> retrieveUsersCourseData() async {
    var url = 'https://osu-course-search.firebaseio.com/courses.json';
    try {
      final response = await http.get(url); // get for fetching from DB
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      if (extractedData == null) {
        return;
      }
      url =
          'https://osu-course-search.firebaseio.com/userFavorites/$userId.json?auth=$authToken';
      final favoriteResponse = await http.get(url);
      final favoriteData = json.decode(favoriteResponse.body);
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
          language: courseData['language'],
          major: courseData['major'],
          institutionName: courseData['institutionName'],
          isFavorite:
              favoriteData == null ? false : favoriteData[courseId] ?? false,
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
          'language': course.language,
          'major': course.major,
          'institutionName': course.institutionName,
        }),
      );

      final newCourse = Course(
        courseName: course.courseName,
        courseContent: course.courseContent,
        prerequisite: course.prerequisite,
        proctoredexams: course.proctoredexams,
        groupwork: course.proctoredexams,
        textbook: course.textbook,
        language: course.language,
        major: course.major,
        institutionName: course.institutionName,
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
            'language': newCourse.language,
            'major': newCourse.major,
            'institutionName': newCourse.institutionName,
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
