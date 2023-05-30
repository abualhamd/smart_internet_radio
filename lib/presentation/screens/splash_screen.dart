import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../../app/core/utils/assets_manager.dart';
import '../../../../app/core/utils/colors/app_colors.dart';
import 'home.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        backgroundColor: ColorsManager.primary,
        splash: Lottie.asset(AssetsManager.splashScreen,
            fit: BoxFit.cover, width: 250.w, height: 250.h),
        nextScreen: const HomeScreen(),
      ),
    );
  }
}
