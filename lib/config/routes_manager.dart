import 'package:flutter/material.dart';
import 'package:smart_internet_radio/features/radio_channels/presentation/screens/home.dart';
import 'package:smart_internet_radio/features/radio_channels/presentation/screens/splash_screen.dart';

import '../core/utils/app_strings.dart';
import '../features/radio_channels/presentation/screens/about_screen.dart';
import '../features/radio_channels/presentation/screens/category_screen.dart';

abstract class Routes {
  static const String splashRoute = '/';
  static const String homeRoute = "/homeRoute";
  static const String categoryRoute = "/categoryRoute";
  static const String aboutRoute = "/aboutRoute";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case Routes.categoryRoute:
        return MaterialPageRoute(builder: (_) => const CategoryScreen());
      case Routes.aboutRoute:
        return MaterialPageRoute(builder: (_) => const AboutScreen());
      default:
        return _unDefinedRoute();
    }
  }

  static Route<dynamic> _unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text(AppStrings.undefinedRoute)),
        body: const Center(child: Text(AppStrings.undefinedRoute)),
      ),
    );
  }
}
