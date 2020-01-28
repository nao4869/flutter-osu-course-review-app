// Control the entire contents of the first screens
// Displays lsit of reviews for the application
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/create_review_screen.dart';
import '../models/reviews_provider.dart';
import '../widgets/course_review_item.dart';
import '../widgets/main_drawer.dart';

class ListReviewsScreen extends StatefulWidget {
  static const routeName = '/list-reviews-screen';

  @override
  _ListReviewsScreenState createState() => _ListReviewsScreenState();
}

class _ListReviewsScreenState extends State<ListReviewsScreen> {
  var _isLoading = false;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<Reviews>(context).retrieveReviewData().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final reviewList = Provider.of<Reviews>(context);
    final reviews = reviewList.reviews;
    return Scaffold(
      appBar: AppBar(
        title: Text('OSU Course Search'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(CreateReviewScreen.routeName);
            },
          )
        ],
      ),
      drawer: MainDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(25),
              itemCount: reviews.length,
              itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                value: reviews[i],
                child: CourseReviewItem(),
              ),
            ),
    );
  }
}
