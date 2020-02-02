import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dropdownfield/dropdownfield.dart';

import '../models/course.dart';
import '../models/courses_provider.dart';
import '../models/major.dart';
import '../models/major_provider.dart';

import '../widgets/main_drawer.dart';

class CreateCourseScreen extends StatefulWidget {
  static const routeName = '/create-new-course';

  @override
  _CreateCourseScreenState createState() => _CreateCourseScreenState();
}

class _CreateCourseScreenState extends State<CreateCourseScreen> {
  final _contentFocusNode = FocusNode();
  final _prerequisiteFocusNode = FocusNode();
  final _proctoredExamsFocusNode = FocusNode();
  final _groupWorkFocusNode = FocusNode();
  final _textBookFocusNode = FocusNode();
  final _languageFocusNode = FocusNode();
  final _majorFocusNode = FocusNode();

  // global key
  final _form = GlobalKey<FormState>();

  // update this edited course when save form
  var _editedCourse = Course(
    id: null,
    courseName: '',
    courseContent: '',
    prerequisite: '',
    proctoredexams: '',
    groupwork: '',
    textbook: '',
    language: '',
    major: '',
  );

  var _initValues = {
    'courseName': '',
    'courseContent': '',
    'prerequisite': '',
    'proctoredexams': '',
    'groupwork': '',
    'textbook': '',
    'language': '',
    'major': '',
  };

  // temporary list of dropdown courses list
  var _languageList = [
    "C",
    "C++",
    "Python",
    "Ruby",
    "PHP",
    "Jave",
    "HTML, CSS, Javascript",
    "Assembly language",
    "Flutter, Dart",
    "MySQL",
    "other",
  ];

  var _majorList = [
    "Computer Science",
    "Business Administration",
    "Mathematics",
  ];

  var _isInit = true;
  var _isLoading = false;
  var _currentSelectedValue;
  var _currentSelectedValue2;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final courseId = ModalRoute.of(context).settings.arguments as String;
      if (courseId != null) {
        _editedCourse =
            Provider.of<Courses>(context, listen: false).findById(courseId);
        _initValues = {
          'courseName': _editedCourse.courseName,
          'courseContent': _editedCourse.courseContent,
          'prerequisite': _editedCourse.prerequisite,
          'proctoredexams': _editedCourse.proctoredexams,
          'groupwork': _editedCourse.groupwork,
          'textbook': _editedCourse.textbook,
          'language': _editedCourse.language,
          'major': _editedCourse.major,
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
    if (_editedCourse.id != null) {
      await Provider.of<Courses>(context, listen: false)
          .updateCourse(_editedCourse.id, _editedCourse);
    } else {
      try {
        await Provider.of<Courses>(context, listen: false)
            .addCourse(_editedCourse);
      } catch (error) {
        await showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text('An error occured!'),
                  content: Text('Some error occured while adding courses'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Okay'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ));
        // finally block always run no matter try, catch succeded or not
        // } finally {
        //   setState(() {
        //     _isLoading = false;
        //   });
        //   Navigator.of(context).pop();
      }
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    // avoid momery leaks
    _contentFocusNode.dispose();
    _prerequisiteFocusNode.dispose();
    _proctoredExamsFocusNode.dispose();
    _groupWorkFocusNode.dispose();
    _textBookFocusNode.dispose();
    _languageFocusNode.dispose();
    _majorFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // need List<String> type to be able to map
    final majorsList = Provider.of<Majors>(context);
    final majors = majorsList.majors;
    List<String> majorsStr = majors.cast();
    print(majorsStr.runtimeType);
    print(majorsStr);
    
    // notice majors list itself is empty

    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Course'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          // setting global key in the form
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: _initValues['courseName'],
                decoration: InputDecoration(labelText: 'Course Name'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_contentFocusNode);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a course name.';
                  } else {
                    return null; // no error
                  }
                },
                onSaved: (value) {
                  _editedCourse = Course(
                    courseName: value,
                    courseContent: _editedCourse.courseContent,
                    prerequisite: _editedCourse.prerequisite,
                    proctoredexams: _editedCourse.proctoredexams,
                    groupwork: _editedCourse.groupwork,
                    textbook: _editedCourse.textbook,
                    language: _editedCourse.language,
                    major: _editedCourse.major,
                    id: _editedCourse.id,
                  );
                },
              ),
              TextFormField(
                initialValue: _initValues['courseContent'],
                decoration: InputDecoration(labelText: 'Course Content'),
                textInputAction: TextInputAction.next,
                focusNode: _contentFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_prerequisiteFocusNode);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a course content.';
                  } else {
                    return null; // no error
                  }
                },
                onSaved: (value) {
                  _editedCourse = Course(
                    courseName: _editedCourse.courseName,
                    courseContent: value,
                    prerequisite: _editedCourse.prerequisite,
                    proctoredexams: _editedCourse.proctoredexams,
                    groupwork: _editedCourse.groupwork,
                    textbook: _editedCourse.textbook,
                    language: _editedCourse.language,
                    major: _editedCourse.major,
                    id: _editedCourse.id,
                  );
                },
              ),
              TextFormField(
                initialValue: _initValues['prerequisite'],
                decoration: InputDecoration(labelText: 'Prerequisite'),
                textInputAction: TextInputAction.next,
                focusNode: _prerequisiteFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_proctoredExamsFocusNode);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a course pre-requisite.';
                  } else {
                    return null; // no error
                  }
                },
                onSaved: (value) {
                  _editedCourse = Course(
                    courseName: _editedCourse.courseName,
                    courseContent: _editedCourse.courseContent,
                    prerequisite: value,
                    proctoredexams: _editedCourse.proctoredexams,
                    groupwork: _editedCourse.groupwork,
                    textbook: _editedCourse.textbook,
                    language: _editedCourse.language,
                    major: _editedCourse.major,
                    id: _editedCourse.id,
                  );
                },
              ),
              TextFormField(
                initialValue: _initValues['proctoredexams'],
                decoration: InputDecoration(labelText: 'Proctored-Exams'),
                textInputAction: TextInputAction.next,
                focusNode: _proctoredExamsFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_groupWorkFocusNode);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter whether course have proctored-exams or not.';
                  } else {
                    return null; // no error
                  }
                },
                onSaved: (value) {
                  _editedCourse = Course(
                    courseName: _editedCourse.courseName,
                    courseContent: _editedCourse.courseContent,
                    prerequisite: _editedCourse.prerequisite,
                    proctoredexams: value,
                    groupwork: _editedCourse.groupwork,
                    textbook: _editedCourse.textbook,
                    language: _editedCourse.language,
                    major: _editedCourse.major,
                    id: _editedCourse.id,
                  );
                },
              ),
              TextFormField(
                initialValue: _initValues['groupwork'],
                decoration: InputDecoration(labelText: 'Groupwork'),
                textInputAction: TextInputAction.next,
                focusNode: _groupWorkFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_textBookFocusNode);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter whether a course have groupwork or not.';
                  } else {
                    return null; // no error
                  }
                },
                onSaved: (value) {
                  _editedCourse = Course(
                    courseName: _editedCourse.courseName,
                    courseContent: _editedCourse.courseContent,
                    prerequisite: _editedCourse.prerequisite,
                    proctoredexams: _editedCourse.proctoredexams,
                    groupwork: value,
                    textbook: _editedCourse.textbook,
                    language: _editedCourse.language,
                    major: _editedCourse.major,
                    id: _editedCourse.id,
                  );
                },
              ),
              TextFormField(
                initialValue: _initValues['textbook'],
                decoration: InputDecoration(labelText: 'Textbook'),
                textInputAction: TextInputAction.next,
                focusNode: _textBookFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_languageFocusNode);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a textbook of course.';
                  } else {
                    return null; // no error
                  }
                },
                onSaved: (value) {
                  _editedCourse = Course(
                    courseName: _editedCourse.courseName,
                    courseContent: _editedCourse.courseContent,
                    prerequisite: _editedCourse.prerequisite,
                    proctoredexams: _editedCourse.proctoredexams,
                    groupwork: _editedCourse.groupwork,
                    textbook: value,
                    language: _editedCourse.language,
                    major: _editedCourse.major,
                    id: _editedCourse.id,
                  );
                },
              ),
              FormField<String>(
                builder: (FormFieldState<String> state) {
                  return InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Programming language',
                      labelStyle: TextStyle(
                        fontSize: 20,
                      ),
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15.0),
                      hintText: 'Please select programming language of course',
                    ),
                    isEmpty: _currentSelectedValue == '',
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _currentSelectedValue,
                        isDense: true,
                        onChanged: (String newValue) {
                          setState(() {
                            _currentSelectedValue = newValue;
                            state.didChange(newValue);
                          });
                        },
                        items: _languageList.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
                onSaved: (value) {
                  _editedCourse = Course(
                    courseName: _editedCourse.courseName,
                    courseContent: _editedCourse.courseContent,
                    prerequisite: _editedCourse.prerequisite,
                    proctoredexams: _editedCourse.proctoredexams,
                    groupwork: _editedCourse.groupwork,
                    textbook: _editedCourse.textbook,
                    language: value,
                    major: _editedCourse.major,
                    id: _editedCourse.id,
                  );
                },
              ),
              // DropDownField(
              //     value: majors,
              //     required: true,
              //     strict: true,
              //     labelText: 'Major Name *',
              //     icon: Icon(Icons.account_balance),
              //     items: majors,
              //     setter: (dynamic newValue) {
              //       majors = newValue;
              //     }),
              FormField<String>(
                builder: (FormFieldState<String> state) {
                  return InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Major of course',
                      labelStyle: TextStyle(
                        fontSize: 20,
                      ),
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15.0),
                      hintText: 'Please select major of course',
                    ),
                    isEmpty: _currentSelectedValue2 == '',
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _currentSelectedValue2,
                        isDense: true,
                        onChanged: (String newValue) {
                          setState(() {
                            _currentSelectedValue2 = newValue;
                            state.didChange(newValue);
                          });
                        },
                        items: majorsStr.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
                onSaved: (value) {
                  _editedCourse = Course(
                    courseName: _editedCourse.courseName,
                    courseContent: _editedCourse.courseContent,
                    prerequisite: _editedCourse.prerequisite,
                    proctoredexams: _editedCourse.proctoredexams,
                    groupwork: _editedCourse.groupwork,
                    textbook: _editedCourse.textbook,
                    language: _editedCourse.language,
                    major: value,
                    id: _editedCourse.id,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
