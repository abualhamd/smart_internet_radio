import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'config/routes_manager.dart';
import 'config/themes/app_theme.dart';
import 'core/utils/app_strings.dart';
import 'injection_container.dart' as di;
import '../presentation/cubit/radio_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //      final controller =
  //     AnimationController(vsync: this, duration: const Duration(seconds: 1))
  //       ..repeat(reverse: true);

  // late final Animation<double> animation =
  //     CurvedAnimation(parent: controller, curve: Curves.easeInCirc);

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
          await Future.wait([
            cubit.getFavs(),
            cubit.getCategories()
          ]) ;
        }
      }), builder: (context, state) {
        return ScreenUtilInit(
          designSize: const Size(390, 844),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (BuildContext context, Widget? child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: AppStrings.appTitle,
              theme: appTheme,
              onGenerateRoute: RouteGenerator.getRoute,
            );
          },
        );
      }),
    );
  }
}
