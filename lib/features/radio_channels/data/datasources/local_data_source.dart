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

  @override
  Future<void> storeChannels() async {
    _database = await openDatabase(
      'radio.db',
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE channels (id INTEGER PRIMARY KEY, name Text, type TEXT, img Text, soundUrl Text, fav Text)');

        for (var channel in jsonChannels) {
          await db.transaction((txn) async {
            await txn.rawInsert(
                'INSERT INTO channels(name, type, img, soundUrl, fav) VALUES("${channel['name']}", "${channel['type']}", "${channel['img']}", "${channel['soundUrl']}","${channel['fav']}")');
          });
        }
      },
      onOpen: (db) {},
    );
  }

  @override
  Future<List<ChannelModel>> getChannels() async {
    List<Map<String, dynamic>> channels =
        await _database!.rawQuery('SELECT * FROM channels');

    return Future.value(channels
        .map((channel) => ChannelModel.fromJson(json: channel))
        .toList());
  }

  @override
  Future<List<ChannelModel>> getFavorites() async {
    var response = await _database!
        .rawQuery('SELECT * FROM channels WHERE fav = ?', [true.toString()]);

    List<ChannelModel> favs = [];
    for (var fav in response) {
      favs.add(ChannelModel.fromJson(json: fav));
    }

    return favs;
  }

  var ctgryNames = [AppStrings.categQuran, AppStrings.categNews, AppStrings.categMusic, AppStrings.categSports];

  @override
  Future<Map<String, List<ChannelModel>>> getCategories() async {
    Map<String, List<ChannelModel>> categories = {};

    for (var category in ctgryNames) {
      List<Map<String, dynamic>> response = await _database!
          .rawQuery('SELECT * FROM channels where type = ?', [category.toLowerCase()]);

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
        .rawUpdate('UPDATE channels SET fav = ? WHERE id = ?', [cond, id]);
  }
}

final jsonChannels = [
  {
    'id': 0,
    'name': 'Tarateel',
    'type': 'quran',
    'img': ImgsManager.tarateel,
    'soundUrl': 'https://Qurango.net/radio/tarateel',
    'fav': false.toString(),
  },
  {
    'id': 1,
    'name': '9090 FM',
    'type': 'sports',
    'img': ImgsManager.fm9090,
    'soundUrl': 'https://9090streaming.mobtada.com/9090FMEGYPT',
    'fav': false.toString(),
  },
  {
    'id': 2,
    'name': 'Quran',
    'type': 'quran',
    'img': ImgsManager.quraan,
    'soundUrl': 'https://Qurango.net/radio/mohammad_altablaway',
    'fav': false.toString(),
  },
  {
    'id': 3,
    'name': '90s FM',
    'type': 'news',
    'img': ImgsManager.fm90,
    'soundUrl': 'https://eu1.fastcast4u.com/proxy/prontofm?mp=/1',
    'fav': false.toString(),
  },
  {
    'id': 4,
    'name': 'Mahatet masr',
    'type': 'news',
    'img': ImgsManager.mahtatMasr,
    'soundUrl': 'https://s3.radio.co/s9cb11828c/listen',
    'fav': false.toString(),
  },
  {
    'id': 5,
    'name': 'Nagham FM',
    'type': 'music',
    'img': ImgsManager.naghamFM,
    'soundUrl': 'https://ahmsamir.radioca.st/stream',
    'fav': false.toString(),
  },
  {
    'id': 6,
    'name': 'Banha',
    'type': 'music',
    'img': ImgsManager.banha,
    'soundUrl': 'https://whsh4u-panel.com/proxy/wzwpdthd?mp=/stream',
    'fav': false,
  },
  // TODO remove this one
  {
    'id': 7,
    'name': 'EGONAIR',
    'type': 'music',
    'img': ImgsManager.egonair,
    'soundUrl': 'http://www.egonair.com:8010/;',
    'fav': false,
  },
  {
    'id': 8,
    'name': 'Sha3bi FM',
    'type': 'music',
    'img': ImgsManager.sha3bi,
    'soundUrl': 'https://radio95.radioca.st/stream/1/',
    'fav': false.toString(),
  },
  {
    'id': 9,
    'name': 'Eza3et Al-Ahram',
    'type': 'news',
    'img': ImgsManager.alahram,
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
    'img': ImgsManager.radioMasr,
    'soundUrl': 'https://live.radiomasr.net/RADIOMASR',
    'fav': false.toString(),
  },
  {
    'id': 11,
    'name': 'Energy FM',
    'type': 'music',
    'img': ImgsManager.energy,
    'soundUrl': 'https://nrjstreaming.ahmed-melege.com/nrjegypt',
    'fav': false.toString(),
  },
  {
    'id': 12,
    'name': 'BBC Arabic',
    'type': 'news',
    'img': ImgsManager.bbc,
    'soundUrl': 'https://stream.live.vc.bbcmedia.co.uk/bbc_arabic_radio',
    'fav': false.toString(),
  },
  {
    'id': 13,
    'name': 'Sky news',
    'type': 'news',
    'img': ImgsManager.sky,
    'soundUrl': 'https://radio.skynewsarabia.com/stream/radio/skynewsarabia',
    'fav': false.toString(),
  }
];
