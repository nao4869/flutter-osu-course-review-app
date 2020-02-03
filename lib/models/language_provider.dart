// The file which is to create new course from user input
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http; // for http request
import 'package:osu_course_review/models/language.dart';
import '../models/http_exception.dart';

class Languages with ChangeNotifier {
  List<Language> _languages = [
    // to do, add sample majors in here
  ];

  // getter for course
  List<Language> get majors {
    return [..._languages];
  }

  //Comparing ID of each products with id of the arguments
  Language findById(String id) {
    return _languages.firstWhere((lg) => lg.id == id);
  }

  Future<void> retrieveLanguageData() async {
    const url = 'https://osu-course-search.firebaseio.com/languages.json';
    try {
      final response = await http.get(url); // get for fetching from DB
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      if (extractedData == null) {
        return;
      }

      final List<Language> loadedLanguage = [];

      extractedData.forEach((languageId, languageData) {
        loadedLanguage.add(Language(
          id: languageId,
          languageName: languageData['languageName'],
        ));
      });
      _languages = loadedLanguage;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
