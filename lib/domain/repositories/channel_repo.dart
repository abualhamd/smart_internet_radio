import 'package:dartz/dartz.dart';
import 'package:smart_internet_radio/domain/entities/channel.dart';
import '../../app/core/errors/failures.dart';
import '../../app/core/usecases/use_case.dart';
import '../../app/core/utils/enums.dart';

abstract class ChannelRepo {
  Future<Either<Failure, NoParams>> storeChannels();
  Future<Either<Failure, List<Channel>>> getChannels();
  Future<Either<Failure, List<Channel>>> getFvorites();
  Future<Either<Failure, Map<Categories, List<Channel>>>> getCategories();
  Future<Either<Failure, NoParams>> toggleFav(
      {required int id, required String cond});
  Future<Either<Failure, NoParams>> getAudio({required String url});
  Future<Either<Failure, NoParams>> stopAudio();
  Future<Either<Failure, NoParams>> controlVolume({required double volume});
}
