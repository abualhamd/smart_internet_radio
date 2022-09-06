import 'package:dartz/dartz.dart';
import 'package:smart_internet_radio/features/radio_channels/domain/entities/channel.dart';
import '../../../../core/errors/failures.dart';

abstract class ChannelRepo {
  Future<Either<Failure, Channel>> getAudio();
}
