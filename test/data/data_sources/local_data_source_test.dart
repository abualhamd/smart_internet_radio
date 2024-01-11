import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:smart_internet_radio/data/datasources/local_data_source.dart';

class MockDatabase extends Mock implements Database {}

void main() {
  group('ChannelsLocalDataSourceImpl', () {
    // late DatabaseMock databaseMock;
    late ChannelsLocalDataSourceImpl stu;

    late MockDatabase tDb;

    setUpAll(() async {
      // databaseMock = DatabaseMock();
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;

      stu = ChannelsLocalDataSourceImpl();

      tDb = await openDatabase(inMemoryDatabasePath, version: 1,
          onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE ${ChannelsLocalDataSourceImpl.tableName} (id INTEGER PRIMARY KEY, name Text, type TEXT, img Text, soundUrl Text, fav Text)');
      });
    });

    // tearDown(() {
    //   reset(databaseMock);
    // });

    test('Test storeChannels', () async {
      // Arrange
      // when(() => openDatabase(any(),
      //     version: any(),
      //     onCreate: any(),
      //     onOpen: any())).thenAnswer((_) async => tDb);

      // Act
      await stu.storeChannels();

      // Assert
      // verify(() => openDatabase(any(),
      //     version: any(), onCreate: any(), onOpen: any())).called(1);
      verify(() => tDb.execute(any())).called(jsonChannels.length);
      verify(() => tDb.transaction(any())).called(jsonChannels.length);
      verify(() => tDb.rawInsert(any(), any())).called(jsonChannels.length);
    });

    // test('Test getChannels', () async {
    //   // Arrange
    //   final expectedChannels = jsonChannels.map((channel) => ChannelModel.fromJson(json: channel)).toList();
    //   when(() => databaseMock.rawQuery(any())).thenAnswer((_) async => []);

    //   // Act
    //   final result = await dataSource.getChannels();

    //   // Assert
    //   expect(result, expectedChannels);
    //   verify(() => databaseMock.rawQuery(any())).called(1);
    // });

    // test('Test getFavorites', () async {
    //   // Arrange
    //   final expectedFavorites = jsonChannels
    //       .where((channel) => channel['fav'] == true.toString())
    //       .map((channel) => ChannelModel.fromJson(json: channel))
    //       .toList();
    //   when(() => databaseMock.rawQuery(any(), any())).thenAnswer((_) async => []);

    //   // Act
    //   final result = await dataSource.getFavorites();

    //   // Assert
    //   expect(result, expectedFavorites);
    //   verify(() => databaseMock.rawQuery(any(), any())).called(1);
    // });

    // test('Test getCategories', () async {
    //   // Arrange
    //   final expectedCategories = Map<Categories, List<ChannelModel>>();
    //   for (final category in Categories.values) {
    //     expectedCategories[category] = [];
    //   }
    //   when(() => databaseMock.rawQuery(any(), any())).thenAnswer((_) async => []);

    //   // Act
    //   final result = await dataSource.getCategories();

    //   // Assert
    //   expect(result, expectedCategories);
    //   verify(() => databaseMock.rawQuery(any(), any())).called(Categories.values.length);
    // });

    // test('Test toggleFav', () async {
    //   // Arrange
    //   const id = 1;
    //   const cond = 'true';
    //   when(() => databaseMock.rawUpdate(any(), any())).thenAnswer((_) async => 1);

    //   // Act
    //   await dataSource.toggleFav(id: id, cond: cond);

    //   // Assert
    //   verify(() => databaseMock.rawUpdate(any(), any())).called(1);
    // });
  });
}
