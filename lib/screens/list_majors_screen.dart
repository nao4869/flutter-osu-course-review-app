// Control the entire contents of the first screens
// Displays lsit of courses for the application

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/create_review_screen.dart';
//import '../screens/course_detail_screen.dart';
import '../models/star_display.dart';
import '../models/major_provider.dart';
import '../widgets/major_list_item.dart';
import '../widgets/main_drawer.dart';

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
    final majorList = Provider.of<Majors>(context);
    final majors = majorList.majors;
    return Scaffold(
      appBar: AppBar(
        title: Text('OSU Course Search'),
      ),
      drawer: MainDrawer(),
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
                            Navigator.of(context).pushNamed('/');
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
                    height: 400,
                    child: GridView.builder(
                      padding: const EdgeInsets.all(25),
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 3 / 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 0,
                      ),
                      // temporary data for categories
                      itemCount: majors.length,
                      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                        value: majors[i],
                        child: MajorListItem(),
                      ),
                    ),
                  ),
                  buildSectionTitle(context, 'Reviews Ranking'),

                  // 1st review
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
                                  Icons.looks_one,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(5, 10, 0, 0),
                              width: 350,
                              child: Text(
                                'CS162 - Intro to computer Science2',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.fromLTRB(17, 10, 0, 0),
                          child: StarDisplayWidget(
                            value: 5,
                            filledStar:
                                Icon(Icons.star, color: Colors.amber, size: 20),
                            unfilledStar:
                                Icon(Icons.star_border, color: Colors.grey),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.fromLTRB(17, 10, 17, 0),
                          child: ButtonTheme(
                            minWidth: double.infinity,
                            height: 30.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                            ),
                            child: RaisedButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed('/course-detail');
                              },
                              child: Text(
                                "Check all reviews",
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

                  // 2nd review
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
                                onTap: () {
                                  Navigator.of(context).pushNamed('/');
                                },
                                child: Icon(
                                  Icons.looks_two,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(5, 10, 0, 0),
                              width: 350,
                              child: Text(
                                'CS290 - Web Development',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.fromLTRB(17, 10, 0, 0),
                          child: StarDisplayWidget(
                            value: 5,
                            filledStar:
                                Icon(Icons.star, color: Colors.amber, size: 20),
                            unfilledStar:
                                Icon(Icons.star_border, color: Colors.grey),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.fromLTRB(17, 10, 17, 0),
                          child: ButtonTheme(
                            minWidth: double.infinity,
                            height: 30.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                            ),
                            child: RaisedButton(
                              onPressed: () {},
                              child: Text(
                                "Check all reviews",
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

                  // 3rd review
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
                                onTap: () {
                                  Navigator.of(context).pushNamed('/');
                                },
                                child: Icon(
                                  Icons.looks_3,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(5, 10, 0, 0),
                              width: 350,
                              child: Text(
                                'CS261 - Data Structures',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.fromLTRB(17, 10, 0, 0),
                          child: StarDisplayWidget(
                            value: 5,
                            filledStar:
                                Icon(Icons.star, color: Colors.amber, size: 20),
                            unfilledStar:
                                Icon(Icons.star_border, color: Colors.grey),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.fromLTRB(17, 10, 17, 0),
                          child: ButtonTheme(
                            minWidth: double.infinity,
                            height: 30.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                            ),
                            child: RaisedButton(
                              onPressed: () {},
                              child: Text(
                                "Check all reviews",
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
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pushNamed(CreateReviewScreen.routeName);
        },
        label: Text(
          'New-Review',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        icon: Icon(
          Icons.create,
          color: Colors.white,
        ),
      ), //
    );
  }
}
