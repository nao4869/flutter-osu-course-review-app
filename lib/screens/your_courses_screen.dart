import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/courses_provider.dart';

class YourCourses extends StatefulWidget {
  static const routeName = '/user-favorites';

  @override
  _YourCoursesState createState() => _YourCoursesState();
}

class _YourCoursesState extends State<YourCourses> {
  // fetch the user favorite course data
  Future<void> _refreshCourses(BuildContext context) async {
    await Provider.of<Courses>(context, listen: false).retrieveCourseData(true);
  }

  @override
  Widget build(BuildContext context) {
    const t = 'University Course Search';
    return Scaffold(
      appBar: AppBar(
        title: Text(t),
      ),
      body: FutureBuilder(
        future: _refreshCourses(context),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () => _refreshCourses(context),
                    child: Consumer<Courses>(
                      builder: (ctx, courseData, _) => Padding(
                        padding: EdgeInsets.all(8),
                        child: ListView.builder(
                          itemCount: courseData.courses.length,
                          itemBuilder: (_, i) => Column(
                            children: <Widget>[
                              UserCourseItem(
                                courseData.courses[i].id,
                                courseData.courses[i].courseName,
                                courseData.courses[i].courseContent,
                              ),
                              Divider(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
