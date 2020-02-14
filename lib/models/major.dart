import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Major with ChangeNotifier {
  final String id;
  final String institutionName;
  final String majorName;
  final String logo;

  Major({
    @required this.id,
    @required this.institutionName,
    @required this.majorName,
    @required this.logo,
  });
}
