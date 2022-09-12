import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_internet_radio/core/utils/app_icons.dart';
import 'package:smart_internet_radio/features/radio_channels/domain/entities/channel.dart';
import 'package:smart_internet_radio/features/radio_channels/presentation/cubit/radio_cubit.dart';
import 'package:smart_internet_radio/features/radio_channels/presentation/screens/curve_screen.dart';
import 'package:smart_internet_radio/features/radio_channels/presentation/screens/home.dart';
import 'package:smart_internet_radio/features/radio_channels/presentation/widgets/channel_widget.dart';
import 'package:smart_internet_radio/features/radio_channels/presentation/widgets/play_bar.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({required String categoryName, super.key})
      : _categoryName = categoryName;

  final String _categoryName;

  @override
  Widget build(BuildContext context) {
    RadioCubit cubit = RadioCubit.get(context);

    List<Channel> channels = cubit.channelsCategories[_categoryName] ?? [];
    return BlocConsumer<RadioCubit, RadioState>(
      listener: ((context, state) {}),
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            // TODO add curves to the appbar
            leading: IconButton(
              icon: AppIcons.arrowBack,
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const RadioHome()));
              },
            ),
            title: Text(_categoryName),
          ),
          body: ListView.builder(
            itemBuilder: (context, index) {
              return ChannelWidget(channel: channels[index]);
            },
            itemCount: channels.length,
          ),
          bottomNavigationBar: PlayBar(),
        );
      },
    );
  }
}
