import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_internet_radio/config/themes/app_theme.dart';
import 'package:smart_internet_radio/features/radio_channels/presentation/cubit/radio_cubit.dart';
import 'package:smart_internet_radio/features/radio_channels/presentation/screens/home.dart';
import 'injection_container.dart' as di;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<RadioCubit>()..openDatabase(),
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
          }),
          builder: (context, state) => MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                theme: appTheme,
                home: const RadioHome(),
              )),
    );
  }
}
