import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Review with ChangeNotifier {
  final String courseId;
  final String institutionName;
  final String reviewsContent;
  final int starScore;
  var createdAt;

  Review({
    @required this.courseId,
    @required this.institutionName,
    @required this.reviewsContent,
    @required this.starScore,
    @required this.createdAt,
  });
}
