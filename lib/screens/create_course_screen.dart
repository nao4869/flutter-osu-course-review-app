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

  @override
  void dispose() {
    // TODO: implement dispose
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
      ),
      drawer: MainDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Course Name'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_contentFocusNode);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Course Content'),
                textInputAction: TextInputAction.next,
                focusNode: _contentFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_prerequisiteFocusNode);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Prerequisite'),
                textInputAction: TextInputAction.next,
                focusNode: _prerequisiteFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_proctoredExamsFocusNode);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Proctored-Exams'),
                textInputAction: TextInputAction.next,
                focusNode: _proctoredExamsFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_groupWorkFocusNode);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Groupwork'),
                textInputAction: TextInputAction.next,
                focusNode: _groupWorkFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_textBookFocusNode);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Textbook'),
                textInputAction: TextInputAction.next,
                focusNode: _textBookFocusNode,
              ),
            ],
          ),
        ),
      ),
    );
  }
}