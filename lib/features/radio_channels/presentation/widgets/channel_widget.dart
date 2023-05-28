import 'package:flutter/material.dart';
import 'package:smart_internet_radio/core/utils/icons_manager.dart';
import 'package:smart_internet_radio/core/utils/extensions/media_query_values.dart';
import 'package:smart_internet_radio/features/radio_channels/presentation/cubit/radio_cubit.dart';
import '../../domain/entities/channel.dart';

class ChannelWidget extends StatelessWidget {
  const ChannelWidget({required this.channel, Key? key}) : super(key: key);

  final Channel channel;

  @override
  Widget build(BuildContext context) {
    double width = context.width;
    RadioCubit cubit = RadioCubit.get(context);
    return ListTile(
      onTap: () async {
        await cubit.playChannel(channel: channel);
      },
      leading: Material(
        color: Colors.transparent,
        elevation: width / 30,
        child: Container(
          height: width / 5,
          width: width / 5,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(width / 40),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(channel.img),
            ),
          ),
        ),
      ),
      title: Text(channel.name),
      subtitle: Text(channel.type),
      trailing: IconButton(
        icon: Visibility(
          visible: channel.fav,
          replacement: IconsManager.favhollowed,
          child: IconsManager.favfilled,
        ),
        onPressed: () async {
          await cubit.toggleFav(id: channel.id, cond: channel.fav);
        },
      ),
    );
  }
}
