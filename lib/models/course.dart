import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Course with ChangeNotifier {
  final String id;
  final String courseName;
  final String courseContent;
  final String prerequisite;
  final String proctoredexams;
  final String groupwork;
  final String textbook;
  final String language;
  final String major;
  final String institutionName;
  bool isFavorite;

  Course({
    @required this.id,
    @required this.courseName,
    @required this.courseContent,
    @required this.prerequisite,
    @required this.proctoredexams,
    @required this.groupwork,
    @required this.textbook,
    this.language,
    @required this.major,
    @required this.institutionName,
    this.isFavorite,
  });

  void _setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(String token, String userId) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url =
        'https://osu-course-search.firebaseio.com/$userId/$id.json?auth=$token';

    try {
      final response = await http.put(
        url,
        body: json.encode(
          isFavorite,
        ),
      );
      // if there is error adding favorite, return to old status
      if (response.statusCode >= 400) {
        _setFavValue(oldStatus);
      }
    } catch (error) {
      isFavorite = oldStatus;
      notifyListeners(); // call to update UI
    }
  }
}
