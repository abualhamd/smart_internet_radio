import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_internet_radio/app/core/errors/failures.dart';
import 'package:smart_internet_radio/app/core/usecases/use_case.dart';
import 'package:smart_internet_radio/app/core/utils/enums.dart';
import 'package:smart_internet_radio/data/datasources/local_data_source.dart';
import 'package:smart_internet_radio/data/models/channel_model.dart';
import 'package:smart_internet_radio/domain/entities/channel.dart';
import 'package:smart_internet_radio/domain/repositories/channel_repo.dart';
import 'package:smart_internet_radio/domain/usecases/channel/get_categories.dart';
import 'package:smart_internet_radio/domain/usecases/channel/get_channels.dart';

class MockChannelRepo extends Mock implements ChannelRepo {}

void main() {
  final channels = [
    ChannelModel.fromJson(json: jsonChannels[0]),
    ChannelModel.fromJson(json: jsonChannels[1]),
  ];

  group("testing GetChannelsUsecase", () {
    final mockChannelRepo = MockChannelRepo();
    late GetChannelsUsecase stu;

    setUp(() {
      stu = GetChannelsUsecase(channelRepo: mockChannelRepo);
    });

    test("should return a list of channels", () async {
      when(
        () => mockChannelRepo.getChannels(),
      ).thenAnswer((_) async => Right(channels));

      final actualResult = await stu.call(NoParams());

      expect(actualResult, Right<Failure, List<Channel>>(channels));
    });

    test("should return a failure", () async {
      final localDatabaseFailure = LocalDatabaseFailure();
      when(
        () => mockChannelRepo.getChannels(),
      ).thenAnswer((_) async => Left(localDatabaseFailure));

      final actualResult = await stu.call(NoParams());

      expect(actualResult, Left(localDatabaseFailure));
    });
  });

  group("testing", () {
    final mockChannelRepo = MockChannelRepo();
    late GetCategoriesUsecase stu;

    setUp(() {
      stu = GetCategoriesUsecase(channelRepo: mockChannelRepo);
    });

    test("Testing GetCategoriesUsecase should return a list of categories", () async {
      final map = {
        Categories.quran: channels,
      };
      when(
        () => mockChannelRepo.getCategories(),
      ).thenAnswer((_) async => Right(map));

      final actualResult = await stu.call(NoParams());

      expect(actualResult,
          Right<Failure, Map<Categories, List<ChannelModel>>>(map));

      verify(() => mockChannelRepo.getCategories()).called(1);
    });

    test("Testing GetCategoriesUsecase should return a failure", () async {
      // resetMocktailState();
      final localDatabaseFailure = LocalDatabaseFailure();
      when(
        () => mockChannelRepo.getCategories(),
      ).thenAnswer((_) async => Left(localDatabaseFailure));

      final actualResult = await stu.call(NoParams());
      expect(actualResult, Left(localDatabaseFailure));
      // verifyNoMoreInteractions(mockChannelRepo);
      // verifyInOrder([]);
      verify(() => mockChannelRepo.getCategories()).called(1);
      // logInvocations([mockChannelRepo]);
    });
  });
}
