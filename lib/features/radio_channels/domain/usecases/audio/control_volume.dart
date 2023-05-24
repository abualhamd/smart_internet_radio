import 'package:smart_internet_radio/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:smart_internet_radio/core/usecases/use_case.dart';
import 'package:smart_internet_radio/features/radio_channels/domain/repositories/channel_repo.dart';

class ControlVolumeUsecase implements UseCase<NoParams, double> {
  final ChannelRepo _channelRepo;
  ControlVolumeUsecase({required ChannelRepo channelRepo})
      : _channelRepo = channelRepo;

  @override
  Future<Either<Failure, NoParams>> call(double volume) async {
    return await _channelRepo.controlVolume(volume: volume);
  }
}
