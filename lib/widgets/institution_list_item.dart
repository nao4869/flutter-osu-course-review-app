import 'package:flutter/material.dart';
import 'package:osu_course_review/screens/course_detail_screen.dart';
import 'package:osu_course_review/screens/list_majors_screen.dart';
import 'package:provider/provider.dart';

import '../models/institution.dart';
import '../models/institution_provider.dart';

class InstitutionListItem extends StatefulWidget {
  @override
  _InstitutionListItemState createState() => _InstitutionListItemState();
}

class _InstitutionListItemState extends State<InstitutionListItem> {
  @override
  Widget build(BuildContext context) {
    // retrieving providers objects
    final institution = Provider.of<Institution>(context, listen: false);

    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(ListMajorsScreen.routeName, arguments: institution.name);
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 5, 5),
              child: Row(
                children: <Widget>[
                  Expanded(
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
            ),
            Divider(
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 3, 15, 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // これで両端に寄せる
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Image.network(
                        institution.logo,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 0, 3),
                          child: Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.fromLTRB(10, 0, 5, 0),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.location_on,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  institution.country,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 0, 3),
                          child: Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.fromLTRB(10, 0, 5, 0),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.location_searching,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  institution.state,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 0, 3),
                          child: Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.fromLTRB(10, 0, 5, 0),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.location_city,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  institution.city,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
