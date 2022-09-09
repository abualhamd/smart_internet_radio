import 'package:flutter/material.dart';
import 'package:smart_internet_radio/core/utils/assets_manager.dart';
import 'package:smart_internet_radio/core/utils/extensions/media_query_values.dart';
import 'package:smart_internet_radio/features/radio_channels/presentation/cubit/radio_cubit.dart';

import '../../domain/entities/channel.dart';

class FavWidget extends StatelessWidget {
  const FavWidget({required Channel favChannel, Key? key})
      : _favChannel = favChannel,
        super(key: key);

  final Channel _favChannel;

  @override
  Widget build(BuildContext context) {
    final double width = context.width;
    RadioCubit cubit = RadioCubit.get(context);

    return InkWell(
      onLongPress: () async {
        await cubit.toggleFav(id: _favChannel.id, cond: _favChannel.fav);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width / 50),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          elevation: 5,
          child: ListTile(
            leading: Image.asset(_favChannel.img),
            title: Text(_favChannel.name),
            subtitle: Text(_favChannel.type),
          ),
        ),
      ),
    );
  }
}
