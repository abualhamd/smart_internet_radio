import 'package:smart_internet_radio/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:smart_internet_radio/core/usecases/use_case.dart';
import 'package:smart_internet_radio/features/radio_channels/domain/repositories/channel_repo.dart';

class GetAudioUsecase implements UseCase<NoParams, String> {
  final ChannelRepo _channelRepo;
  GetAudioUsecase({required ChannelRepo channelRepo})
      : _channelRepo = channelRepo;

  @override
  Future<Either<Failure, NoParams>> call(String url) async{
    return await _channelRepo.getAudio(url: url);
  }
}
