// The file which is to create new course from user input
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http; // for http request
import '../models/http_exception.dart';
import './review.dart';

import "package:intl/intl.dart";

class Reviews with ChangeNotifier {
  List<Review> _reviews = [];

  String courseId;
  String _starScore;
  var createdAt = DateFormat("yyyy/MM/dd").format(new DateTime.now());

  Reviews(
    this.courseId,
    this.createdAt,
    //this.starScore,
    this._reviews,
  );

  // getter for course
  List<Review> get reviews {
    return [..._reviews];
  }

  //Comparing ID of each products with id of the arguments
  Review findById(String id) {
    return _reviews.firstWhere((rv) => rv.courseId == id);
  }

  String get starScore {
    return _starScore;
  }

  Future<void> retrieveReviewData(String id) async {
    final url =
        'https://osu-course-search.firebaseio.com/reviews.json?orderBy="courseId"&equalTo="$id"';
    try {
      final response = await http.get(url); // get for fetching from DB
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      if (extractedData == null) {
        return;
      }

      final List<Review> loadedReviews = [];

      extractedData.forEach((reviewId, reviewData) {
        loadedReviews.add(Review(
          courseId: reviewId,
          reviewsContent: reviewData['reviewsContent'],
          starScore: reviewData['starScore'],
          createdAt: reviewData['createdAt'],
        ));
      });
      _reviews = loadedReviews;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addReview(Review review, String courseId, int starScore) async {
    final url = 'https://osu-course-search.firebaseio.com/reviews.json?';

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'courseId': courseId,
          'reviewsContent': review.reviewsContent,
          'starScore': starScore,
          'createdAt': review.createdAt,
        }),
      );

      final newReview = Review(
        courseId: json.decode(response.body)['name'],
        reviewsContent: review.reviewsContent,
        starScore: starScore,
        createdAt: review.createdAt,
      );
      _reviews.add(newReview); // add to reviews list
      notifyListeners(); // reflect results to children widget
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> deleteReview(String id) async {
    final url = 'https://osu-course-search.firebaseio.com/reviews/$id.json';
    final existingReviewIndex = _reviews.indexWhere((rv) => rv.courseId == id);
    var existingReview = _reviews[existingReviewIndex];
    _reviews.removeAt(existingReviewIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _reviews.insert(existingReviewIndex, existingReview);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    existingReview = null;
  }
}

// Future<void> updateReview(Review review, String courseId) async {
//   final reviewIndex = _reviews.indexWhere((rv) => rv.courseId == courseId);

//   if (reviewIndex >= 0) {
//     // target URL
//     final url = 'https://osu-course-search.firebaseio.com/reviews/$courseId.json';
//     await http.patch(url,
//         body: json.encode({
//           'reviewsContent': review.reviewsContent,
//         }));
//     _reviews[reviewIndex] = review;
//     notifyListeners();
//   } else {
//     print('...');
//   }
// }
