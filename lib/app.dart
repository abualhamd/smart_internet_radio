import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_internet_radio/config/themes/app_theme.dart';
import 'package:smart_internet_radio/core/utils/app_strings.dart';
import 'package:smart_internet_radio/core/utils/assets_manager.dart';
import 'package:smart_internet_radio/core/utils/colors/app_colors.dart';
import 'package:smart_internet_radio/features/radio_channels/presentation/cubit/radio_cubit.dart';
import 'package:smart_internet_radio/features/radio_channels/presentation/screens/home.dart';
import 'injection_container.dart' as di;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //      final controller =
  //     AnimationController(vsync: this, duration: const Duration(seconds: 1))
  //       ..repeat(reverse: true);

  // late final Animation<double> animation =
  //     CurvedAnimation(parent: controller, curve: Curves.easeInCirc);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<RadioCubit>()
        ..openDatabase()
        ..setupAlan(),
      child: BlocConsumer<RadioCubit, RadioState>(
          listener: ((context, state) async {
        RadioCubit cubit = RadioCubit.get(context);
        if (state == RadioStoreChannelsSuccessState()) {
          await cubit.getChannels();
          await cubit.getFavs();
          await cubit.getCategories();
        }
        if (state == RadioToggleFavSuccessState()) {
          await cubit.getCategories();
          await cubit.getFavs();
        }
      }), builder: (context, state) {
      
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppStrings.appTitle,
          theme: appTheme,
          home: Scaffold(
            body: AnimatedSplashScreen(
              backgroundColor: AppColors.primary,
              splash: Lottie.asset(AssetsManager.splashScreen,
                  fit: BoxFit.cover, width: 250, height: 250),
              nextScreen: const RadioHome(),
            ),
          ),
        );
      }),
    );
  }
}
