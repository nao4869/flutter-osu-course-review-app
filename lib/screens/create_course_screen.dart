import 'package:flutter/material.dart';

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

  // global key
  final _form = GlobalKey<FormState>();

  // save form data by using grobal key
  void _saveForm() {
    final isValid = _form.currentState.validate();

    // error handling for the form value
    if (!isValid) {
      return;
    }

    // only if the form is valid, save the result
    _form.currentState.save();
  }

  @override
  void dispose() {
    // avoid momery leaks
    _contentFocusNode.dispose();
    _prerequisiteFocusNode.dispose();
    _proctoredExamsFocusNode.dispose();
    _groupWorkFocusNode.dispose();
    _textBookFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              ),
              TextFormField(
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
              ),
              TextFormField(
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
              ),
              TextFormField(
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
              ),
              TextFormField(
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
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Textbook'),
                textInputAction: TextInputAction.next,
                focusNode: _textBookFocusNode,
                onFieldSubmitted: (_) {
                  _saveForm();
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a textbook of course.';
                  } else {
                    return null; // no error
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
