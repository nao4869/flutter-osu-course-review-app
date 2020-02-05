import 'package:flutter/material.dart';
import 'package:osu_course_review/screens/course_detail_screen.dart';
import 'package:osu_course_review/screens/list_majors_screen.dart';
import 'package:provider/provider.dart';

import '../models/institution.dart';

class InstitutionListItem extends StatefulWidget {
  @override
  _InstitutionListItemState createState() => _InstitutionListItemState();
}

class _InstitutionListItemState extends State<InstitutionListItem> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    // retrieving providers objects
    final institution = Provider.of<Institution>(context, listen: false);

    return Container(
      padding: EdgeInsets.only(bottom: 10),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 8, 0, 0),
                      child: GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.school,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(15, 8, 0, 0),
                      width: 300,
                      child: Text(
                        institution.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(17, 0, 17, 0),
                  child: ButtonTheme(
                    minWidth: double.infinity,
                    height: 30.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                            ListMajorsScreen.routeName,
                            arguments: institution.name);
                      },
                      child: Text(
                        "Search Institution's courses",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      color: Colors.purple,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
