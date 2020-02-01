// The file which is to create new course from user input
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http; // for http request
import './major.dart';
import '../models/http_exception.dart';

class Majors with ChangeNotifier {
  List<Major> _majors = [];

  // getter for course
  List<Major> get majors {
    return [..._majors];
  }

  //Comparing ID of each products with id of the arguments
  Major findById(String id) {
    return _majors.firstWhere((mj) => mj.id == id);
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
          color: majorData['color'],
        ));
      });
      _majors = loadedMajors;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addMajor(Major major) async {
    final url = 'https://osu-course-search.firebaseio.com/majors.json?';

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'majorName': major.majorName,
          'color': major.color,
        }),
      );

      final newMajor = Major(
        id: json.decode(response.body)['name'],
        majorName: major.majorName,
        color: major.color,
      );
      _majors.add(newMajor); // add to reviews list
      notifyListeners(); // reflect results to children widget
    } catch (error) {
      print(error);
      throw error;
    }
  }
}