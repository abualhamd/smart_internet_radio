import 'package:flutter/material.dart';
import '../../../../app/config/routes_manager.dart';
import '../../../../app/core/utils/app_strings.dart';
import '../../../../app/core/utils/icons_manager.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: IconsManager.arrowBack,
            onPressed: () {
              Navigator.pushNamed(context, Routes.homeRoute);
            },
          ),
          title: const Text(AppStrings.about),
        ),
        body: const Center(child: Text(AppStrings.about)),
      ),
    );
  }
}
