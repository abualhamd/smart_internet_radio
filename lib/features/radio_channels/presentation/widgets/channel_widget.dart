import 'package:flutter/material.dart';

class ChannelWidget extends StatelessWidget {
  const ChannelWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){},
      leading: Image.asset('assets/images/temp.jpg'),
      title: Text('BBC Arabic'),
      subtitle: Text('News'),
      trailing: Icon(Icons.favorite_border_outlined),
    );
  }
}
