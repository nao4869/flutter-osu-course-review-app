import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "package:intl/intl.dart";
import 'package:keyboard_actions/keyboard_actions.dart';

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
  final _scoreFocusNode = FocusNode();
  final _contentFocusNode = FocusNode();
  final _contentController = TextEditingController();

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.black,
      nextFocus: true,
      actions: [
        KeyboardAction(
          focusNode: _contentFocusNode,
          closeWidget: Padding(
            padding: EdgeInsets.all(5.0),
            child: Padding(
              padding: const EdgeInsets.only(right: 33.0),
              child: Text(
                "CLOSE",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

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
  var currentSelectedValue;
  int _currentSelectedValue2;
  var currentSelectedValue3;

  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final courseId = ModalRoute.of(context).settings.arguments as String;

      // this line is to initialize currentSelectedValue3 with first institution
      // final institutionList = Provider.of<Institutions>(context);
      // final institutions = institutionList.institutions;
      // if (currentSelectedValue3 == null) {
      //   currentSelectedValue3 = institutions.first;
      // }

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
                content: Text('Some error occured while adding review'),
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
        settings: RouteSettings(
          arguments: _editedReview.courseId,
        ),
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

  Widget _displaySubHeader(String title) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(10),
          child: Text(
            title,
            textAlign: TextAlign.end,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }

  Widget _createFormField(TextEditingController controller, FocusNode focusNode,
      FocusNode nextFocusNode, String labelText, String formTitle) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        maxLines: 10,
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            fontSize: 13,
          ),
          suffixIcon: IconButton(
            icon: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Icon(
                Icons.clear,
                size: 20,
              ),
            ),
            onPressed: () {
              controller.clear();
            },
          ),
          contentPadding: const EdgeInsets.all(8.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(nextFocusNode);
        },
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter a course name.';
          } else {
            return null; // no error
          }
        },
        onSaved: (value) {
          _editedReview = Review(
            institutionName: _editedReview.institutionName,
            courseId: _editedReview.courseId,
            reviewsContent: formTitle == 'reviewsContent'
                ? value
                : _editedReview.reviewsContent,
            starScore: _editedReview.starScore,
            createdAt: _editedReview.createdAt,
          );
        },
      ),
    );
  }

  Widget _createRaisedButton(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ButtonTheme(
        minWidth: double.infinity,
        child: RaisedButton(
          onPressed: _saveForm,
          child: Text(
            title,
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
    );
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
      body: KeyboardActions(
        config: _buildConfig(context),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              // setting global key in the form
              key: _form,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    _displaySubHeader('Create new review'),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: FormField<Institution>(
                        builder: (FormFieldState<Institution> state) {
                          return InputDecorator(
                            decoration: InputDecoration(
                              labelText: 'Institution name',
                              labelStyle: TextStyle(
                                fontSize: 15,
                              ),
                              errorStyle: TextStyle(
                                  color: Colors.redAccent, fontSize: 15.0),
                              hintText: 'Please select institution name',
                              contentPadding: const EdgeInsets.all(8.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            isEmpty: currentSelectedValue3 == null,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<Institution>(
                                value: currentSelectedValue3,
                                isDense: true,
                                onChanged: (Institution newValue) {
                                  setState(() {
                                    currentSelectedValue3 = newValue;
                                  });
                                },
                                items: institutions
                                    .map<DropdownMenuItem<Institution>>(
                                        (Institution value) {
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
                            institutionName: value == null
                                ? currentSelectedValue3.name.toString()
                                : value.name.toString(),
                            courseId: _editedReview.courseId,
                            reviewsContent: _editedReview.reviewsContent,
                            starScore: _editedReview.starScore,
                            createdAt: _editedReview.createdAt,
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: FormField<Course>(
                        builder: (FormFieldState<Course> state) {
                          return InputDecorator(
                            decoration: InputDecoration(
                              labelText: 'Course name',
                              labelStyle: TextStyle(
                                fontSize: 15,
                              ),
                              errorStyle: TextStyle(
                                  color: Colors.redAccent, fontSize: 15.0),
                              hintText: 'Please select course name',
                              contentPadding: const EdgeInsets.all(8.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            isEmpty: currentSelectedValue == null,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<Course>(
                                value: currentSelectedValue,
                                isDense: true,
                                onChanged: (Course newValue) {
                                  setState(() {
                                    currentSelectedValue = newValue;
                                  });
                                },
                                items: currentSelectedValue3 != null
                                    ? courses
                                        .where(
                                          (cs) => cs.institutionName
                                              .toLowerCase()
                                              .contains(
                                                currentSelectedValue3.name
                                                    .toString()
                                                    .toLowerCase(),
                                              ),
                                        )
                                        .toList()
                                        .map<DropdownMenuItem<Course>>(
                                            (Course value) {
                                        return DropdownMenuItem<Course>(
                                          value: value != null ? value : null,
                                          child: Text(
                                            value.courseName.toString(),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14,
                                            ),
                                          ),
                                        );
                                      }).toList()
                                    : courses
                                        .toList()
                                        .map<DropdownMenuItem<Course>>(
                                            (Course value) {
                                        return DropdownMenuItem<Course>(
                                          value: value != null ? value : null,
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
                            courseId: value == null
                                ? currentSelectedValue.id.toString()
                                : value.id.toString(),
                            reviewsContent: _editedReview.reviewsContent,
                            starScore: _editedReview.starScore,
                            createdAt: _editedReview.createdAt,
                          );
                        },
                      ),
                    ),
                    _createFormField(_contentController, _contentFocusNode,
                        _scoreFocusNode, 'Review Content', 'reviewsContent'),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: FormField<int>(
                        builder: (FormFieldState<int> state) {
                          return InputDecorator(
                            decoration: InputDecoration(
                              labelText: 'Course rate',
                              labelStyle: TextStyle(
                                fontSize: 18,
                              ),
                              errorStyle: TextStyle(
                                  color: Colors.redAccent, fontSize: 15.0),
                              hintText: 'Please select rate of course',
                              contentPadding: const EdgeInsets.all(8.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            isEmpty: _currentSelectedValue2 == '',
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<int>(
                                focusNode: _scoreFocusNode,
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
                    ),
                    // Raised Button
                    _createRaisedButton('Save Review'),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
