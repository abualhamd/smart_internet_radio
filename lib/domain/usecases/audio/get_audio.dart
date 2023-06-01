import 'package:dartz/dartz.dart';
import 'package:smart_internet_radio/domain/repositories/channel_repo.dart';

import '../../../app/core/errors/failures.dart';
import '../../../app/core/usecases/use_case.dart';

class GetAudioUsecase implements UseCase<NoParams, String> {
  final ChannelRepo _channelRepo;
  GetAudioUsecase({required ChannelRepo channelRepo})
      : _channelRepo = channelRepo;

  @override
  Future<Either<Failure, NoParams>> call(String url) async{
    return await _channelRepo.getAudio(url: url);
  }
}
