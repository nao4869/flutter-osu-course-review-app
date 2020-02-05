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
    return Scaffold(
      appBar: AppBar(
        title: Text('University Course Search'),
      ),
      drawer: MainDrawer(),
      body: _widgets[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onTapHandler,
        currentIndex: _selectedIndex,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.home),
            title: Text(
              'Home',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.school),
            title: Text(
              'Create New School',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.class_),
            title: Text(
              'Create New Course',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.create),
            title: Text(
              'Create New Review',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.people),
            title: Text(
              'User',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// return CupertinoTabScaffold(
//       tabBar: CupertinoTabBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             //backgroundColor: Theme.of(context).primaryColor,
//             icon: Icon(Icons.home),
//             title: Text('Home'),
//           ),
//           BottomNavigationBarItem(
//             //backgroundColor: Theme.of(context).primaryColor,
//             icon: Icon(Icons.class_),
//             title: Text('New Course'),
//           ),
//           BottomNavigationBarItem(
//             //backgroundColor: Theme.of(context).primaryColor,
//             icon: Icon(Icons.create),
//             title: Text('New Review'),
//           ),
//         ],
//         onTap: _onTapHandler, // 実は無くても動く
//         currentIndex: _selectedIndex, // 実は無くても動く
//       ),
//       tabBuilder: (context, index) {
//         switch (index) {
//           case 0: // 1番左のタブが選ばれた時の画面
//             return CupertinoTabView(
//               builder: (context) {
//                 return CupertinoPageScaffold(
//                   navigationBar: CupertinoNavigationBar(
//                     leading: Icon(Icons.home), // ページのヘッダ左のアイコン
//                   ),
//                   child: ListMajorsScreen(), // 表示したい画面のWidget
//                 );
//               },
//             );
//         }
//       },
//     );
