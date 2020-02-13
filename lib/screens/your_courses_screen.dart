// Control the entire contents of the first screens
// Displays lsit of loadedMajorCourses for the application

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/course_detail_screen.dart';
import '../models/courses_provider.dart';
import '../models/course.dart';
import '../widgets/course_item.dart';

enum FilterOptions {
  Favorites,
  All,
}

class YourCoursesScreen extends StatefulWidget {
  static const routeName = '/your-courses-screen';

  @override
  _YourCoursesScreenState createState() => _YourCoursesScreenState();
}

class _YourCoursesScreenState extends State<YourCoursesScreen> {
  var _isLoading = false;
  var _showOnlyFavorites = false;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<Courses>(context).retrieveCourseData().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final courseData = Provider.of<Courses>(context);
    final courses = courseData.courses;

    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed('/');
          },
          child: Text('University Course Search'),
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : LayoutBuilder(
              builder:
                  (BuildContext context, BoxConstraints viewportConstraints) {
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
                                  'Your subscribed courses',
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
                            padding: const EdgeInsets.all(15),
                            itemCount: 1,
                            itemBuilder: (ctx, i) =>
                                ChangeNotifierProvider.value(
                              value: courses[i],
                              child: CourseItem(_showOnlyFavorites),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showSearch(
            context: context,
            delegate: DataSearch(courses),
          );
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.search,
          color: Colors.white,
        ),
      ),
    );
  }
}

// class to search courses from all list
class DataSearch extends SearchDelegate<Course> {
  final List<Course> courses;
  final String searchFieldLabel = 'Search course name';

  DataSearch(this.courses);

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    // actions for app bar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // leading icon on the left of app bar
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final sugestionList = query.isEmpty
        ? courses
        : courses
            .where((cs) =>
                cs.courseName.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        leading: Icon(Icons.class_),
        title: Text(sugestionList[index].courseName.toString()),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CourseDetailScreen(),
              settings: RouteSettings(arguments: sugestionList[index].id),
            ),
          );
        },
      ),
      itemCount: sugestionList.length,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show when someone searches for something
    final sugestionList = query.isEmpty
        ? courses
        : courses
            .where((cs) =>
                cs.courseName.toLowerCase().contains(query.toLowerCase()))
            .toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        leading: Icon(Icons.class_),
        title: Text(sugestionList[index].courseName.toString()),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CourseDetailScreen(),
              settings: RouteSettings(arguments: sugestionList[index].id),
            ),
          );
        },
      ),
      itemCount: sugestionList.length,
    );
  }
}
