import 'package:smart_internet_radio/data/datasources/remote_data_source.dart';
import 'package:dartz/dartz.dart';
import 'package:smart_internet_radio/domain/entities/channel.dart';
import 'package:smart_internet_radio/domain/repositories/channel_repo.dart';
import '../../app/core/errors/exceptions.dart';
import '../../app/core/errors/failures.dart';
import '../../app/core/usecases/use_case.dart';
import '../../app/core/utils/enums.dart';
import '../datasources/local_data_source.dart';
import '../models/channel_model.dart';

class ChannelRepoImpl implements ChannelRepo {
  ChannelRepoImpl(
      {required ChannelsLocalDataSource localDataSource,
      required AppAudioPlayer audioPlayer})
      : _localDataSource = localDataSource,
        _audioPlayer = audioPlayer;

  final ChannelsLocalDataSource _localDataSource;
  final AppAudioPlayer _audioPlayer;

  @override
  Future<Either<Failure, List<ChannelModel>>> getChannels() async {
    try {
      return Right(await _localDataSource.getChannels());
    } on LocalDatabaseException {
      return Left(LocalDatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, NoParams>> storeChannels() async {
    try {
      await _localDataSource.storeChannels();
      return Right(NoParams());
    } on LocalDatabaseException {
      return Left(LocalDatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, NoParams>> toggleFav(
      {required int id, required String cond}) async {
    try {
      await _localDataSource.toggleFav(id: id, cond: cond);
      return Right(NoParams());
    } on LocalDatabaseException {
      return Left(LocalDatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, NoParams>> getAudio({required String url}) async {
    try {
      await _audioPlayer.getAudio(url: url);
      return (Right(NoParams()));
    } on AudioPlayerException {
      return Left(AudioPlayerFailure());
    }
  }

  @override
  Future<Either<Failure, NoParams>> stopAudio() async {
    try {
      await _audioPlayer.stopAudio();

      return Right(NoParams());
    } on AudioPlayerException {
      return Left(AudioPlayerFailure());
    }
  }

  @override
  Future<Either<Failure, List<ChannelModel>>> getFvorites() async {
    try {
      return Right(await _localDataSource.getFavorites());
    } on LocalDatabaseException {
      return Left(LocalDatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, Map<Categories, List<Channel>>>> getCategories() async {
    try {
      return Right(await _localDataSource.getCategories());
    } on LocalDatabaseException {
      return Left(LocalDatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, NoParams>> controlVolume(
      {required double volume}) async {
    try {
      await _audioPlayer.controlVolume(volume: volume);
      return Right(NoParams());
    } on AudioPlayerException {
      return Left(AudioPlayerFailure());
    }
  }
}
