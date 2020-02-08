// The file which is to create new course from user input
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http; // for http request
import 'package:osu_course_review/models/institution.dart';
import '../models/course.dart';

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
          courses: (institutionData['courses'] as List<dynamic>)
              .map((item) => Course(
                    id: item['id'],
                    courseName: item['courseName'],
                    courseContent: item['courseContent'],
                    prerequisite: item['prerequisite'],
                    proctoredexams: item['proctoredexams'],
                    groupwork: item['groupwork'],
                    textbook: item['textbook'],
                    language: item['language'],
                    major: item['major'],
                    institutionName: item['institutionName'],
                  ))
              .toList(),
        ));
      });
      _institutions = loadedInstitution;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addInstitution(
      Institution institution, List<Course> courses) async {
    const url = 'https://osu-course-search.firebaseio.com/institutions.json';

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'name': institution.name,
          'country': institution.country,
          'state': institution.state,
          'city': institution.city,
          'logo': institution.logo,
          'courses': courses
              .map((cs) => {
                    'id': cs.id,
                    'courseName': cs.courseName,
                    'courseContent': cs.courseContent,
                    'prerequisite': cs.prerequisite,
                    'proctoredexams': cs.proctoredexams,
                    'groupwork': cs.groupwork,
                    'textbook': cs.textbook,
                    'language': cs.language,
                    'major': cs.major,
                    'institutionName': cs.institutionName,
                  })
              .toList(),
        }),
      );

      final newCourse = Institution(
        name: institution.name,
        country: institution.country,
        state: institution.state,
        city: institution.city,
        logo: institution.logo,
        id: json.decode(response.body)['name'],
        courses: courses,
      );
      _institutions.add(newCourse);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
