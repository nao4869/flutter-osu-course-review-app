// The file which is to create new course from user input
import 'package:flutter/material.dart';
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
}
