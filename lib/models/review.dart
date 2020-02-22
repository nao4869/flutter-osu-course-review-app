import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Review with ChangeNotifier {
  final String institutionName;
  final String courseId;
  final String reviewsContent;
  final int starScore;
  final String createdAt;

  Review({
    @required this.institutionName,
    @required this.courseId,
    @required this.reviewsContent,
    @required this.starScore,
    @required this.createdAt,
  });
}
