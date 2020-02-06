import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Major with ChangeNotifier {
  final String id;
  final String majorName;
  final String institutionName;
  final String logo;
  final Color color;

  Major({
    @required this.id,
    @required this.majorName,
    @required this.institutionName,
    @required this.logo,
    this.color = Colors.orange, // default color
  });
}
