import 'package:smart_internet_radio/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:smart_internet_radio/core/usecases/use_case.dart';
import 'package:smart_internet_radio/features/radio_channels/domain/entities/channel.dart';
import 'package:smart_internet_radio/features/radio_channels/domain/repositories/channel_repo.dart';

class GetAudio implements UseCase<Channel, int> {
  final ChannelRepo _channelRepo;
  GetAudio({required ChannelRepo channelRepo}) : _channelRepo = channelRepo;

  @override
  Future<Either<Failure, Channel>> call(int channelId) {
    return _channelRepo.getAudio();
  }
}
