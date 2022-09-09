import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_internet_radio/features/radio_channels/presentation/cubit/radio_cubit.dart';
import 'package:smart_internet_radio/features/radio_channels/presentation/widgets/favorite_widget.dart';

class FavoritesTabBuilder extends StatelessWidget {
  const FavoritesTabBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RadioCubit cubit = RadioCubit.get(context);
    return BlocConsumer<RadioCubit, RadioState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return ListView.builder(
                itemBuilder: (context, index) =>
                    FavWidget(favChannel: cubit.favs[index]),
                itemCount: cubit.favs.length,
              );
      },
    );
  }
}
