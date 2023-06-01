import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../app/config/routes_manager.dart';
import '../../../../app/core/utils/app_strings.dart';
import '../../../../app/core/utils/colors/app_colors.dart';
import '../../../../app/core/utils/enums.dart';
import '../../../../app/core/utils/icons_manager.dart';
import '../cubit/radio_cubit.dart';
import 'category_widget.dart';

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
              Padding(
                padding: EdgeInsetsDirectional.only(bottom: 10.h),
                child: ListTile(
                  leading: IconsManager.aboutIcon,
                  titleAlignment: ListTileTitleAlignment.center,
                  title: const Text(AppStrings.about),
                  onTap: () => Navigator.pushReplacementNamed(context, Routes.aboutRoute),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
