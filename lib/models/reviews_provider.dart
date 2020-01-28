// The file which is to create new course from user input
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http; // for http request
import '../models/http_exception.dart';
import './review.dart';
import './courses_provider.dart';

class Reviews with ChangeNotifier {
  List<Review> _reviews = [];

  // retrieving the reviewId token
  // temporary storing CS160's reviewId from FB
  String reviewId;
  String courseId = 'LzKmQS6x5t4e946iVe4';

  Reviews(
    this.reviewId,
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

  Future<void> retrieveReviewData() async {
    final url = 'https://osu-course-search.firebaseio.com/reviews/$courseId.json';
    try {
      final response = await http.get(url); // get for fetching from DB
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      if (extractedData == null) {
        return;
      }
      
      final List<Review> loadedReviews = [];

      extractedData.forEach((reviewId, reviewData) {
        loadedReviews.add(Review(
          id: reviewId,
          reviewsContent: reviewData['reviewsContent'],
        ));
      });
      _reviews = loadedReviews;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addReview(Review review) async {
    final url = 'https://osu-course-search.firebaseio.com/reviews/$reviewId.json?course=$reviewId';

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'reviewId': reviewId,
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
