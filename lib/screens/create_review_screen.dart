import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/review.dart';
import '../models/reviews_provider.dart';
//import '../models/course.dart';
//import '../models/courses_provider.dart';

import '../widgets/main_drawer.dart';

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
    id: null,
    reviewsContent: '',
  );

  @override
  void initState() {
    super.initState();
  }

  var _initValues = {
    'reviewsContent': '',
  };

  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final reviewId = ModalRoute.of(context).settings.arguments as String;
      final courseId = ModalRoute.of(context).settings.arguments as String;
      if (reviewId != null) {
        _editedReview =
            Provider.of<Reviews>(context, listen: false).findById(reviewId);
        _initValues = {
          'reviewsContent': _editedReview.reviewsContent,
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

    // // if existing items edited
    // if (_editedReview.id != null) {
    //   await Provider.of<Reviews>(context, listen: false)
    //       .updateProduct(_editedReview.id, _editedReview);
    // } else {
    try {
      await Provider.of<Reviews>(context, listen: false)
          .addReview(_editedReview);
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
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    // avoid momery leaks
    _contentFocusNode.dispose();
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
              // TextFormField(
              //   decoration: InputDecoration(labelText: 'Course Name'),
              //   textInputAction: TextInputAction.next,
              //   onFieldSubmitted: (_) {
              //     FocusScope.of(context).requestFocus(_contentFocusNode);
              //   },
              //   validator: (value) {
              //     if (value.isEmpty) {
              //       return 'Please enter a course name.';
              //     } else {
              //       return null; // no error
              //     }
              //   },
              // ),
              TextFormField(
                initialValue: _initValues['reviewsContent'],
                decoration: InputDecoration(labelText: 'Review Content'),
                textInputAction: TextInputAction.next,
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
                    id: _editedReview.id,
                    reviewsContent: value,
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