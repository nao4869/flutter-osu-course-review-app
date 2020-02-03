import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Language with ChangeNotifier {
  final String id;
  final String languageName;
  final Color color;

  Language({
    @required this.id,
    @required this.languageName,
    this.color = Colors.orange, // default color
  });
}
