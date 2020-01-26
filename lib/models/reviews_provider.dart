// The file which is to create new course from user input
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http; // for http request

import '../models/http_exception.dart';
import './review.dart';

class Reviews with ChangeNotifier {
  List<Review> _reviews = [];

  // retrieving the courseId token
  final String courseId;

  Reviews(
    this.courseId,
    this._reviews,
  );

  // getter for course
  List<Review> get reviews {
    return [..._reviews];
  }

  //Comparing ID of each products with id of the arguments
  Review findById(String id) {
    return _reviews.firstWhere((rv) => rv.id == id);
  }

  Future<void> addReview(Review review) async {
    final url =
        'https://osu-course-search.firebaseio.com/courses/reviews.json&equalTo="$courseId"';

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'courseId': courseId,
          'reviewsContent': review.reviewsContent,
        }),
      );

      final newReview = Review(
        id: json.decode(response.body)['name'],
        reviewsContent: review.reviewsContent,
      );
      _reviews.add(newReview); // add to reviews list
      notifyListeners(); // reflect results to children widget
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
