import 'package:flutter/material.dart';
import 'package:smart_internet_radio/core/utils/app_icons.dart';
import 'package:smart_internet_radio/core/utils/app_strings.dart';
import 'package:smart_internet_radio/features/radio_channels/presentation/widgets/favorites_tab_builder.dart';
import 'package:smart_internet_radio/features/radio_channels/presentation/widgets/home_tab_builder.dart';
import '../widgets/drawer.dart';
import '../widgets/play_bar.dart';

class RadioHome extends StatelessWidget {
  const RadioHome({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          // leading: AppIcons.appBarMenuIcon,
          title: const Text(AppStrings.appTitle),
          actions: [
            IconButton(
              onPressed: () {},
              icon: AppIcons.appBarSearchIcon,
            )
          ],
          bottom: TabBar(tabs: [
            AppIcons.tabBarHomeIcon,
            AppIcons.tabBarFavIcon,
          ]),
        ),
        body: TabBarView(children: [
          HomeTabBuilder(),
          FavoritesTabBuilder(),
        ]),
        bottomNavigationBar: PlayBar(),
      ),
    );
  }
}
