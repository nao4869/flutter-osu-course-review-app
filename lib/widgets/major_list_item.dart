import 'package:flutter/material.dart';
import 'package:osu_course_review/screens/list_courses_screen.dart';
import 'package:provider/provider.dart';

import '../models/major.dart';

class MajorListItem extends StatefulWidget {
  @override
  _MajorListItemState createState() => _MajorListItemState();
}

class _MajorListItemState extends State<MajorListItem> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final major = Provider.of<Major>(context, listen: false);

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
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: Image.network(
                major.logo,
                fit: BoxFit.contain,
              ),
            ),
            Expanded(
              child: Text(
                '${major.majorName}',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScreenArguments {
  final institutionName;
  final majorName;

  ScreenArguments(this.institutionName, this.majorName);
}
