import 'package:flutter/material.dart';
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
        await cubit.toggleFav(id: _favChannel.id, cond: true);
      },
      onTap: () async {
        await cubit.playChannel(channel: _favChannel);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width / 50),
        child: Card(
            shape:
                // TODO
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(width / 15)),
            elevation: 5,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: width / 70),
              child: ListTile(
                leading: Container(
                  height: width / 5,
                  width: width / 5,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(width / 40),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(_favChannel.img),
                    ),
                  ),
                ),
                title: Text(_favChannel.name),
                subtitle: Text(_favChannel.type),
              ),
            )),
      ),
    );
  }
}
