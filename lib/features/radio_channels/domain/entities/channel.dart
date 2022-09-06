import 'package:equatable/equatable.dart';

class Channel extends Equatable {
  @override
  List<Object?> get props => [name, type, img, type];

  final String name;
  final String type;
  final String img;
  final String soundUrl;

  const Channel(
      {required this.name,
      required this.type,
      required this.soundUrl,
      required this.img});

  Channel.fromJson({required Map<String, dynamic> json})
      : name = json['name'],
        type = json['type'],
        img = json['img'],
        soundUrl = json['soundUrl'];
}
