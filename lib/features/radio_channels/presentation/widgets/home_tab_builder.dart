import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_internet_radio/features/radio_channels/presentation/cubit/radio_cubit.dart';
import 'package:smart_internet_radio/features/radio_channels/presentation/widgets/channel_widget.dart';

class HomeTabBuilder extends StatelessWidget {
  const HomeTabBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RadioCubit cubit = RadioCubit.get(context);

    return BlocConsumer<RadioCubit, RadioState>(
      listener: ((context, state) {}),
      builder: (context, state) {
        return ListView.builder(
          itemBuilder: (context, index) {
            return ChannelWidget(
              channel: cubit.channels[index],
            );
          },
          itemCount: cubit.channels.length,
        );
        ;
      },
    );
  }
}
