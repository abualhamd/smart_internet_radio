import 'package:flutter/material.dart';

abstract class AppIcons {
  static const Icon appBarMenuIcon = Icon(Icons.menu_outlined);
  static const Icon appBarSearchIcon = Icon(Icons.search_outlined);
  static const Icon tabBarHomeIcon = Icon(Icons.home_outlined);
  static const Icon tabBarFavIcon = Icon(Icons.favorite_outline);
  static const Icon playIcon = Icon(
    Icons.play_circle_outline,
    color: Colors.white,
  );
  static const Icon pauseIcon = Icon(
    Icons.pause_circle_outline,
    color: Colors.white,
  );
  static const Icon favhollowed = Icon(Icons.favorite_border_outlined);
  static const Icon favfilled = Icon(Icons.favorite_outlined);

  static const Icon ctgQuran = Icon(Icons.book_online_outlined);
  static const Icon ctgNews = Icon(Icons.newspaper_outlined);
  static const Icon ctgMusic = Icon(Icons.music_note_outlined);
  static const Icon ctgSports = Icon(Icons.sports_soccer_outlined);
}
