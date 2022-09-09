import 'package:flutter/material.dart';
import 'package:smart_internet_radio/core/utils/app_icons.dart';
import 'package:smart_internet_radio/features/radio_channels/presentation/cubit/radio_cubit.dart';
import '../../domain/entities/channel.dart';

class ChannelWidget extends StatelessWidget {
  const ChannelWidget({required this.channel, Key? key}) : super(key: key);

  final Channel channel;

  @override
  Widget build(BuildContext context) {
    RadioCubit cubit = RadioCubit.get(context);
    return ListTile(
      onTap: () async {
        await cubit.playChannel(channel: channel);
      },
      leading: Image.asset(channel.img),
      title: Text(channel.name),
      subtitle: Text(channel.type),
      trailing: IconButton(
        icon: channel.fav ? AppIcons.favfilled : AppIcons.favhollowed,
        onPressed: () async {
          await cubit.toggleFav(id: channel.id, cond: channel.fav);
        },
      ),
    );
  }
}
