import 'package:flutter/material.dart';
import 'package:osu_course_review/screens/list_courses_screen.dart';
import 'package:provider/provider.dart';

import '../models/major.dart';
import '../models/theme_provider.dart';

class MajorListItem extends StatefulWidget {
  @override
  _MajorListItemState createState() => _MajorListItemState();
}

class _MajorListItemState extends State<MajorListItem> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Widget _displayMajorLogo(String logo) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
      ),
      child: Image.network(
        logo,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _displayMajorName(String majorName, ThemeProvider theme) {
    return Expanded(
      child: Text(
        majorName,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: theme.getThemeData == lightTheme ? Colors.black : Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final major = Provider.of<Major>(context, listen: false);
    final theme = Provider.of<ThemeProvider>(context);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ListCoursesScreen(),
              settings: RouteSettings(
                arguments:
                    ScreenArguments(major.institutionName, major.majorName),
              ),
            ),
          );
        },
        splashColor: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(15),
        child: Column(
          children: <Widget>[
            _displayMajorLogo(major.logo),
            _displayMajorName(major.majorName, theme),
          ],
        ),
      ),
    );
  }
}

class ScreenArguments {
  final String institutionName;
  final String majorName;

  ScreenArguments(this.institutionName, this.majorName);
}
