import 'package:equatable/equatable.dart';

class Channel extends Equatable {
  @override
  List<Object?> get props => [id];

  final int id;
  final String name;
  final String type;
  final String img;
  final String soundUrl;
  bool fav;

   Channel({
    required this.id,
    required this.name,
    required this.type,
    required this.soundUrl,
    required this.img,
    required this.fav,
  });
}
