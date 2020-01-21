import 'package:flutter/foundation.dart';

class Review {
  @required
  final String id;
  final String courseId;
  final String reviewsContent;

  const Review({
    @required this.id,
    @required this.courseId,
    @required this.reviewsContent,
  });
}
