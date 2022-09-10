import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_internet_radio/core/utils/app_icons.dart';
import 'package:smart_internet_radio/core/utils/app_strings.dart';
import 'package:smart_internet_radio/features/radio_channels/presentation/cubit/radio_cubit.dart';
import 'package:smart_internet_radio/features/radio_channels/presentation/widgets/favorites_tab_builder.dart';
import 'package:smart_internet_radio/features/radio_channels/presentation/widgets/home_tab_builder.dart';
import '../widgets/drawer.dart';
import '../widgets/play_bar.dart';

class RadioHome extends StatelessWidget {
  const RadioHome({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RadioCubit, RadioState>(
      listener: ((context, state) async {
        RadioCubit cubit = RadioCubit.get(context);
        if (state == RadioToggleFavSuccessState()) {
          await cubit.getFavs();
        }
      }),
      builder: (context, state) {
        return ConditionalBuilder(
            condition: context.read<RadioCubit>().playbarChannel != null,
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
            builder: (context) {
              return DefaultTabController(
                length: 2,
                child: Scaffold(
                  drawer: const AppDrawer(),
                  appBar: AppBar(
                    title: const Text(AppStrings.appTitle),
                    actions: [
                      IconButton(
                        onPressed: () {},
                        icon: AppIcons.appBarSearchIcon,
                      )
                    ],
                    bottom: const TabBar(enableFeedback: false, tabs: [
                      AppIcons.tabBarHomeIcon,
                      AppIcons.tabBarFavIcon,
                    ]),
                  ),
                  body: const TabBarView(children: [
                    HomeTabBuilder(),
                    FavoritesTabBuilder(),
                  ]),
                  bottomNavigationBar: PlayBar(),
                ),
              );
            });
      },
    );
  }
}
