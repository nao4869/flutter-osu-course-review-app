// Control the entire contents of the first screens
// Displays lsit of loadedMajorCourses for the application

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/course_detail_screen.dart';
import '../models/courses_provider.dart';
import '../models/course.dart';
import '../widgets/course_list_item.dart';

class ListCoursesScreen extends StatefulWidget {
  static const routeName = '/list-loadedMajorCourses-screen';

  @override
  _ListCoursesScreenState createState() => _ListCoursesScreenState();
}

class _ListCoursesScreenState extends State<ListCoursesScreen> {
  var _isLoading = false;

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
    final majorName = ModalRoute.of(context).settings.arguments
        as String; // retrieving majorName passed from list majors screen
    final loadedMajorCourses = Provider.of<Courses>(context).findByMajor(
        majorName); // findByMajor returns list of courses where condition match

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
            ),
            iconSize: 24,
            onPressed: () {
              showSearch(
                context: context,
                delegate: DataSearch(loadedMajorCourses),
              );
            },
          )
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: ListView.builder(
                padding: const EdgeInsets.all(25),
                itemCount: loadedMajorCourses.length,
                itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                  value: loadedMajorCourses[i],
                  child: CourseListItem(),
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pushNamed('/');
        },
        label: Text(
          'New-Review',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        icon: Icon(
          Icons.create,
          color: Colors.white,
        ),
      ), //
    );
  }
}

// class to search courses from all list
class DataSearch extends SearchDelegate<Course> {
  final List<Course> courses;

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
        : courses.where((cs) => cs.courseName.toLowerCase().contains(query.toLowerCase())).toList();
    
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        leading: Icon(Icons.class_),
        title: Text(sugestionList[index].courseName.toString()),
        onTap: () {
          Navigator.of(context).pushNamed(CourseDetailScreen.routeName,
              arguments: sugestionList[index].id);
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
          Navigator.of(context).pushNamed(CourseDetailScreen.routeName,
              arguments: sugestionList[index].id);
        },
      ),
      itemCount: sugestionList.length,
    );
  }
}
