// The file which is to create new course from user input
import 'package:flutter/material.dart';
import './review.dart';

class Reviews with ChangeNotifier {
  List<Review> _reviews = [
    Review(
      id: 'r1',
      courseId: 'c1',
      reviewsContent:
          'CS160: Do Repl.it code problems; study the model solutions carefully.',
    ),
    Review(
      id: 'r2',
      courseId: 'c1',
      reviewsContent:
          'CS160: Do your best to stay on top of things and get help from TAs/Slack/Piazza.',
    ),
    Review(
      id: 'r3',
      courseId: 'c1',
      reviewsContent:
          'CS160: No textbook required, but free online PDF helps a lot when understanding material. Don\'t get behind on early material as is all reused on assignments... especially classes.',
    ),
    Review(
      id: 'r4',
      courseId: 'c2',
      reviewsContent:
          'CS161: No textbook required, but free online PDF helps a lot when understanding material. Don\'t get behind on early material as is all reused on assignments... especially classes.',
    ),
    Review(
      id: 'r5',
      courseId: 'c2',
      reviewsContent:
          'CS161: No textbook required, but free online PDF helps a lot when understanding material. Don\'t get behind on early material as is all reused on assignments... especially classes.',
    ),
    Review(
      id: 'r6',
      courseId: 'c3',
      reviewsContent:
          'CS162: No textbook required, but free online PDF helps a lot when understanding material. Don\'t get behind on early material as is all reused on assignments... especially classes.',
    ),
  ];

  // getter for course
  List<Review> get reviews {
    return [..._reviews];
  }

  //Comparing ID of each products with id of the arguments
  Review findById(String id) {
    return _reviews.firstWhere((rv) => rv.id == id);
  }
}
