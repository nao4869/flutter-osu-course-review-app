// Control the entire contents of the first screens
// Displays lsit of courses for the application

import 'package:flutter/material.dart';
import 'package:osu_course_review/screens/list_courses_screen.dart';
import 'package:provider/provider.dart';

import '../models/star_display.dart';
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

  @override
  Widget build(BuildContext context) {
    final institutionName = ModalRoute.of(context).settings.arguments
        as String; // retrieving majorName passed from list majors screen
    final loadedInstitutionMajors = Provider.of<Majors>(context).findBySchool(
        institutionName); // findByMajor returns list of courses where condition match

    final majorList = Provider.of<Majors>(context);
    var ddv;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('University Course Search'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 25, 0, 0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                ListCoursesScreen.routeName,
                                arguments: majorList.majors);
                          },
                          child: Text(
                            'Search course by Major',
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
                  Container(
                    width: double.infinity,
                    child: GridView.builder(
                      padding: const EdgeInsets.all(25),
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 1.3,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                      ),
                      shrinkWrap: true,
                      itemCount: loadedInstitutionMajors.length,
                      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                        value: loadedInstitutionMajors[i],
                        child: MajorListItem(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Button pressed');
          Container(
            child: DropdownButton<Major>(
              value: ddv,
              elevation: 0,
              underline: null,
              onChanged: (Major newValue) {
                setState(() {
                  ddv = newValue;
                  Navigator.of(context).pushNamed(ListCoursesScreen.routeName,
                      arguments: ddv.id);
                });
              },
              items: loadedInstitutionMajors.map((Major value) {
                return DropdownMenuItem<Major>(
                  value: value,
                  child: Text(
                    value.majorName.toString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 13,
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        },
        child: Icon(
          Icons.search,
          color: Colors.white,
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
