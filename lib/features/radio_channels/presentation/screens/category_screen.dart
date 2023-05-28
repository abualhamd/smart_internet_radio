import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_internet_radio/core/utils/icons_manager.dart';
import 'package:smart_internet_radio/core/utils/enums.dart';
import 'package:smart_internet_radio/features/radio_channels/domain/entities/channel.dart';
import 'package:smart_internet_radio/features/radio_channels/presentation/cubit/radio_cubit.dart';
import 'package:smart_internet_radio/features/radio_channels/presentation/screens/home.dart';
import 'package:smart_internet_radio/features/radio_channels/presentation/widgets/channel_widget.dart';
import 'package:smart_internet_radio/features/radio_channels/presentation/widgets/play_bar.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});
  // : _category = category;

  @override
  Widget build(BuildContext context) {
    RadioCubit cubit = RadioCubit.get(context);
    final Categories category = context.watch<RadioCubit>().choosenCategory!;

    List<Channel> channels = cubit.channelsCategories[category] ?? [];
    return BlocConsumer<RadioCubit, RadioState>(
      listener: ((context, state) {}),
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: IconsManager.arrowBack,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
                category.name[0].toUpperCase() + category.name.substring(1)),
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
