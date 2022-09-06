import 'package:flutter/material.dart';
import 'package:smart_internet_radio/config/themes/app_theme.dart';
import 'package:smart_internet_radio/features/radio_channels/presentation/screens/home.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: appTheme,
      home: const RadioHome(),
    );
  }
}
