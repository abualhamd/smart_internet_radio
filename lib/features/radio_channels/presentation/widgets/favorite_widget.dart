import 'package:flutter/material.dart';
import 'package:smart_internet_radio/core/utils/extensions/media_query_values.dart';

class FavWidget extends StatelessWidget {
  const FavWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = context.width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width/50),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        elevation: 5,
        child: ListTile(
          leading: Image.asset('assets/images/temp.jpg'),
          title: Text('BBC'),
          subtitle: Text('News'),
        ),
      ),
    );
  }
}
