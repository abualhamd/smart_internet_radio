import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_internet_radio/core/usecases/use_case.dart';
import 'package:smart_internet_radio/core/utils/app_icons.dart';
import 'package:smart_internet_radio/features/radio_channels/domain/entities/channel.dart';
import 'package:smart_internet_radio/features/radio_channels/domain/usecases/audio/get_audio.dart';
import 'package:smart_internet_radio/features/radio_channels/domain/usecases/audio/stop_audio.dart';
import 'package:smart_internet_radio/features/radio_channels/domain/usecases/channel/get_categories.dart';
import 'package:smart_internet_radio/features/radio_channels/domain/usecases/channel/get_channels.dart';
import 'package:smart_internet_radio/features/radio_channels/domain/usecases/channel/get_favs.dart';
import 'package:smart_internet_radio/features/radio_channels/domain/usecases/channel/store_channels.dart';
import 'package:smart_internet_radio/features/radio_channels/domain/usecases/channel/toggle_fav.dart';
import '../../../../core/errors/failures.dart';
part 'radio_states.dart';

class RadioCubit extends Cubit<RadioState> {
  RadioCubit({
    required StoreChannelsUsecase storeChannelsUsecase,
    required GetChannelsUsecase getChannelsUsecase,
    required GetAudioUsecase getAudioUsecase,
    required StopAudioUsecase stopAudioUsecase,
    required ToggleFavUsecase toggleFavUsecase,
    required GetFavsUsecase getFavsUsecase,
    required GetCategoryUsecase getCategoryUsecase,
  })  : _storeChannelsUsecase = storeChannelsUsecase,
        _getChannelsUsecase = getChannelsUsecase,
        _getAudioUsecase = getAudioUsecase,
        _stopAudioUsecase = stopAudioUsecase,
        _toggleFavUsecase = toggleFavUsecase,
        _getFavsUsecase = getFavsUsecase,
        _getCategoryUsecase = getCategoryUsecase,
        super(RadioInitState());

  final GetChannelsUsecase _getChannelsUsecase;
  final StoreChannelsUsecase _storeChannelsUsecase;
  final GetAudioUsecase _getAudioUsecase;
  final StopAudioUsecase _stopAudioUsecase;
  final ToggleFavUsecase _toggleFavUsecase;
  final GetFavsUsecase _getFavsUsecase;
  final GetCategoryUsecase _getCategoryUsecase;

  List<Channel> channels = [];
  List<Channel> favs = [];
  Map<String, List<Channel>> channelsCategories = {};
  Channel? playbarChannel;
  Icon playPauseIcon = AppIcons.playIcon;

  static RadioCubit get(BuildContext context) => BlocProvider.of(context);

  void openDatabase() async {
    Either<Failure, NoParams> response =
        await _storeChannelsUsecase(NoParams());

    response.fold((failure) {
      emit(RadioStoreChannelsErrorState());
    }, (success) {
      emit(RadioStoreChannelsSuccessState());
    });
  }

  Future<void> getChannels() async {
    Either<Failure, List<Channel>> response =
        await _getChannelsUsecase(NoParams());

    response.fold((failure) => emit(RadioGetChannelsErrorState()),
        (radioChannels) {
      channels = radioChannels;
      playbarChannel = channels[0];
      
      emit(RadioGetChannelsSuccessState());
    });
  }

  Future<void> playChannel({required Channel channel}) async {
    emit(RadioChannelPressedState());

    playbarChannel = channel;
    playPauseIcon = AppIcons.pauseIcon;

    var response = await _getAudioUsecase(playbarChannel!.soundUrl);
    response.fold((failure) {
      emit(RadioAudioErrorState());
    }, (r) {
      emit(RadioAudioSuccessState());
    });
  }

  Future<void> pressPlaybar() async {
    emit(RadioPlayBarPressedState());

    try {
      if (playPauseIcon == AppIcons.playIcon) {
        playPauseIcon = AppIcons.pauseIcon;
        await _getAudioUsecase(playbarChannel!.soundUrl);
      } else {
        playPauseIcon = AppIcons.playIcon;
        await _stopAudioUsecase(NoParams());
      }
      emit(RadioAudioSuccessState());
    } catch (error) {
      emit(RadioAudioErrorState());
    }
  }

  // void eraseDatabase() async {
  //   try {
  //     String databasesPath = await getDatabasesPath();
  //     String path = '$databasesPath/radio.db';
  //     deleteDatabase(path);
  //     print('deleted');
  //   } catch (error) {
  //     print(error);
  //   }
  // }

  Future<void> toggleFav({required int id, required bool cond}) async {
    emit(RadioToggleFavPressedState());

    var response =
        await _toggleFavUsecase(FavParams(id: id, cond: (!cond).toString()));

    emit(response.fold((failure) => RadioToggleFavErrorState(), (success) {
      channels[id - 1].fav = !cond;
      return RadioToggleFavSuccessState();
    }));
  }

  Future<void> getFavs() async {
    var response = await _getFavsUsecase(NoParams());

    emit(
      response.fold((failure) => RadioGetFavErrorState(), (favChannels) {
        favs = favChannels;
        return RadioGetFavSuccessState();
      }),
    );
  }

  Future<void> getCategories() async {
    emit(RadioGetCategoriesLoadingState());

    var response = await _getCategoryUsecase(NoParams());
    response.fold((failue) {
      emit(RadioGetCategoriesErrorState());
    }, (categories) {
      channelsCategories = categories;

      emit(RadioGetCategoriesSuccessState());
    });
  }
}
