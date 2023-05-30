import 'package:dartz/dartz.dart';
import '../../../app/core/errors/failures.dart';
import '../../../app/core/usecases/use_case.dart';
import '../../repositories/channel_repo.dart';

class StopAudioUsecase implements UseCase<NoParams, NoParams> {
  final ChannelRepo _channelRepo;
  StopAudioUsecase({required ChannelRepo channelRepo})
      : _channelRepo = channelRepo;

  @override
  Future<Either<Failure, NoParams>> call(NoParams params) async{
    return await _channelRepo.stopAudio();
  }
}
