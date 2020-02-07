// The file which is to create new course from user input
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http; // for http request
import './major.dart';
import '../models/http_exception.dart';

class Majors with ChangeNotifier {
  List<Major> _majors = [
    // to do, add sample majors in here
  ];

  // getter for course
  List<Major> get majors {
    return [..._majors];
  }

  //Comparing ID of each products with id of the arguments
  Major findById(String id) {
    return _majors.firstWhere((mj) => mj.id == id);
  }

  //Comparing major name of each courses with majorName of the arguments
  List<Major> findBySchool(String schoolName) {
    return [..._majors.where((sc) => sc.institutionName == schoolName)];
  }

  Future<void> retrieveMajorData() async {
    const url = 'https://osu-course-search.firebaseio.com/majors.json';
    try {
      final response = await http.get(url); // get for fetching from DB
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      if (extractedData == null) {
        return;
      }

      final List<Major> loadedMajors = [];

      extractedData.forEach((majorId, majorData) {
        loadedMajors.add(Major(
          id: majorId,
          majorName: majorData['majorName'],
          institutionName: majorData['institutionName'],
          logo: majorData['logo'],
        ));
      });
      _majors = loadedMajors;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
