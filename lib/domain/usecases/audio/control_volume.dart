import 'package:dartz/dartz.dart';
import 'package:smart_internet_radio/domain/repositories/channel_repo.dart';

import '../../../app/core/errors/failures.dart';
import '../../../app/core/usecases/use_case.dart';

class ControlVolumeUsecase implements UseCase<NoParams, double> {
  final ChannelRepo _channelRepo;
  ControlVolumeUsecase({required ChannelRepo channelRepo})
      : _channelRepo = channelRepo;

  @override
  Future<Either<Failure, NoParams>> call(double volume) async {
    return await _channelRepo.controlVolume(volume: volume);
  }
}
