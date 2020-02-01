import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/major.dart';
import '../models/major_provider.dart';

class MajorListItem extends StatelessWidget {
  // final String id;
  // final String majorName;
  // final Color color;

  // MajorListItem(this.id, this.majorName, this.color);

  @override
  Widget build(BuildContext context) {
    final major = Provider.of<Major>(context, listen: false);

    return InkWell(
      onTap: () => () {},
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(
          major.majorName,
          style: Theme.of(context).textTheme.title,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              major.color.withOpacity(0.7),
              major.color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
