import 'package:flutter/material.dart';
import 'package:osu_course_review/widgets/main_drawer.dart';
import 'package:flutter/cupertino.dart';

import '../screens/list_institutions_screen.dart';
import '../screens/create_institution_screen.dart';
import '../screens/create_course_screen.dart';
import '../screens/create_review_screen.dart';

class TabScreen extends StatefulWidget {
  static const routeName = '/tabs-screen';

  final String pageIndex;

  TabScreen({
    this.pageIndex,
  });

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  List<Widget> _widgets = <Widget>[
    ListInstitutionScreen(),
    CreateInstitutionScreen(),
    CreateCourseScreen(),
    CreateReviewScreen(),
    ListInstitutionScreen(),
  ];

  int _defaultIndex = 0;
  int _selectedIndex;

  int _selectedPageIndex;

  void _onTapHandler(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = _defaultIndex;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(
              'Home',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text(
              'School',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.class_),
            title: Text(
              'Course',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.create),
            title: Text(
              'Review',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            title: Text(
              'User',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
        ],
        onTap: _onTapHandler,
        currentIndex: _selectedIndex,
        backgroundColor: Theme.of(context).primaryColor,
        activeColor: Theme.of(context).accentColor,
        inactiveColor: Colors.white,
        iconSize: 25,
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(
              builder: (context) {
                return CupertinoPageScaffold(
                  child: ListInstitutionScreen(),
                );
              },
            );
          case 1:
            return CupertinoTabView(
              builder: (context) {
                return CupertinoPageScaffold(
                  child: CreateInstitutionScreen(),
                );
              },
            );
          case 2:
            return CupertinoTabView(
              builder: (context) {
                return CupertinoPageScaffold(
                  child: CreateCourseScreen(),
                );
              },
            );
          case 3:
            return CupertinoTabView(
              builder: (context) {
                return CupertinoPageScaffold(
                  child: CreateReviewScreen(),
                );
              },
            );
          case 4:
            return CupertinoTabView(
              builder: (context) {
                return CupertinoPageScaffold(
                  child: ListInstitutionScreen(),
                );
              },
            );
          default:
            {
              return CupertinoTabView(
                builder: (context) {
                  return CupertinoPageScaffold(
                    child: ListInstitutionScreen(),
                  );
                },
              );
            }
        }
      },
    );
  }
}
