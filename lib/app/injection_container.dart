import 'package:get_it/get_it.dart' as di;
import 'package:just_audio/just_audio.dart';
import 'package:smart_internet_radio/data/datasources/local_data_source.dart';
import 'package:smart_internet_radio/data/datasources/remote_data_source.dart';
import 'package:smart_internet_radio/data/repositories/channel_repo_impl.dart';
import 'package:smart_internet_radio/domain/repositories/channel_repo.dart';
import 'package:smart_internet_radio/domain/usecases/audio/control_volume.dart';
import 'package:smart_internet_radio/domain/usecases/audio/get_audio.dart';
import 'package:smart_internet_radio/domain/usecases/audio/stop_audio.dart';
import 'package:smart_internet_radio/domain/usecases/channel/get_categories.dart';
import 'package:smart_internet_radio/domain/usecases/channel/get_channels.dart';
import 'package:smart_internet_radio/domain/usecases/channel/get_favs.dart';
import 'package:smart_internet_radio/domain/usecases/channel/store_channels.dart';
import 'package:smart_internet_radio/domain/usecases/channel/toggle_fav.dart';

import '../presentation/cubit/radio_cubit.dart';

final sl = di.GetIt.instance;

Future<void> init() async {
  ///cubit
  sl.registerFactory<RadioCubit>(
    () => RadioCubit(
        storeChannelsUsecase: sl(),
        getChannelsUsecase: sl(),
        getAudioUsecase: sl(),
        stopAudioUsecase: sl(),
        toggleFavUsecase: sl(),
        getFavsUsecase: sl(),
        getCategoryUsecase: sl(),
        controlVolumeUsecase: sl()),
  );

  ///usecase
  sl.registerLazySingleton<StoreChannelsUsecase>(
      () => StoreChannelsUsecase(channelRepo: sl()));

  sl.registerLazySingleton<GetChannelsUsecase>(
      () => GetChannelsUsecase(channelRepo: sl()));

  sl.registerLazySingleton<GetAudioUsecase>(
      () => GetAudioUsecase(channelRepo: sl()));

  sl.registerLazySingleton<StopAudioUsecase>(
      () => StopAudioUsecase(channelRepo: sl()));

  sl.registerLazySingleton<ToggleFavUsecase>(
      () => ToggleFavUsecase(channelRepo: sl()));

  sl.registerLazySingleton<GetFavsUsecase>(
      () => GetFavsUsecase(channelRepo: sl()));

  sl.registerLazySingleton<GetCategoriesUsecase>(
      () => GetCategoriesUsecase(channelRepo: sl()));

  sl.registerLazySingleton<ControlVolumeUsecase>(
      () => ControlVolumeUsecase(channelRepo: sl()));

  ///repo
  sl.registerLazySingleton<ChannelRepo>(
      () => ChannelRepoImpl(localDataSource: sl(), audioPlayer: sl()));

  ///data sources
  sl.registerLazySingleton<ChannelsLocalDataSource>(
      () => ChannelsLocalDataSourceImpl());

  sl.registerLazySingleton<AppAudioPlayer>(
      () => AppAudioPlayerImpl(audioPlayer: sl()));

  ///core
  sl.registerLazySingleton<AudioPlayer>(() => AudioPlayer());
}
