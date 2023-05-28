import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_internet_radio/core/utils/colors/app_colors.dart';

final appTheme = ThemeData(
  primarySwatch: ColorsManager.primaryMaterial,
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    elevation: 0,
  ),
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
  listTileTheme: ListTileThemeData(
    titleTextStyle: TextStyle(
      color: ColorsManager.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 20.sp,
                ),
  )
);
