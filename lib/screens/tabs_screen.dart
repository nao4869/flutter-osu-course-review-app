import 'package:flutter/material.dart';
import 'package:osu_course_review/widgets/main_drawer.dart';

import '../screens/list_majors_screen.dart';
import '../screens/create_course_screen.dart';
import '../screens/create_review_screen.dart';

class TabScreen extends StatefulWidget {
  static const routeName = '/tabs-screen';

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  // pages lists
  List<Map<String, Object>> _pages;

  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {
        'page': ListMajorsScreen(),
        'title': 'Home',
      },
      {
        'page': CreateCourseScreen(),
        'title': 'New Course',
      },
      {
        'page': CreateReviewScreen(),
        'title': 'New Review',
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OSU Course Search'),
      ),
      drawer: MainDrawer(),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.class_),
            title: Text('New Course'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.create),
            title: Text('New Review'),
          ),
        ],
      ),
    );
  }
}
