import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Review with ChangeNotifier {
  //final String id;
  final String courseId;
  final String reviewsContent;

  Review({
    //@required this.id,
    @required this.courseId,
    @required this.reviewsContent,
  });
}
