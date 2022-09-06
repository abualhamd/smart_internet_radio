import 'package:flutter/material.dart';
import 'package:smart_internet_radio/features/radio_channels/presentation/widgets/channel_widget.dart';

class HomeTabBuilder extends StatelessWidget {
  const HomeTabBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index) => ChannelWidget(), itemCount: 10,);
  }
}
