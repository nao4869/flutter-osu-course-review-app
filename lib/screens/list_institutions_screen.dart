// Control the entire contents of the first screens
// Displays lsit of institutions for the application

import 'package:flutter/material.dart';
import 'package:osu_course_review/screens/list_majors_screen.dart';
import 'package:provider/provider.dart';

import '../models/institution_provider.dart';
import '../models/institution.dart';
import '../widgets/institution_list_item.dart';

class ListInstitutionScreen extends StatefulWidget {
  static const routeName = '/list-courses-screen';

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
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 25, 0, 0),
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
                  height: 500,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(25),
                    itemCount: institutions.length,
                    itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                      value: institutions[i],
                      child: InstitutionListItem(),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
