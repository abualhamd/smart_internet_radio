import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_internet_radio/core/utils/extensions/channel_icon_extension.dart';
import 'package:smart_internet_radio/features/radio_channels/presentation/cubit/radio_cubit.dart';

import '../../../../config/routes_manager.dart';
import '../../../../core/utils/enums.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key, required Categories category})
      : _category = category;
  final Categories _category;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: _category.getIcon(),
      title:
          Text(_category.name[0].toUpperCase() + _category.name.substring(1)),
      onTap: () {
        context.read<RadioCubit>().changeChoosenCategory(category: _category);
        Navigator.pushNamed(context, Routes.categoryRoute);
      },
    );
  }
}
