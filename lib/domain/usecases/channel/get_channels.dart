import 'package:dartz/dartz.dart';
import 'package:smart_internet_radio/domain/entities/channel.dart';
import 'package:smart_internet_radio/domain/repositories/channel_repo.dart';

import '../../../app/core/errors/failures.dart';
import '../../../app/core/usecases/use_case.dart';

class GetChannelsUsecase implements UseCase<List<Channel>, NoParams> {
  GetChannelsUsecase({required ChannelRepo channelRepo})
      : _channelRepo = channelRepo;

  final ChannelRepo _channelRepo;

  @override
  Future<Either<Failure, List<Channel>>> call(NoParams params) async {
    return await _channelRepo.getChannels();
  }
}
