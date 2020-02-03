import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Language with ChangeNotifier {
  final String id;
  final String languageName;

  Language({
    @required this.id,
    @required this.languageName,
  });
}
