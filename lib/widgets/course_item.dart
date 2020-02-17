import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/courses_provider.dart';
import '../widgets/course_item_display.dart';

class CourseItem extends StatelessWidget {
  final bool showFavorites;
  CourseItem(this.showFavorites);
  @override
  Widget build(BuildContext context) {
    // retrieving providers objects
    final courseData = Provider.of<Courses>(context, listen: false);
    final courses = courseData.favoriteItems;

    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: courses.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: courses[i],
        child: CourseItemDisplay(),
      ),
    );
  }
}
