import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../models/course.dart';

class Institution with ChangeNotifier {
  final String id;
  final String name;
  final String country;
  final String state;
  final String city;
  final String logo;
  List<Course> courses;

  Institution({
    @required this.id,
    @required this.name,
    @required this.country,
    @required this.state,
    @required this.city,
    @required this.logo,
    @required this.courses,
  });
}
