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

  Widget _progreeIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _displaySubHeader(String majorName) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Text(
              majorName + ' courses',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _displaySearchNavigator(List<Course> loadedMajorCourse,
      String institutionName, String majorName) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
      child: Container(
        height: 50,
        alignment: Alignment.center,
        padding: EdgeInsets.fromLTRB(17, 0, 17, 0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.search,
            ),
            loadedMajorCourse.isEmpty
                ? Expanded(
                    child: Text(
                      institutionName + majorName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      softWrap: false,
                    ),
                  )
                : Expanded(
                    child: Text(
                      '${loadedMajorCourse.first.institutionName}  |  ' +
                          majorName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      softWrap: false,
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _displaySearchResults(List<Course> loadedMajorCourse) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Container(
        height: 30,
        alignment: Alignment.center,
        padding: EdgeInsets.fromLTRB(10, 0, 17, 0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Text(
                'Search Results: ' + '${loadedMajorCourse.length}' + ' courses',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  fontFamily: 'Roboto',
                ),
                maxLines: 1,
                overflow: TextOverflow.clip,
                softWrap: false,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _displayListOfCourses(List<Course> loadedMajorCourse) {
    return Flexible(
      child: new ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        itemCount: loadedMajorCourse.length,
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          value: loadedMajorCourse[i],
          child: CourseListItem(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const title = 'University Course Search';

    dynamic args = ModalRoute.of(context).settings.arguments;
    var loadedMajorCourses = Provider.of<Courses>(context).findByMajor(args
        .majorName); // findByMajor returns list of courses where condition match

    final finalCourses = loadedMajorCourses
        .where((cs) => cs.institutionName == args.institutionName)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed('/');
          },
          child: Text(title),
        ),
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
          ? _progreeIndicator()
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
                        _displaySubHeader(args.majorName),
                        _displaySearchNavigator(
                            finalCourses, args.institutionName, args.majorName),
                        _displaySearchResults(finalCourses),
                        _displayListOfCourses(finalCourses),
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
            delegate: DataSearch(loadedMajorCourses),
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

class ScreenArguments {
  final institutionName;
  final majorName;

  ScreenArguments(this.institutionName, this.majorName);
}
