// The file which is to create new course from user input
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http; // for http request
import '../models/http_exception.dart';
import './review.dart';
import './courses_provider.dart';
import './course.dart';

class Reviews with ChangeNotifier {
  List<Review> _reviews = [];

  // retrieving the reviewId token
  // temporary storing CS160's reviewId from FB
  //String reviewId;
  String courseId;

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

  Future<void> retrieveReviewData(String id) async {
    final url = 'https://osu-course-search.firebaseio.com/reviews.json?orderBy="courseId"&equalTo="$id"';
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
    final url = 'https://osu-course-search.firebaseio.com/reviews.json?';

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

  Future<void> updateReview(String id, Review newReview) async {
    final reviewIndex = _reviews.indexWhere((rv) => rv.id == id);

    if (reviewIndex >= 0) {
      // target URL
      final url = 'https://osu-course-search.firebaseio.com/reviews/$courseId/$id.json';
      await http.patch(url,
          body: json.encode({
            'reviewsContent': newReview.reviewsContent,
          }));
      _reviews[reviewIndex] = newReview;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteReview(String id) async {
    final url = 'https://osu-course-search.firebaseio.com/reviews/$courseId/$id.json';
    final existingReviewIndex = _reviews.indexWhere((rv) => rv.id == id);
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
