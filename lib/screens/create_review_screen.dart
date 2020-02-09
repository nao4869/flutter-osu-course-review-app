import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "package:intl/intl.dart";

import '../screens/course_detail_screen.dart';

import '../models/review.dart';
import '../models/reviews_provider.dart';
import '../models/course.dart';
import '../models/courses_provider.dart';
import '../models/institution.dart';
import '../models/institution_provider.dart';

class CreateReviewScreen extends StatefulWidget {
  static const routeName = '/create-new-review';

  @override
  _CreateReviewScreen createState() => _CreateReviewScreen();
}

class _CreateReviewScreen extends State<CreateReviewScreen> {
  final _contentFocusNode = FocusNode();

  // global key
  final _form = GlobalKey<FormState>();

  // update this edited product when save form
  var _editedReview = Review(
    institutionName: '',
    courseId: null,
    reviewsContent: '',
    starScore: 0,
    createdAt: DateFormat("yyyy/MM/dd").format(DateTime.now()),
  );

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      setState(() {
        _isLoading = true;
      });

      // retrieve major data from FB
      Provider.of<Courses>(context).retrieveCourseData().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    });
    super.initState();
  }

  var _initValues = {
    'institutionName': '',
    'courseId': '',
    'reviewsContent': '',
    'starScore': null,
    'createdAt': DateFormat("yyyy/MM/dd").format(DateTime.now()),
  };

  var _starScore = [1, 2, 3, 4, 5];
  var _currentSelectedValue;
  var _currentSelectedValue2;
  var _currentSelectedValue3;
  var insName;
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final courseId = ModalRoute.of(context).settings.arguments as String;

      // this line is to initialize _currentSelectedValue3 with first institution
      final institutionList = Provider.of<Institutions>(context);
      final institutions = institutionList.institutions;
      _currentSelectedValue3 = institutions.first;

      if (courseId != null) {
        _editedReview =
            Provider.of<Reviews>(context, listen: false).findById(courseId);
        _initValues = {
          'institutionName': _editedReview.institutionName,
          'courseId': _editedReview.courseId,
          'reviewsContent': _editedReview.reviewsContent,
          'starScore': _editedReview.starScore.toString(),
          'createdAt': _editedReview.createdAt,
        };
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  // save form data by using grobal key
  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();

    // error handling for the form value
    if (!isValid) {
      return;
    }

    // only if the form is valid, save the result
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });

    // if existing items edited
    // if (_editedReview.courseId != null) {
    //   await Provider.of<Reviews>(context, listen: false)
    //       .updateReview(_editedReview, _editedReview.courseId);
    // } else {
    try {
      await Provider.of<Reviews>(context, listen: false).addReview(
          _editedReview, _editedReview.courseId, _editedReview.starScore);
    } catch (error) {
      await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text('An error occured!'),
                content: Text('Some error occured while adding products'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Okay'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ));
    }

    setState(() {
      _isLoading = false;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CourseDetailScreen(),
        settings: RouteSettings(arguments: _editedReview.courseId),
      ),
    );

    // pop up message when course successfully added
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('New activity'),
        content: Text('New Review has been created'),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              // Navigator.of(context).pop();
              Navigator.of(context, rootNavigator: true).pop('dialog');
            },
          ),
        ],
      ),
    );
    _form.currentState?.reset();
  }

  @override
  void dispose() {
    // avoid momery leaks
    _contentFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final courseList = Provider.of<Courses>(context);
    final courses = courseList.courses;

    final institutionList = Provider.of<Institutions>(context);
    final institutions = institutionList.institutions;

    return Scaffold(
      appBar: AppBar(
        title: Text('University Course Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          // setting global key in the form
          key: _form,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Text(
                        'Create New Review',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                FormField<Institution>(
                  builder: (FormFieldState<Institution> state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Institution Name',
                        labelStyle: TextStyle(
                          fontSize: 20,
                        ),
                        errorStyle:
                            TextStyle(color: Colors.redAccent, fontSize: 15.0),
                        hintText: 'Please select institution name',
                      ),
                      isEmpty: _currentSelectedValue3 == '',
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<Institution>(
                          value: _currentSelectedValue3,
                          isDense: true,
                          onChanged: (Institution newValue) {
                            setState(() {
                              _currentSelectedValue3 = newValue;
                              state.didChange(newValue);
                              state.didChange(_currentSelectedValue3);
                            });
                          },
                          items: institutions.map((Institution value) {
                            return DropdownMenuItem<Institution>(
                              value: value,
                              child: Text(
                                value.name.toString(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                  onSaved: (value) {
                    _editedReview = Review(
                      institutionName: value.name.toString(),
                      courseId: _editedReview.courseId,
                      reviewsContent: _editedReview.reviewsContent,
                      starScore: _editedReview.starScore,
                      createdAt: _editedReview.createdAt,
                    );
                  },
                ),
                FormField<Course>(
                  builder: (FormFieldState<Course> state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Course Name',
                        labelStyle: TextStyle(
                          fontSize: 20,
                        ),
                        errorStyle:
                            TextStyle(color: Colors.redAccent, fontSize: 15.0),
                        hintText: 'Please select course name',
                      ),
                      isEmpty: _currentSelectedValue == '',
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<Course>(
                          value: _currentSelectedValue,
                          isDense: true,
                          onChanged: (Course newValue) {
                            setState(() {
                              _currentSelectedValue = newValue;
                              state.didChange(newValue);
                            });
                          },
                          items: courses
                              .where(
                                (cs) =>
                                    cs.institutionName.toLowerCase().contains(
                                          _currentSelectedValue3.name
                                              .toString()
                                              //_currentSelectedValue3.name
                                              .toLowerCase(),
                                        ),
                              )
                              .toList()
                              .map((Course value) {
                            return DropdownMenuItem<Course>(
                              value: value,
                              child: Text(
                                value.courseName.toString(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                  onSaved: (value) {
                    _editedReview = Review(
                      institutionName: _editedReview.institutionName,
                      courseId: value.id.toString(),
                      reviewsContent: _editedReview.reviewsContent,
                      starScore: _editedReview.starScore,
                      createdAt: _editedReview.createdAt,
                    );
                  },
                ),
                TextFormField(
                  initialValue: _initValues['reviewsContent'],
                  decoration: InputDecoration(labelText: 'Review Content'),
                  maxLines: 8,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  focusNode: _contentFocusNode,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a reviews content.';
                    } else {
                      return null; // no error
                    }
                  },
                  onSaved: (value) {
                    _editedReview = Review(
                      institutionName: _editedReview.institutionName,
                      courseId: _editedReview.courseId,
                      reviewsContent: value,
                      starScore: _editedReview.starScore,
                      createdAt: _editedReview.createdAt,
                    );
                  },
                ),
                FormField<int>(
                  builder: (FormFieldState<int> state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Rate of Course',
                        labelStyle: TextStyle(
                          fontSize: 22,
                        ),
                        errorStyle:
                            TextStyle(color: Colors.redAccent, fontSize: 15.0),
                        hintText: 'Please select rate of course',
                      ),
                      isEmpty: _currentSelectedValue2 == '',
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          value: _currentSelectedValue2,
                          isDense: true,
                          onChanged: (int newValue) {
                            setState(() {
                              _currentSelectedValue2 = newValue;
                              state.didChange(newValue);
                            });
                          },
                          items: _starScore.map((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text('$value'),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                  onSaved: (value) {
                    _editedReview = Review(
                      institutionName: _editedReview.institutionName,
                      courseId: _editedReview.courseId,
                      reviewsContent: _editedReview.reviewsContent,
                      starScore: value,
                      createdAt: _editedReview.createdAt,
                    );
                  },
                ),
                // Raised Button
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ButtonTheme(
                    minWidth: double.infinity,
                    child: RaisedButton(
                      onPressed: _saveForm,
                      child: Text(
                        "Save Review",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      color: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  // to do, add clear form button
                  // to do, add save and add another button
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// items: _currentSelectedValue3 != null
//                               ? courses
//                                   .where(
//                                     (cs) => cs.institutionName
//                                         .toLowerCase()
//                                         .contains(
//                                           _editedReview.institutionName.toString()
//                                           //_currentSelectedValue3.name
//                                               .toLowerCase(),
//                                         ),
//                                   )
//                                   .toList()
//                               : courses.
