import 'package:smart_internet_radio/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:smart_internet_radio/core/usecases/use_case.dart';
import 'package:smart_internet_radio/features/radio_channels/domain/repositories/channel_repo.dart';

class StoreChannelsUsecase implements UseCase<NoParams, NoParams> {
  StoreChannelsUsecase({required ChannelRepo channelRepo})
      : _channelRepo = channelRepo;

  final ChannelRepo _channelRepo;

  @override
  Future<Either<Failure, NoParams>> call(NoParams params) async {
    return await _channelRepo.storeChannels();
  }
}
