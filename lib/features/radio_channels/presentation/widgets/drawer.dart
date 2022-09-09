import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_internet_radio/core/utils/app_icons.dart';
import 'package:smart_internet_radio/core/utils/app_strings.dart';
import 'package:smart_internet_radio/features/radio_channels/presentation/cubit/radio_cubit.dart';
import 'package:smart_internet_radio/features/radio_channels/presentation/screens/category_screen.dart';
import '../../../../core/utils/colors/app_colors.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RadioCubit, RadioState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: AppColors.primary),
                child: const Text(
                  // TODO
                  'Categories',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ListTile(
                leading: AppIcons.ctgQuran,
                title: const Text(AppStrings.categQuran),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryScreen(
                        categoryName: AppStrings.categQuran,
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                leading: AppIcons.ctgNews,
                title: const Text(AppStrings.categNews),
                onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryScreen(
                      categoryName: AppStrings.categNews,
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: AppIcons.ctgMusic,
                title: const Text(AppStrings.categMusic),
                onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: ((context) =>
                        CategoryScreen(categoryName: AppStrings.categMusic)),
                  ),
                ),
              ),
              ListTile(
                leading: AppIcons.ctgSports,
                title: const Text(AppStrings.categSports),
                onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: ((context) =>
                        CategoryScreen(categoryName: AppStrings.categSports)),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
