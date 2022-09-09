import 'package:dartz/dartz.dart';
import 'package:smart_internet_radio/core/usecases/use_case.dart';
import 'package:smart_internet_radio/features/radio_channels/domain/entities/channel.dart';
import '../../../../core/errors/failures.dart';

abstract class ChannelRepo {
  // TODO modify the parameters
  Future<Either<Failure, NoParams>> storeChannels();
  Future<Either<Failure, List<Channel>>> getChannels();
  Future<Either<Failure, NoParams>> toggleFav(
      {required int id, required String cond});
  Future<Either<Failure, NoParams>> getAudio({required String url});
  Future<Either<Failure, NoParams>> stopAudio();
  Future<Either<Failure, List<Channel>>> getFvorites();
}
