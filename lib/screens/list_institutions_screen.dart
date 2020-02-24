import 'package:flutter/material.dart';
import 'package:osu_course_review/screens/list_majors_screen.dart';
import 'package:provider/provider.dart';

import '../widgets/main_drawer.dart';
import '../models/institution_provider.dart';
import '../models/institution.dart';
import '../models/theme_provider.dart';
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

  Widget _displaySubHeader(String text, ThemeProvider theme) {
    return Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: Text(
            text,
            style: TextStyle(
              color: theme.getThemeData == lightTheme
                  ? Colors.black
                  : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }

  Widget _displayListOfInstitutions(
      List<Institution> loadedInstitutionsCourse) {
    return Flexible(
      child: new ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: const EdgeInsets.all(25),
        itemCount: loadedInstitutionsCourse.length,
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          value: loadedInstitutionsCourse[i],
          child: InstitutionListItem(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const title = 'University Course Search';
    const subheader = 'Search course by school';

    final institutionList = Provider.of<Institutions>(context);
    final institutions = institutionList.institutions;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed('/');
          },
          child: Text(title),
        ),
      ),
      drawer: MainDrawer(),
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
                        _displaySubHeader(subheader, themeProvider),
                        _displayListOfInstitutions(institutions),
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
    final theme = Provider.of<ThemeProvider>(context);
    final sugestionList = query.isEmpty
        ? institutions
        : institutions
            .where(
                (ins) => ins.name.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        leading: Icon(Icons.chevron_right),
        title: Text(
          sugestionList[index].name.toString(),
          style: TextStyle(
            color:
                theme.getThemeData == lightTheme ? Colors.black : Colors.white,
          ),
        ),
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
    final theme = Provider.of<ThemeProvider>(context);
    final sugestionList = query.isEmpty
        ? institutions
        : institutions
            .where(
                (ins) => ins.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        leading: Icon(Icons.chevron_right),
        title: Text(
          sugestionList[index].name.toString(),
          style: TextStyle(
            color:
                theme.getThemeData == lightTheme ? Colors.black : Colors.white,
          ),
        ),
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
