// Control the entire contents of the first screens
// Displays lsit of majors for the application

import 'package:flutter/material.dart';
import 'package:osu_course_review/screens/list_courses_screen.dart';
import 'package:provider/provider.dart';
import '../screens/create_major_screen.dart';
import '../screens/list_courses_screen.dart';
import '../models/major_provider.dart';
import '../models/major.dart';
import '../widgets/major_list_item.dart';

class ListMajorsScreen extends StatefulWidget {
  static const routeName = '/major-list';

  @override
  _ListMajorsScreenState createState() => _ListMajorsScreenState();
}

class _ListMajorsScreenState extends State<ListMajorsScreen> {
  var _isLoading = false;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      setState(() {
        _isLoading = true;
      });
      //Provider.of<Institutions>(context).retrieveInstitutionData();
      Provider.of<Majors>(context).retrieveMajorData().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    });
    super.initState();
  }

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 5, 0, 10),
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _displaySubHeader(Majors majorList, String institutionName) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(ListCoursesScreen.routeName,
                    arguments: majorList.majors);
              },
              child: Text(
                '$institutionName\'s majors',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _displayGridView(List<Major> loadedInstitutionMajors) {
    return Flexible(
      child: new GridView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: const EdgeInsets.all(25),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 1.3,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: loadedInstitutionMajors.length,
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          value: loadedInstitutionMajors[i],
          child: MajorListItem(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const title = 'University Course Search';

    final institutionName = ModalRoute.of(context).settings.arguments
        as String; // retrieving majorName passed from list majors screen
    final loadedInstitutionMajors = Provider.of<Majors>(context).findBySchool(
        institutionName); // findByMajor returns list of majors where condition match

    final majorList = Provider.of<Majors>(context);

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: GestureDetector(
          child: Text(title),
          onTap: () {
            Navigator.of(context).pushNamed('/');
          },
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
                delegate: DataSearch(loadedInstitutionMajors),
              );
            },
          )
        ],
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
                        _displaySubHeader(majorList, institutionName),
                        _displayGridView(loadedInstitutionMajors),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateMajorScreen(),
            ),
          );
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

// class to search majors from all list
class DataSearch extends SearchDelegate<Major> {
  final List<Major> majors;
  final String searchFieldLabel = 'Search course by major';

  DataSearch(this.majors);

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
        ? majors
        : majors
            .where((mj) =>
                mj.majorName.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        leading: Icon(Icons.chevron_right),
        title: Text(sugestionList[index].majorName.toString()),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ListCoursesScreen(),
              settings: RouteSettings(
                arguments: ScreenArguments(
                  'Extract Arguments Screen',
                  'This message is extracted in the build method.',
                ),
              ),
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
        ? majors
        : majors
            .where((mj) =>
                mj.majorName.toLowerCase().contains(query.toLowerCase()))
            .toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        leading: Icon(Icons.chevron_right),
        title: Text(sugestionList[index].majorName.toString()),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ListCoursesScreen(),
              settings: RouteSettings(
                arguments: ScreenArguments(sugestionList[index].institutionName,
                    sugestionList[index].majorName),
              ),
            ),
          );
        },
      ),
      itemCount: sugestionList.length,
    );
  }
}

class ScreenArguments {
  final String institutionName;
  final String majorName;

  ScreenArguments(this.institutionName, this.majorName);
}
