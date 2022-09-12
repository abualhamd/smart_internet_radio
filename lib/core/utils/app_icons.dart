import 'package:flutter/material.dart';
import 'package:smart_internet_radio/core/utils/colors/app_colors.dart';

abstract class AppIcons {
  static const Icon appBarMenuIcon = Icon(Icons.menu_outlined);
  static const Icon appBarSearchIcon = Icon(Icons.search_outlined);
  static const Icon tabBarHomeIcon = Icon(Icons.home);
  static const Icon tabBarFavIcon = Icon(Icons.favorite_outlined);
  static const Icon playIcon = Icon(
    Icons.play_circle_outline,
    color: Colors.white,
  );
  static const Icon pauseIcon = Icon(
    Icons.pause_circle_outline,
    color: Colors.white,
  );
  static const Icon favhollowed = Icon(Icons.favorite_border_outlined);
  static final Icon favfilled = Icon(Icons.favorite_outlined, color: AppColors.primary.withOpacity(0.8));

  static const Icon ctgQuran = Icon(Icons.book_online_outlined);
  static const Icon ctgNews = Icon(Icons.newspaper_outlined);
  static const Icon ctgMusic = Icon(Icons.music_note_outlined);
  static const Icon ctgSports = Icon(Icons.sports_soccer_outlined);

  static const Icon arrowBack = Icon(Icons.arrow_back_ios);
}
