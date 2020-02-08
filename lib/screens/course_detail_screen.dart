// This file will display the meals for the chosen category
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:core';

import '../models/courses_provider.dart';
import '../models/reviews_provider.dart';
import '../models/star_display.dart';
import '../widgets/course_review_item.dart';

class CourseDetailScreen extends StatefulWidget {
  static const routeName = '/course-detail';

  @override
  _CourseDetailScreenState createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  var _isLoading = false;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      setState(() {
        _isLoading = true;
      });

      final courseId = ModalRoute.of(context).settings.arguments as String;
      print(courseId);

      Provider.of<Reviews>(context).retrieveReviewData(courseId).then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    });
    super.initState();
  }

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final courseId = ModalRoute.of(context).settings.arguments
        as String; // retrieving ID from routes passed
    final loadedCourse = Provider.of<Courses>(context).findById(courseId);

    final reviewList = Provider.of<Reviews>(context);
    final reviews = reviewList.reviews;

    // map to obtain each reviews star score
    final total = reviews.map((rv) => rv.starScore).toList();

    // retrieve sum of star score
    final sum = total.fold(0, (a, b) => a + b);

    // round to decimal 2 point
    final scoreToDisplay = (sum / reviews.length);
    var intScore = int.tryParse(scoreToDisplay.toStringAsFixed(1)) ?? 5;
    final finalScore = num.parse(scoreToDisplay.toStringAsFixed(1));

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedCourse.courseName),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(5, 5, 0, 10),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed('/');
                            },
                            child: Icon(
                              Icons.home,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(3, 0, 0, 0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed('/');
                            },
                            child: Text(
                              'HOME ',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '/ ' + loadedCourse.courseName + ' review',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromRGBO(255, 255, 255, 1),
                      ),
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(5),
                      width: double.infinity,
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Text(
                              loadedCourse.courseName,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                            ),
                          ),
                          // display language
                          Row(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.fromLTRB(30, 10, 0, 0),
                                child: StarDisplayWidget(
                                  value: intScore,
                                  filledStar: Icon(Icons.star,
                                      color: Colors.amber, size: 20),
                                  unfilledStar: Icon(Icons.star_border,
                                      color: Colors.grey),
                                ),
                              ),
                              Container(
                                //width: double.infinity,
                                padding: EdgeInsets.fromLTRB(5, 10, 0, 0),
                                child: Text(
                                  '$finalScore',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'roboto',
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.fromLTRB(30, 10, 20, 15),
                            child: Text(
                              '${loadedCourse.courseContent}',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                          ),

                          // display language
                          Row(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                                child: Text(
                                  'Language: ',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.purple),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  '${loadedCourse.language}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.fromLTRB(30, 0, 0, 5),
                            child: Text(
                              'Pre-requisite: ${loadedCourse.prerequisite}',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.fromLTRB(30, 0, 0, 5),
                            child: Text(
                              'Proctored Exams: ${loadedCourse.proctoredexams}',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.fromLTRB(30, 0, 0, 5),
                            child: Text(
                              'Group Work: ${loadedCourse.groupwork}',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.fromLTRB(30, 0, 0, 5),
                            child: Text(
                              'Textbook: ${loadedCourse.textbook}',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    buildSectionTitle(context, 'Course Reviews'),
                    _isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Container(
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                              itemCount: reviews.length,
                              itemBuilder: (ctx, i) =>
                                  ChangeNotifierProvider.value(
                                value: reviews[i],
                                child: CourseReviewItem(),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pushNamed('/');
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
