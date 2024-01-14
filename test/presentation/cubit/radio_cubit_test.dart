import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_internet_radio/app/core/usecases/use_case.dart';
import 'package:smart_internet_radio/app/core/utils/icons_manager.dart';
import 'package:smart_internet_radio/domain/entities/channel.dart';
import 'package:smart_internet_radio/domain/usecases/audio/control_volume.dart';
import 'package:smart_internet_radio/domain/usecases/audio/get_audio.dart';
import 'package:smart_internet_radio/domain/usecases/audio/stop_audio.dart';
import 'package:smart_internet_radio/domain/usecases/channel/get_categories.dart';
import 'package:smart_internet_radio/domain/usecases/channel/get_channels.dart';
import 'package:smart_internet_radio/domain/usecases/channel/get_favs.dart';
import 'package:smart_internet_radio/domain/usecases/channel/store_channels.dart';
import 'package:smart_internet_radio/domain/usecases/channel/toggle_fav.dart';
import 'package:smart_internet_radio/presentation/cubit/radio_cubit.dart';

class MockStoreChannelsUsecase extends Mock implements StoreChannelsUsecase {}

class MockGetChannelsUsecase extends Mock implements GetChannelsUsecase {}

class MockGetAudioUsecase extends Mock implements GetAudioUsecase {}

class MockStopAudioUsecase extends Mock implements StopAudioUsecase {}

class MockControlVolumeUsecase extends Mock implements ControlVolumeUsecase {}

class MockToggleFavUsecase extends Mock implements ToggleFavUsecase {}

class MockGetFavsUsecase extends Mock implements GetFavsUsecase {}

class MockGetCategoriesUsecase extends Mock implements GetCategoriesUsecase {}

void main() {
  late RadioCubit sut;
  final storeChannelsUsecase = MockStoreChannelsUsecase();
  final getChannelsUsecase = MockGetChannelsUsecase();
  final getAudioUsecase = MockGetAudioUsecase();
  final stopAudioUsecase = MockStopAudioUsecase();
  final controlVolumeUsecase = MockControlVolumeUsecase();
  final toggleFavUsecase = MockToggleFavUsecase();
  final getFavsUsecase = MockGetFavsUsecase();
  final getCategoryUsecase = MockGetCategoriesUsecase();

  setUp(() {
    sut = RadioCubit(
      storeChannelsUsecase: storeChannelsUsecase,
      getChannelsUsecase: getChannelsUsecase,
      getAudioUsecase: getAudioUsecase,
      stopAudioUsecase: stopAudioUsecase,
      controlVolumeUsecase: controlVolumeUsecase,
      toggleFavUsecase: toggleFavUsecase,
      getFavsUsecase: getFavsUsecase,
      getCategoryUsecase: getCategoryUsecase,
    );
  });

  const soundUrl = "soundUrl";
  final tChannel = Channel(
    id: 0,
    name: "name",
    type: "type",
    soundUrl: soundUrl,
    img: "img",
    fav: false,
  );

  group("testing playChannel method", () {
    // test("playChannel should return Right", () async {
    //   // arrange
    //   when(
    //     () => getAudioUsecase.call(soundUrl),
    //   ).thenAnswer((invocation) async => Right(NoParams()));

    //   // act
    //   final future = sut.playChannel(
    //     channel: tChannel,
    //   );

    //   // assert
    //   verify(
    //     () => getAudioUsecase.call(soundUrl),
    //   ).called(equals(1));
    //   expect(sut.state, equals(RadioChannelPressedState()));
    //   expect(sut.playbarChannel, equals(tChannel));
    //   expect(sut.playPauseIcon, equals(IconsManager.pauseIcon));
    //   await future;
    //   expect(sut.state, equals(RadioAudioSuccessState()));
    // });

    test("playChannel should return Left", () async {
      // arrange
      when(
        () => getAudioUsecase.call(soundUrl),
      ).thenThrow(Exception());

      // act
      final future = sut.playChannel(
        channel: tChannel,
      );

      // assert
      verify(
        () => getAudioUsecase.call(soundUrl),
      ).called(equals(1));
      expect(sut.state, equals(RadioChannelPressedState()));
      // expect(sut.playbarChannel, equals(tChannel));
      // expect(sut.playPauseIcon, equals(IconsManager.pauseIcon));
      // await future;
      // expect(sut.playPauseIcon, equals(IconsManager.playIcon));
      // expect(sut.state, equals(RadioAudioErrorState()));
    });
  });
}
