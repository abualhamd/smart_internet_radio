import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'colors/app_colors.dart';

abstract class IconsManager {
  static const appBarMenuIcon = Icon(Icons.menu_outlined);
  static const appBarSearchIcon = Icon(Icons.search_outlined);
  static const tabBarHomeIcon = Icon(Icons.home);
  static const tabBarFavIcon = Icon(Icons.favorite_outlined);
  static const playIcon = Icon(Icons.play_circle_outline);
  //   color: Colors.white,
  // );
  static const pauseIcon = Icon(
    Icons.pause_circle_outline,
    color: Colors.white,
  );
  static const favhollowed = Icon(Icons.favorite_border_outlined);
  static final favfilled = Icon(Icons.favorite_outlined,
      color: ColorsManager.primary.withOpacity(0.8));

  static final ctgQuran = FaIcon(
    FontAwesomeIcons.bookQuran,
    color: ColorsManager.primary,
  ); //Icon(Icons.book_online_outlined);
  static final ctgNews = FaIcon(
    FontAwesomeIcons.solidNewspaper,
    color: ColorsManager.primary,
  ); //Icon(Icons.newspaper_outlined);
  static final ctgMusic = FaIcon(
    FontAwesomeIcons.music,
    color: ColorsManager.primary,
  ); //Icon(Icons.music_note_outlined);
  static final ctgSports = FaIcon(
    FontAwesomeIcons.soccerBall,
    color: ColorsManager.primary,
  ); //Icon(Icons.sports_soccer_outlined);

  static const arrowBack = Icon(Icons.arrow_back_ios);
  static final aboutIcon = Icon(Icons.info_outlined, size: 30.sp,);
}
