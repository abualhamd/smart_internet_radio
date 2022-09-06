import 'package:flutter/material.dart';
import 'package:smart_internet_radio/core/utils/extensions/media_query_values.dart';

import '../../../../core/utils/colors/app_colors.dart';

class PlayBar extends StatelessWidget {
  const PlayBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = context.width;
    return GestureDetector(
      onTap: (){

      },
      child: Container(
        color: AppColors.primary,
        // height: width / 4,
        // padding: EdgeInsets.symmetric(horizontal: width/25),
        child:  ListTile(
          leading: Image.asset('assets/images/temp.jpg'),
          title: Text(
            'BBC Arabic',
            style: TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            'News',
            style: TextStyle(color: Colors.white),
          ),
          trailing: Icon(Icons.play_circle_outline, color: Colors.white,),
        ),
      ),
    );
  }
}
