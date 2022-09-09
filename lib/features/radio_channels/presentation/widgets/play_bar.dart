import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_internet_radio/features/radio_channels/presentation/cubit/radio_cubit.dart';
import '../../../../core/utils/colors/app_colors.dart';

class PlayBar extends StatelessWidget {
  const PlayBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RadioCubit cubit = RadioCubit.get(context);

    return BlocBuilder<RadioCubit, RadioState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () async {
            await cubit.pressPlaybar();
          },
          child: Container(
            color: AppColors.primary,
            child: ListTile(
              leading: Image.asset(cubit.playbarChannel!.img),
              title: Text(
                cubit.playbarChannel!.name,
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                cubit.playbarChannel!.type,
                style: TextStyle(color: Colors.white),
              ),
              trailing: IconButton(
                icon: cubit.playPauseIcon,
                onPressed: (() {}),
              ),
            ),
          ),
        );
      },
    );
  }
}
