import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/courses_provider.dart';
import '../models/auth.dart';
import '../widgets/course_item.dart';

class YourCourses extends StatefulWidget {
  static const routeName = '/user-favorites';

  @override
  _YourCoursesState createState() => _YourCoursesState();
}

class _YourCoursesState extends State<YourCourses> {
  var _isLoading = false;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Courses>(context).retrieveUsersCourseData().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    });
    super.initState();
  }

  //test2@gmail.com
  @override
  Widget build(BuildContext context) {
    final courseData = Provider.of<Courses>(context);
    final courses = courseData.courses;
    const t = 'University Course Search';

    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed('/');
          },
          child: Text(t),
        ),
        actions: <Widget>[],
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Text(
                            'Your courses',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Flexible(
                    child: new ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(25),
                      itemCount: courses.length,
                      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                        value: courses[i],
                        child: CourseItem(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
