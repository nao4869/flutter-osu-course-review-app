import 'package:flutter/material.dart';
import '../screens/course_detail_screen.dart';

class CourseListItem extends StatelessWidget {
  final String id;
  final String courseName;
  final Color color;

  CourseListItem(this.id, this.courseName, this.color);

  // function for moving page by selecting category items
  void selectCourse(BuildContext context) {
    // Navigator is a class to help navigate between class
    // add the new page to stuck by pushing
    Navigator.of(context).pushNamed(
      CourseDetailScreen.routeName,
      arguments: {
        'id': id,
        'courseName': courseName,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCourse(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(
          courseName,
          style: Theme.of(context).textTheme.title,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.7),
              color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
