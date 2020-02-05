import 'package:flutter/material.dart';
import 'package:osu_course_review/widgets/main_drawer.dart';
import 'package:flutter/cupertino.dart';

import '../screens/list_majors_screen.dart';
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
    ListMajorsScreen(),
    CreateCourseScreen(),
    CreateReviewScreen()
  ];

  int _defaultIndex = 0;
  int _selectedIndex;
  // String retrievedIndex;

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
    // retrievedIndex = ModalRoute.of(context).settings.arguments as String;
    // retrievedIndex == null
    //     ? _selectedIndex = _defaultIndex
    //     : _selectedIndex = int.parse(retrievedIndex);
  }

  // void _selectPage(int index) {
  //   setState(() {
  //     _selectedPageIndex = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OSU Course Search'),
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