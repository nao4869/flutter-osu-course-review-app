import 'package:flutter/material.dart';
import 'package:osu_course_review/models/institution_provider.dart';
import 'package:osu_course_review/screens/list_majors_screen.dart';
import 'package:provider/provider.dart';

import '../screens/video_player_screen.dart';
import '../models/institution.dart';
import '../models/theme_provider.dart';

class InstitutionListItem extends StatefulWidget {
  @override
  _InstitutionListItemState createState() => _InstitutionListItemState();
}

class _InstitutionListItemState extends State<InstitutionListItem> {
  Widget _displayInstitutionName(Institution ins, ThemeProvider theme) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 8, 5, 5),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 8,
            child: Text(
              ins.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: theme.getThemeData == lightTheme
                    ? Colors.black
                    : Colors.white,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: IconButton(
              icon: Icon(
                Icons.video_label,
                size: 18,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VideoPlayerScreen(ins.videoUrl),
                    // settings: RouteSettings(
                    //   arguments: ins.videoUrl,
                    // ),
                  ),
                );
              },
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

  Widget _displayIconAndText(String text, IconData icon, ThemeProvider theme) {
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
                color: theme.getThemeData == lightTheme
                    ? Colors.black
                    : Colors.grey,
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
                color: theme.getThemeData == lightTheme
                    ? Colors.black
                    : Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final institution = Provider.of<Institution>(context, listen: false);
    final theme = Provider.of<ThemeProvider>(context);

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
          color:
              theme.getThemeData == lightTheme ? Colors.white : Colors.black26,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: <Widget>[
            _displayInstitutionName(
              institution,
              theme,
            ),
            _displayDivider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 3, 15, 3),
              child: Row(
                children: <Widget>[
                  _displaySchoolLogo(
                    institution.logo,
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: <Widget>[
                        _displayIconAndText(
                          institution.country,
                          Icons.location_on,
                          theme,
                        ),
                        _displayIconAndText(
                          institution.state,
                          Icons.location_searching,
                          theme,
                        ),
                        _displayIconAndText(
                          institution.city,
                          Icons.location_city,
                          theme,
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
