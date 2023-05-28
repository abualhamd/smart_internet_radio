import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_internet_radio/core/utils/icons_manager.dart';
import 'package:smart_internet_radio/core/utils/app_strings.dart';
import 'package:smart_internet_radio/features/radio_channels/presentation/cubit/radio_cubit.dart';
import 'package:smart_internet_radio/features/radio_channels/presentation/widgets/category_widget.dart';
import '../../../../config/routes_manager.dart';
import '../../../../core/utils/colors/app_colors.dart';
import '../../../../core/utils/enums.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RadioCubit, RadioState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(color: ColorsManager.primary),
                    child: null,
                  ),
                  ...Categories.values
                      .map((category) => CategoryWidget(category: category)),
                ],
              ),
              ListTile(
                leading: IconsManager.aboutIcon,
                title: const Text(AppStrings.about),
                onTap: () => Navigator.pushReplacementNamed(context, Routes.aboutRoute),
              )
            ],
          ),
        );
      },
    );
  }
}
