import 'package:smart_internet_radio/features/radio_channels/domain/entities/channel.dart';

class ChannelModel extends Channel {
  ChannelModel(
      {required int id,
      required String name,
      required String type,
      required String img,
      required String soundUrl,
      required bool fav})
      : super(
            id: id,
            name: name,
            img: img,
            type: type,
            soundUrl: soundUrl,
            fav: fav);

  ChannelModel.fromJson({required Map<String, dynamic> json})
      : super(
          id: json['id'],
          name: json['name'],
          type: json['type'],
          img: json['img'],
          soundUrl: json['soundUrl'],
          fav: json['fav'] == 'true',
        );
}
