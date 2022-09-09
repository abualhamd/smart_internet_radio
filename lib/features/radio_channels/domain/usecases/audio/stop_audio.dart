import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/usecases/use_case.dart';
import '../../repositories/channel_repo.dart';

class StopAudioUsecase implements UseCase<void, NoParams> {
  final ChannelRepo _channelRepo;
  StopAudioUsecase({required ChannelRepo channelRepo})
      : _channelRepo = channelRepo;

  @override
  Future<Either<Failure, dynamic>> call(NoParams params) {
    return _channelRepo.stopAudio();
  }
}
