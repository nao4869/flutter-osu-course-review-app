// Control the entire contents of the first screens
// Displays lsit of courses for the application

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/major_provider.dart';
import '../widgets/major_list_item.dart';
import '../widgets/main_drawer.dart';

class ListMajorsScreen extends StatefulWidget {
  static const routeName = '/major-list';

  @override
  _ListMajorsScreenState createState() => _ListMajorsScreenState();
}

class _ListMajorsScreenState extends State<ListMajorsScreen> {
  var _isLoading = false;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<Majors>(context).retrieveMajorData().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final majorList = Provider.of<Majors>(context);
    final majors = majorList.majors;
    return Scaffold(
      appBar: AppBar(
        title: Text('OSU Course Search'),
      ),
      drawer: MainDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(25),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              // temporary data for categories
              itemCount: majors.length,
              itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                value: majors[i],
                child: MajorListItem(),
              ),
            ),
    );
  }
}
