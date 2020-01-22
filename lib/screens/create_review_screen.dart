import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class CreateReviewScreen extends StatefulWidget {
  static const routeName = '/create-new-review';

  @override
  _CreateReviewScreenState createState() => _CreateReviewScreenState();
}

class _CreateReviewScreenState extends State<CreateReviewScreen> {
  final _reviewsContentFocusNode = FocusNode();

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
                  FocusScope.of(context).requestFocus(_reviewsContentFocusNode);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Review Content'),
                textInputAction: TextInputAction.next,
                focusNode: _reviewsContentFocusNode,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
