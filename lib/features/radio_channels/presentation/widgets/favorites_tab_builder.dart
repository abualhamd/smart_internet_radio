import 'package:flutter/material.dart';
import 'package:smart_internet_radio/features/radio_channels/presentation/widgets/favorite_widget.dart';

class FavoritesTabBuilder extends StatelessWidget {
  const FavoritesTabBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index) => FavWidget(), itemCount: 10,);
  }
}
