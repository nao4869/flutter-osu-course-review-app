import 'package:flutter/material.dart';
import 'package:osu_course_review/screens/list_courses_screen.dart';
import 'package:provider/provider.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

import '../models/course.dart';
import '../models/courses_provider.dart';
import '../models/major.dart';
import '../models/major_provider.dart';
import '../models/language.dart';
import '../models/language_provider.dart';
import '../models/institution.dart';
import '../models/institution_provider.dart';

class CreateCourseScreen extends StatefulWidget {
  static const routeName = '/create-new-course';

  @override
  _CreateCourseScreenState createState() => _CreateCourseScreenState();
}

class _CreateCourseScreenState extends State<CreateCourseScreen> {
  final _nameFocusNode = FocusNode();
  final _contentFocusNode = FocusNode();
  final _prerequisiteFocusNode = FocusNode();
  final _proctoredExamsFocusNode = FocusNode();
  final _groupWorkFocusNode = FocusNode();
  final _textBookFocusNode = FocusNode();
  final _languageFocusNode = FocusNode();
  final _majorFocusNode = FocusNode();

  final _nameController = TextEditingController();
  final _contentController = TextEditingController();
  final _prerequisiteController = TextEditingController();
  final _proctoredexamsController = TextEditingController();
  final _groupworkController = TextEditingController();
  final _textbookController = TextEditingController();

  /// Creates the [KeyboardActionsConfig] to hook up the fields
  /// and their focus nodes to our [FormKeyboardActions].
  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.black,
      nextFocus: true,
      actions: [
        KeyboardAction(
          focusNode: _nameFocusNode,
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
        KeyboardAction(
          focusNode: _prerequisiteFocusNode,
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
        KeyboardAction(
          focusNode: _proctoredExamsFocusNode,
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
        KeyboardAction(
          focusNode: _groupWorkFocusNode,
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
        KeyboardAction(
          focusNode: _textBookFocusNode,
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
    institutionName: '',
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
    'insinstitutionName': '',
  };

  var _isInit = true;
  var _isLoading = false;
  var _currentSelectedValue;
  var _currentSelectedValue2;
  var currentSelectedValue3;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      setState(() {
        _isLoading = true;
      });

      // retrieve major data from FB
      Provider.of<Majors>(context).retrieveMajorData();
      Provider.of<Languages>(context).retrieveLanguageData();
      Provider.of<Institutions>(context).retrieveInstitutionData().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    });
    super.initState();
  }

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
          'institutionName': _editedCourse.institutionName,
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
                        Navigator.of(context, rootNavigator: true)
                            .pop('dialog');
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

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ListCoursesScreen(),
        settings: RouteSettings(
          arguments: ScreenArguments(
            'Extract Arguments Screen',
            'This message is extracted in the build method.',
          ),
        ),
      ),
    );

    // pop up message when course successfully added
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'New activity',
        ),
        content: Text(
          'New course has been created',
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
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
    _prerequisiteFocusNode.dispose();
    _proctoredExamsFocusNode.dispose();
    _groupWorkFocusNode.dispose();
    _textBookFocusNode.dispose();
    _languageFocusNode.dispose();
    _majorFocusNode.dispose();

    _nameController.dispose();
    _contentController.dispose();
    _prerequisiteController.dispose();
    _proctoredexamsController.dispose();
    _groupworkController.dispose();
    _textbookController.dispose();
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
          _editedCourse = Course(
            courseName:
                formTitle == 'CourseName' ? value : _editedCourse.courseName,
            courseContent:
                formTitle == 'courseContent' ? value : _editedCourse.courseName,
            prerequisite: formTitle == 'prerequisite'
                ? value
                : _editedCourse.prerequisite,
            proctoredexams: formTitle == 'proctoredexams'
                ? value
                : _editedCourse.proctoredexams,
            groupwork:
                formTitle == 'groupwork' ? value : _editedCourse.groupwork,
            textbook: formTitle == 'textbook' ? value : _editedCourse.textbook,
            language: _editedCourse.language,
            major: _editedCourse.major,
            institutionName: _editedCourse.institutionName,
            id: _editedCourse.id,
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
    const title = 'University Course Search';

    final majorList = Provider.of<Majors>(context);
    final majors = majorList.majors;

    final languageList = Provider.of<Languages>(context);
    final languages = languageList.languages;

    final institutionList = Provider.of<Institutions>(context);
    final institutions = institutionList.institutions;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: KeyboardActions(
        config: _buildConfig(context),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            // setting global key in the form
            key: _form,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  _displaySubHeader('Create New Course'),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FormField<Institution>(
                      builder: (FormFieldState<Institution> state) {
                        return InputDecorator(
                          decoration: InputDecoration(
                            labelText: 'Institution name',
                            labelStyle: TextStyle(
                              fontSize: 18,
                            ),
                            errorStyle: TextStyle(
                                color: Colors.redAccent, fontSize: 15.0),
                            hintText: 'Please select institution of course',
                            contentPadding: const EdgeInsets.all(8.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          isEmpty: currentSelectedValue3 == '',
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<Institution>(
                              value: currentSelectedValue3,
                              isDense: true,
                              onChanged: (Institution newValue) {
                                setState(() {
                                  currentSelectedValue3 = newValue;
                                  state.didChange(newValue);
                                });
                              },
                              items: institutions.map((Institution value) {
                                return DropdownMenuItem<Institution>(
                                  value: value,
                                  child: Text(value.name.toString()),
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
                          major: _editedCourse.major,
                          institutionName: value.name.toString(),
                          id: _editedCourse.id,
                        );
                      },
                    ),
                  ),
                  _createFormField(
                    _nameController,
                    _nameFocusNode,
                    _contentFocusNode,
                    'Course Name',
                    'CourseName',
                  ),
                  _createFormField(
                    _contentController,
                    _contentFocusNode,
                    _prerequisiteFocusNode,
                    'Course Content',
                    'CourseContent',
                  ),
                  _createFormField(
                    _prerequisiteController,
                    _prerequisiteFocusNode,
                    _proctoredExamsFocusNode,
                    'Prerequisite',
                    'prerequisite',
                  ),
                  _createFormField(
                    _proctoredexamsController,
                    _proctoredExamsFocusNode,
                    _groupWorkFocusNode,
                    'Proctored-Exams',
                    'proctoredexams',
                  ),
                  _createFormField(
                    _groupworkController,
                    _groupWorkFocusNode,
                    _textBookFocusNode,
                    'Groupwork',
                    'groupwork',
                  ),
                  _createFormField(
                    _textbookController,
                    _textBookFocusNode,
                    _languageFocusNode,
                    'Textbook',
                    'textbook',
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FormField<Language>(
                      builder: (FormFieldState<Language> state) {
                        return InputDecorator(
                          decoration: InputDecoration(
                            labelText: 'Programming language',
                            labelStyle: TextStyle(
                              fontSize: 18,
                            ),
                            errorStyle: TextStyle(
                                color: Colors.redAccent, fontSize: 15.0),
                            hintText:
                                'Please select programming language of course',
                            contentPadding: const EdgeInsets.all(8.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          isEmpty: _currentSelectedValue == '',
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<Language>(
                              focusNode: _languageFocusNode,
                              value: _currentSelectedValue,
                              isDense: true,
                              onChanged: (Language newValue) {
                                setState(() {
                                  _currentSelectedValue = newValue;
                                  state.didChange(newValue);
                                });
                              },
                              items: languages.map((Language value) {
                                return DropdownMenuItem<Language>(
                                  value: value,
                                  child: Text(value.languageName.toString()),
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
                          language: value.languageName.toString(),
                          major: _editedCourse.major,
                          institutionName: _editedCourse.institutionName,
                          id: _editedCourse.id,
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FormField<Major>(
                      builder: (FormFieldState<Major> state) {
                        return InputDecorator(
                          decoration: InputDecoration(
                            labelText: 'Major of course',
                            labelStyle: TextStyle(
                              fontSize: 18,
                            ),
                            errorStyle: TextStyle(
                                color: Colors.redAccent, fontSize: 15.0),
                            hintText: 'Please select major of course',
                            contentPadding: const EdgeInsets.all(8.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          isEmpty: _currentSelectedValue2 == '',
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<Major>(
                                focusNode: _majorFocusNode,
                                value: _currentSelectedValue2,
                                isDense: true,
                                onChanged: (Major newValue) {
                                  setState(() {
                                    _currentSelectedValue2 = newValue;
                                    state.didChange(newValue);
                                  });
                                },
                                items: currentSelectedValue3 != null
                                    ? majors
                                        .where(
                                          (mj) => mj.institutionName
                                              .toLowerCase()
                                              .contains(
                                                currentSelectedValue3.name
                                                    .toString()
                                                    .toLowerCase(),
                                              ),
                                        )
                                        .toList()
                                        .map<DropdownMenuItem<Major>>(
                                            (Major value) {
                                        return DropdownMenuItem<Major>(
                                          value: value != null ? value : null,
                                          child: Text(
                                            value.majorName.toString(),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14,
                                            ),
                                          ),
                                        );
                                      }).toList()
                                    : majors.map((Major value) {
                                        return DropdownMenuItem<Major>(
                                          value: value != null ? value : null,
                                          child: Text(
                                            value.majorName.toString(),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14,
                                            ),
                                          ),
                                        );
                                      }).toList()),
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
                          major: value.majorName.toString(),
                          institutionName: _editedCourse.institutionName,
                          id: _editedCourse.id,
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
    );
  }
}

class ScreenArguments {
  final String institutionName;
  final String majorName;

  ScreenArguments(this.institutionName, this.majorName);
}
