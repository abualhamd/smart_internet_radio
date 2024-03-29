import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/core/utils/app_strings.dart';
import '../../../../app/core/utils/icons_manager.dart';
import '../cubit/radio_cubit.dart';
import '../widgets/appbar_curves.dart';
import '../widgets/drawer.dart';
import '../widgets/favorites_tab_builder.dart';
import '../widgets/home_tab_builder.dart';
import '../widgets/play_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RadioCubit, RadioState>(
      listener: ((context, state) async {
        RadioCubit cubit = RadioCubit.get(context);
        // if (state == RadioToggleFavSuccessState()) {
        //   await cubit.getFavs();
        // }
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
                  extendBodyBehindAppBar: true,
                  drawer: const AppDrawer(),
                  appBar: AppBar(
                    flexibleSpace: const AppbarCurves(),
                    backgroundColor: Colors.transparent,
                    title: const Text(AppStrings.appTitle),
                    bottom: PreferredSize(
                      //todo
                      preferredSize: Size.fromHeight(40),
                      child: Theme(
                        data: ThemeData(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent),
                        child: const TabBar(
                            enableFeedback: false,
                            indicatorColor: Colors.transparent,
                            tabs: [
                              Tab(icon: IconsManager.tabBarHomeIcon),
                              Tab(icon: IconsManager.tabBarFavIcon),
                            ]),
                      ),
                    ),
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
