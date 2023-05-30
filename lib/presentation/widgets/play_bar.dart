import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_internet_radio/app/core/utils/extensions/media_query_values.dart';
import '../../../../app/core/utils/colors/app_colors.dart';
import '../cubit/radio_cubit.dart';

class PlayBar extends StatelessWidget {
  const PlayBar._internal({Key? key}) : super(key: key);

  static const instance = PlayBar._internal();

  factory PlayBar() => instance;

  @override
  Widget build(BuildContext context) {
    RadioCubit cubit = RadioCubit.get(context);
    double width = context.width;

    return BlocBuilder<RadioCubit, RadioState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () async {
            await cubit.pressPlaybar();
          },
          child: Container(
            color: ColorsManager.primary,
            child: ListTile(
              leading: Container(
                width: width / 6,
                height: width / 6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(width / 30),
                  image: DecorationImage(
                    image: AssetImage(cubit.playbarChannel!.img),
                    fit: BoxFit.fill,
                  ),
                ),
              ), //Image.asset(cubit.playbarChannel!.img),
              title: Text(
                cubit.playbarChannel!.name,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                cubit.playbarChannel!.type,
                style: TextStyle(color: Colors.white),
              ),
              trailing: IconButton(
                icon: cubit.playPauseIcon,
                color: ColorsManager.white,
                onPressed: () async {
                  await cubit.pressPlaybar();
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
