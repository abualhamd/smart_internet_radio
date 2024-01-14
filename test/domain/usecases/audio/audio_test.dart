import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_internet_radio/app/core/errors/exceptions.dart';
import 'package:smart_internet_radio/app/core/errors/failures.dart';
import 'package:smart_internet_radio/app/core/usecases/use_case.dart';
import 'package:smart_internet_radio/domain/repositories/channel_repo.dart';
import 'package:smart_internet_radio/domain/usecases/audio/get_audio.dart';

class MockChannelRepo extends Mock implements ChannelRepo {}

void main() {
  final channelRepo = MockChannelRepo();
  late GetAudioUsecase getAudioUsecase;

  setUp(() {
    getAudioUsecase = GetAudioUsecase(channelRepo: channelRepo);
  });

  group("Testing GetAudioUsecase", () {
    const url = '';

    test("GetAudioUsecase should return NoParmas", () async {
      final right = Right<Failure, NoParams>(NoParams());
      // arrange
      when(() => channelRepo.getAudio(url: url)).thenAnswer((_) async => right);

      // act
      final result = await getAudioUsecase.call(url);

      // assert
      expect(result, equals(right));
      verify(() => channelRepo.getAudio(url: url)).called(1);
    });

    test("GetAudioUsecase should return Failure", () async {
      final left = Left<Failure, NoParams>(AudioPlayerFailure());
      // arrange
      when(() => channelRepo.getAudio(url: url)).thenAnswer((_) async => left);

      // act
      final result = await getAudioUsecase.call(url);

      // assert
      expect(result, equals(left));
      verify(() => channelRepo.getAudio(url: url)).called(1);
    });
  });
}
