import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_internet_radio/app/core/errors/exceptions.dart';
import 'package:smart_internet_radio/app/core/errors/failures.dart';
import 'package:smart_internet_radio/app/core/usecases/use_case.dart';
import 'package:smart_internet_radio/data/datasources/local_data_source.dart';
import 'package:smart_internet_radio/data/datasources/remote_data_source.dart';
import 'package:smart_internet_radio/data/models/channel_model.dart';
import 'package:smart_internet_radio/data/repositories/channel_repo_impl.dart';

class MockChannelsLocalDataSource extends Mock
    implements ChannelsLocalDataSource {}

class MockAppAudioPlayer extends Mock implements AppAudioPlayer {}

void main() {
  late ChannelRepoImpl stu;
  final appAudioPlayer = MockAppAudioPlayer();
  final localDataSource = MockChannelsLocalDataSource();

  setUp(() {
    stu = ChannelRepoImpl(
        localDataSource: localDataSource, audioPlayer: appAudioPlayer);
  });

  final channelsFromLocalDataSource = [
    ChannelModel(
      id: 0,
      name: "0",
      fav: false,
      img: "",
      soundUrl: "",
      type: "",
    ),
    ChannelModel(
      id: 1,
      name: "1",
      fav: false,
      img: "",
      soundUrl: "",
      type: "",
    ),
  ];

  group("testing getChannels", () {
    test("testing getChannels => should return channels", () async {
      // arrange
      when(
        () => localDataSource.getChannels(),
      ).thenAnswer((_) async => channelsFromLocalDataSource);
      // act
      final result = await stu.getChannels();
      // assert
      expect(result, equals(Right(channelsFromLocalDataSource)));
      verify(
        () => localDataSource.getChannels(),
      ).called(equals(1));
    });

    test("testing getChannels => should return failure", () async {
      // arrange
      when(
        () => localDataSource.getChannels(),
      ).thenThrow(LocalDatabaseException());
      // act
      final result = await stu.getChannels();
      // assert
      expect(result, equals(Left(LocalDatabaseFailure())));
      verify(
        () => localDataSource.getChannels(),
      ).called(equals(1));
    });
  });

  group("testing toggleFav", () {
    const tId = 0;
    const tCond = "";
    test("testing toggleFav => should return void", () async {
      // arrange
      when(
        () => localDataSource.toggleFav(id: tId, cond: tCond),
      ).thenAnswer((_) async {
        return;
      });
      // act
      final result = await stu.toggleFav(id: tId, cond: tCond);
      // assert
      expect(result, equals(Right(NoParams())));
      verify(
        () => localDataSource.toggleFav(id: tId, cond: tCond),
      ).called(equals(1));
    });

    test("testing toggleFav => should return failure", () async {
      // arrange
      when(
        () => localDataSource.toggleFav(id: tId, cond: tCond),
      ).thenThrow(LocalDatabaseException());
      // act
      final result = await stu.toggleFav(id: tId, cond: tCond);
      // assert
      expect(result, equals(Left(LocalDatabaseFailure())));
      verify(
        () => localDataSource.toggleFav(id: tId, cond: tCond),
      ).called(equals(1));
    });
  });
  group("testing getAudio", () {
    const tUrl = "";

    test("testing getAudio => should return void", () async {
      // arrange
      when(
        () => appAudioPlayer.getAudio(url: tUrl),
      ).thenAnswer((_) async {
        return;
      });
      // act
      final result = await stu.getAudio(url: tUrl);
      // assert
      expect(result, equals(Right(NoParams())));
      verify(
        () => appAudioPlayer.getAudio(url: tUrl),
      ).called(equals(1));
    });

    test("testing getAudio => should return failure", () async {
      // arrange
      when(
        () => appAudioPlayer.getAudio(url: tUrl),
      ).thenThrow(AudioPlayerException());
      // act
      final result = await stu.getAudio(url: tUrl);
      // assert
      expect(result, equals(Left(AudioPlayerFailure())));
      verify(
        () => appAudioPlayer.getAudio(url: tUrl),
      ).called(equals(1));
    });
  });
}
