// The file which is to create new course from user input
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http; // for http request
import 'package:osu_course_review/models/institution.dart';

class Institutions with ChangeNotifier {
  List<Institution> _institutions = [
    // to do, add sample majors in here
  ];

  // getter for course
  List<Institution> get institutions {
    return [..._institutions];
  }

  //Comparing ID of each products with id of the arguments
  Institution findById(String id) {
    return _institutions.firstWhere((ins) => ins.id == id);
  }

  Future<void> retrieveInstitutionData() async {
    const url = 'https://osu-course-search.firebaseio.com/institutions.json';
    try {
      final response = await http.get(url); // get for fetching from DB
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      if (extractedData == null) {
        return;
      }

      final List<Institution> loadedInstitution = [];

      extractedData.forEach((institutionId, institutionData) {
        loadedInstitution.add(Institution(
          id: institutionId,
          name: institutionData['name'],
          country: institutionData['country'],
          state: institutionData['state'],
          city: institutionData['city'],
          logo: institutionData['logo'],
        ));
      });
      _institutions = loadedInstitution;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
