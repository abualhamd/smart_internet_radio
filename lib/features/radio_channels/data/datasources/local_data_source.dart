import 'package:smart_internet_radio/core/utils/app_strings.dart';
import 'package:smart_internet_radio/core/utils/assets_manager.dart';
import 'package:smart_internet_radio/features/radio_channels/data/models/channel_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class ChannelsLocalDataSource {
  Future<void> storeChannels();
  Future<List<ChannelModel>> getChannels();
  Future<List<ChannelModel>> getFavorites();
  Future<Map<String, List<ChannelModel>>> getCategories();
  Future<void> toggleFav({required int id, required String cond});
}

class ChannelsLocalDataSourceImpl implements ChannelsLocalDataSource {
  Database? _database;

  static const String tableName = 'channels';

  @override
  Future<void> storeChannels() async {
    _database = await openDatabase(
      'radio.db',
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE $tableName (id INTEGER PRIMARY KEY, name Text, type TEXT, img Text, soundUrl Text, fav Text)');

        for (var channel in jsonChannels) {
          await db.transaction((txn) async {
            await txn.rawInsert(
                'INSERT INTO $tableName(name, type, img, soundUrl, fav) VALUES("${channel['name']}", "${channel['type']}", "${channel['img']}", "${channel['soundUrl']}","${channel['fav']}")');
          });
        }
      },
      onOpen: (db) {},
    );
  }

  @override
  Future<List<ChannelModel>> getChannels() async {
    List<Map<String, dynamic>> channels =
        await _database!.rawQuery('SELECT * FROM $tableName');

    return channels
        .map((channel) => ChannelModel.fromJson(json: channel))
        .toList();
  }

  @override
  Future<List<ChannelModel>> getFavorites() async {
    var response = await _database!
        .rawQuery('SELECT * FROM $tableName WHERE fav = ?', [true.toString()]);

    List<ChannelModel> favs = [];
    for (var fav in response) {
      favs.add(ChannelModel.fromJson(json: fav));
    }

    return favs;
  }

  var ctgryNames = [
    AppStrings.categQuran,
    AppStrings.categNews,
    AppStrings.categMusic,
    AppStrings.categSports
  ];

  @override
  Future<Map<String, List<ChannelModel>>> getCategories() async {
    Map<String, List<ChannelModel>> categories = {};

    for (var category in ctgryNames) {
      List<Map<String, dynamic>> response = await _database!.rawQuery(
          'SELECT * FROM $tableName where type = ?', [category.toLowerCase()]);

      List<ChannelModel> categoryChannels = [];

      for (var channel in response) {
        categoryChannels.add(ChannelModel.fromJson(json: channel));
      }
      categories[category] = categoryChannels;
    }

    return categories;
  }

  @override
  Future<void> toggleFav({required int id, required String cond}) async {
    await _database!
        .rawUpdate('UPDATE $tableName SET fav = ? WHERE id = ?', [cond, id]);
  }
}

final jsonChannels = [
  {
    'id': 1,
    'name': 'Tarateel',
    'type': 'quran',
    'img': AssetsManager.tarateel,
    'soundUrl': 'https://Qurango.net/radio/tarateel',
    'fav': false.toString(),
  },
  {
    'id': 2,
    'name': '9090 FM',
    'type': 'sports',
    'img': AssetsManager.fm9090,
    'soundUrl': 'https://9090streaming.mobtada.com/9090FMEGYPT',
    'fav': false.toString(),
  },
  {
    'id': 3,
    'name': 'Quran',
    'type': 'quran',
    'img': AssetsManager.quraan,
    'soundUrl': 'https://Qurango.net/radio/mohammad_altablaway',
    'fav': false.toString(),
  },
  {
    'id': 4,
    'name': '90s FM',
    'type': 'news',
    'img': AssetsManager.fm90,
    'soundUrl': 'https://eu1.fastcast4u.com/proxy/prontofm?mp=/1',
    'fav': false.toString(),
  },
  {
    'id': 5,
    'name': 'Mahatet masr',
    'type': 'news',
    'img': AssetsManager.mahtatMasr,
    'soundUrl': 'https://s3.radio.co/s9cb11828c/listen',
    'fav': false.toString(),
  },
  {
    'id': 6,
    'name': 'Nagham FM',
    'type': 'music',
    'img': AssetsManager.naghamFM,
    'soundUrl': 'https://ahmsamir.radioca.st/stream',
    'fav': false.toString(),
  },
  {
    'id': 7,
    'name': 'Banha',
    'type': 'music',
    'img': AssetsManager.banha,
    'soundUrl': 'https://whsh4u-panel.com/proxy/wzwpdthd?mp=/stream',
    'fav': false,
  },
  {
    'id': 8,
    'name': 'Sha3bi FM',
    'type': 'music',
    'img': AssetsManager.sha3bi,
    'soundUrl': 'https://radio95.radioca.st/stream/1/',
    'fav': false.toString(),
  },
  {
    'id': 9,
    'name': 'Eza3et Al-Ahram',
    'type': 'news',
    'img': AssetsManager.alahram,
    'soundUrl': 'https://radiostream.ahram.org.eg/stream',
    'fav': false.toString(),
  },
  // TODO replace
  // {
  //   'id': 10,
  //   'name': 'Elkhalas',
  //   'type': 'music',
  //   'imageUrl': ImgsManager.elkhalas,
  //   'soundUrl': 'https://i7.streams.ovh/sc/hoperad2/stream',
  //   'fav': false,
  // },
  {
    'id': 10,
    'name': 'Radio Masr',
    'type': 'news',
    'img': AssetsManager.radioMasr,
    'soundUrl': 'https://live.radiomasr.net/RADIOMASR',
    'fav': false.toString(),
  },
  {
    'id': 11,
    'name': 'Energy FM',
    'type': 'music',
    'img': AssetsManager.energy,
    'soundUrl': 'https://nrjstreaming.ahmed-melege.com/nrjegypt',
    'fav': false.toString(),
  },
  {
    'id': 12,
    'name': 'BBC Arabic',
    'type': 'news',
    'img': AssetsManager.bbc,
    'soundUrl': 'https://stream.live.vc.bbcmedia.co.uk/bbc_arabic_radio',
    'fav': false.toString(),
  },
  {
    'id': 13,
    'name': 'Sky news',
    'type': 'news',
    'img': AssetsManager.sky,
    'soundUrl': 'https://radio.skynewsarabia.com/stream/radio/skynewsarabia',
    'fav': false.toString(),
  }
];
