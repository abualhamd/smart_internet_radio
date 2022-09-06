import 'package:flutter/material.dart';
import 'package:smart_internet_radio/core/utils/app_strings.dart';

import '../../../../core/utils/colors/app_colors.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Text(
              'Categories',
              style: TextStyle(color: Colors.white),
            ),
            decoration: BoxDecoration(color: AppColors.primary),
          ),
          ListTile(
            leading: Icon(Icons.book_online_outlined),
            title: Text(AppStrings.categQuran),
          ),
          ListTile(
            leading: Icon(Icons.newspaper_outlined),
            title: Text(AppStrings.categNews),
          ),
          ListTile(
            leading: Icon(Icons.music_note_outlined),
            title: Text(AppStrings.categMusic),
          ),
          ListTile(
            leading: Icon(Icons.sports_soccer_outlined),
            title: Text(AppStrings.categSports),
          ),
        ],
      ),
    );
  }
}
