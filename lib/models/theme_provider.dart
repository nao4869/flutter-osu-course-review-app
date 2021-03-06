import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool isLightTheme;

  ThemeProvider({this.isLightTheme});

  ThemeData get getThemeData => isLightTheme ? lightTheme : darkTheme;

  set setThemeData(bool val) {
    if (val) {
      isLightTheme = true;
    } else {
      isLightTheme = false;
    }
    notifyListeners();
  }
}

final darkTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.black,
  brightness: Brightness.dark,
  fontFamily: 'Raleway',
  backgroundColor: Color(0xFF000000),
  accentColor: Colors.red,
  accentIconTheme: IconThemeData(color: Colors.black),
  dividerColor: Colors.black54,
  textTheme: ThemeData.light().textTheme.copyWith(
        body1: TextStyle(
          color: Color.fromRGBO(20, 51, 51, 1),
        ),
        body2: TextStyle(
          color: Color.fromRGBO(20, 51, 51, 1),
        ),
        title: TextStyle(
          fontSize: 20,
          fontFamily: 'RobotoCondensed',
          fontWeight: FontWeight.bold,
        ),
      ),
);

final lightTheme = ThemeData(
  primarySwatch: Colors.red,
  primaryColor: Colors.red,
  accentColor: Colors.amberAccent,
  brightness: Brightness.light,
  backgroundColor: Color(0xFFE5E5E5),
  accentIconTheme: IconThemeData(color: Colors.white),
  dividerColor: Colors.white54,
  fontFamily: 'Raleway',
  textTheme: ThemeData.light().textTheme.copyWith(
        body1: TextStyle(
          color: Color.fromRGBO(20, 51, 51, 1),
        ),
        body2: TextStyle(
          color: Color.fromRGBO(20, 51, 51, 1),
        ),
        title: TextStyle(
          fontSize: 20,
          fontFamily: 'RobotoCondensed',
          fontWeight: FontWeight.bold,
        ),
      ),
);
