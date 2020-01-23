import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class CreateReviewScreen extends StatefulWidget {
  static const routeName = '/create-new-review';

  @override
  _CreateReviewScreenState createState() => _CreateReviewScreenState();
}

class _CreateReviewScreenState extends State<CreateReviewScreen> {
  final _reviewsContentFocusNode = FocusNode();

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
    _reviewsContentFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Review'),
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
                  FocusScope.of(context).requestFocus(_reviewsContentFocusNode);
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
                decoration: InputDecoration(labelText: 'Review Content'),
                textInputAction: TextInputAction.next,
                focusNode: _reviewsContentFocusNode,
                onFieldSubmitted: (_) {
                  _saveForm();
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a course reviews.';
                  }
                  if (value.length < 10) {
                    return 'Review should be at least 10 characters long.';
                  }
                  return null; // no error
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
