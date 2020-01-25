import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Review with ChangeNotifier {
  final String id;
  final String reviewsContent;

  Review({
    @required this.id,
    @required this.reviewsContent,
  });
}
