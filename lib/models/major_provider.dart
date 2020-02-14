// The file which is to create new major from user input
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http; // for http request
import 'package:osu_course_review/models/major.dart';

class Majors with ChangeNotifier {
  List<Major> _majors = [
    // to do, add sample majors in here
  ];

  // String institutionName;
  // Majors(
  //   this.institutionName,
  //   this._majors,
  // );

  // getter for major
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
          institutionName: majorData['institutionName'],
          majorName: majorData['majorName'],
          logo: majorData['logo'],
        ));
      });
      _majors = loadedMajors;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addMajor(Major major) async {
    const url = 'https://osu-course-search.firebaseio.com/majors.json';

    print(major.institutionName);
    print(major.majorName);
    print(major.logo);

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'institutionName': major.institutionName,
          'majorName': major.majorName,
          'logo': major.logo,
        }),
      );

      final newMajor = Major(
        institutionName: major.institutionName,
        majorName: major.majorName,
        logo: major.logo,
        id: json.decode(response.body)['name'],
      );
      _majors.add(newMajor);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
