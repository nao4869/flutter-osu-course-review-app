import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:osu_course_review/models/institution.dart';

class Major with ChangeNotifier {
  final String id;
  final String majorName;
  //final List<Institution> institutionName;
  final String institutionName;
  final String logo;

  Major({
    @required this.id,
    @required this.majorName,
    @required this.institutionName,
    @required this.logo,
  });
}
