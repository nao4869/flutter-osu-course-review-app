import 'package:flutter/material.dart';
import 'package:osu_course_review/screens/list_majors_screen.dart';
import 'package:provider/provider.dart';

import '../models/institution.dart';

class InstitutionListItem extends StatefulWidget {
  @override
  _InstitutionListItemState createState() => _InstitutionListItemState();
}

class _InstitutionListItemState extends State<InstitutionListItem> {
  Widget _displayInstitutionName(String name) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 8, 5, 5),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _displayDivider() {
    return Divider(
      color: Colors.grey,
    );
  }

  Widget _displaySchoolLogo(String logo) {
    return Expanded(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
        ),
        child: Image.network(
          logo,
        ),
      ),
    );
  }

  Widget _displayIconAndText(String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 0, 3),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(10, 0, 5, 0),
            child: GestureDetector(
              onTap: () {},
              child: Icon(
                icon,
                color: Colors.black,
                size: 20,
              ),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // retrieving providers objects
    final institution = Provider.of<Institution>(context, listen: false);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ListMajorsScreen(),
            settings: RouteSettings(arguments: institution.name),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: <Widget>[
            _displayInstitutionName(institution.name),
            _displayDivider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 3, 15, 3),
              child: Row(
                children: <Widget>[
                  _displaySchoolLogo(institution.logo),
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: <Widget>[
                        _displayIconAndText(
                            institution.country, Icons.location_on),
                        _displayIconAndText(
                            institution.state, Icons.location_searching),
                        _displayIconAndText(
                            institution.city, Icons.location_city),
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
