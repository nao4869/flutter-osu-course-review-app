// Control the entire contents of the first screens
// Displays lsit of institutions for the application

import 'package:flutter/material.dart';
import 'package:osu_course_review/screens/list_majors_screen.dart';
import 'package:provider/provider.dart';

import '../models/institution_provider.dart';
import '../models/institution.dart';
import '../widgets/institution_list_item.dart';

class ListInstitutionScreen extends StatefulWidget {
  static const routeName = '/list-institutions-screen';

  @override
  _ListInstitutionScreenState createState() => _ListInstitutionScreenState();
}

class _ListInstitutionScreenState extends State<ListInstitutionScreen> {
  var _isLoading = false;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<Institutions>(context).retrieveInstitutionData().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final institutionList = Provider.of<Institutions>(context);
    final institutions = institutionList.institutions;

    return Scaffold(
      appBar: AppBar(
        title: Text('University Course Search'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : LayoutBuilder(
              builder:
                  (BuildContext context, BoxConstraints viewportConstraints) {
                return SingleChildScrollView(
                  child: Padding(
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
                              Container(
                                margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                child: Text(
                                  'Search course by Institution',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: double.infinity,
                            height: 750,
                            child: ListView.builder(
                              padding: const EdgeInsets.all(25),
                              itemCount: institutions.length,
                              itemBuilder: (ctx, i) =>
                                  ChangeNotifierProvider.value(
                                value: institutions[i],
                                child: InstitutionListItem(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showSearch(
            context: context,
            delegate: DataSearch(institutions),
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

// class to search institutions from all list
class DataSearch extends SearchDelegate<Institution> {
  final List<Institution> institutions;
  final String searchFieldLabel = 'Search course by institution';

  DataSearch(this.institutions);

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
        ? institutions
        : institutions
            .where(
                (ins) => ins.name.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        leading: Icon(Icons.school),
        title: Text(sugestionList[index].name.toString()),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ListMajorsScreen(),
              settings: RouteSettings(arguments: sugestionList[index].name),
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
        ? institutions
        : institutions
            .where(
                (ins) => ins.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        leading: Icon(Icons.school),
        title: Text(sugestionList[index].name.toString()),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ListMajorsScreen(),
              settings: RouteSettings(arguments: sugestionList[index].name),
            ),
          );
        },
      ),
      itemCount: sugestionList.length,
    );
  }
}
