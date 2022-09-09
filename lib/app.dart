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
      child: BlocListener<RadioCubit, RadioState>(
        listener: ((context, state)  async{
          if (state == RadioStoreChannelsSuccessState()) {
            await context.read<RadioCubit>().getChannels();
            await context.read<RadioCubit>().getFavs();
          }
        }),
        // buildWhen: (previous, current) {
        //   return current == RadioGetChannelsSuccessState();
        // },
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: appTheme,
            home: const RadioHome(),
          )
        
      ),
    );
  }
}
