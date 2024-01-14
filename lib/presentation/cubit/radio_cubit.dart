import 'dart:math';

import 'package:alan_voice/alan_voice.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../../app/core/errors/failures.dart';
import '../../../../app/core/usecases/use_case.dart';
import '../../../../app/core/utils/enums.dart';
import '../../../../app/core/utils/icons_manager.dart';
import '../../../../domain/usecases/audio/control_volume.dart';
import '../../domain/entities/channel.dart';
import '../../domain/usecases/audio/get_audio.dart';
import '../../domain/usecases/audio/stop_audio.dart';
import '../../domain/usecases/channel/get_categories.dart';
import '../../domain/usecases/channel/get_channels.dart';
import '../../domain/usecases/channel/get_favs.dart';
import '../../domain/usecases/channel/store_channels.dart';
import '../../domain/usecases/channel/toggle_fav.dart';

part 'radio_states.dart';

class RadioCubit extends Cubit<RadioState> {
  RadioCubit({
    required StoreChannelsUsecase storeChannelsUsecase,
    required GetChannelsUsecase getChannelsUsecase,
    required GetAudioUsecase getAudioUsecase,
    required StopAudioUsecase stopAudioUsecase,
    required ControlVolumeUsecase controlVolumeUsecase,
    required ToggleFavUsecase toggleFavUsecase,
    required GetFavsUsecase getFavsUsecase,
    required GetCategoriesUsecase getCategoryUsecase,
  })  : _storeChannelsUsecase = storeChannelsUsecase,
        _getChannelsUsecase = getChannelsUsecase,
        _getAudioUsecase = getAudioUsecase,
        _stopAudioUsecase = stopAudioUsecase,
        _controlVolumeUsecase = controlVolumeUsecase,
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
  final GetCategoriesUsecase _getCategoryUsecase;
  final ControlVolumeUsecase _controlVolumeUsecase;

  List<Channel> channels = [];
  List<Channel> favs = [];
  Map<Categories, List<Channel>> channelsCategories = {};
  Channel? playbarChannel;
  Icon playPauseIcon = IconsManager.playIcon;
  Categories? choosenCategory;

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
    playPauseIcon = IconsManager.pauseIcon;

    try {
      await _getAudioUsecase.call(playbarChannel!.soundUrl);
      emit(RadioAudioSuccessState());
    } catch (e) {
      playPauseIcon = IconsManager.playIcon;
      emit(RadioAudioErrorState());
    }

    // var response =
    // await _getAudioUsecase(playbarChannel!.soundUrl);
    // response.fold((failure) {
    // playPauseIcon = AppIcons.playIcon;
    // emit(RadioAudioErrorState());
    // }, (success) {
    //   emit(RadioAudioSuccessState());
    // });
  }

  Future<void> pressPlaybar() async {
    emit(RadioPlayBarPressedState());

    try {
      if (playPauseIcon == IconsManager.playIcon) {
        playPauseIcon = IconsManager.pauseIcon;
        await _getAudioUsecase(playbarChannel!.soundUrl);
      } else {
        playPauseIcon = IconsManager.playIcon;
        await _stopAudioUsecase(NoParams());
      }
      emit(RadioAudioSuccessState());
    } catch (error) {
      if (playPauseIcon != IconsManager.playIcon) {
        playPauseIcon = IconsManager.playIcon;
      }

      emit(RadioAudioErrorState());
    }
  }

  // Future<void> eraseDatabase() async {
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

  // Future<void> update() async {
  //   var response = await _getFavsUsecase(NoParams());
  //   response.fold((failure) => RadioGetFavErrorState(), (favChannels) {
  //     favs = favChannels;
  //   });

  //   var response2 = await _getCategoryUsecase(NoParams());
  //   response2.fold((failue) {
  //     emit(UpdateErrorState());
  //   }, (categories) {
  //     channelsCategories = categories;

  //     emit(UpdateSuccessState());
  //   });
  // }

  Future<void> _controlVolume({required double volume}) async {
    emit(ControlVolumeLoadingState());
    var response = await _controlVolumeUsecase.call(volume);

    response.fold((failure) => emit(ControlVolumeErrorState()),
        (success) => emit(ControlVolumeSuccessState()));
  }

  Future<void> _playRandomFavChannel() async {
    if (favs.isNotEmpty) {
      final rand = Random().nextInt(favs.length);
      await playChannel(channel: favs[rand]);
    }
  }

  void setupAlan() {
    AlanVoice.addButton(dotenv.env['ALAN_KEY'] ?? '',
        buttonAlign: AlanVoice.BUTTON_ALIGN_RIGHT);

    Future<void> handleCommand(Map<String, dynamic> response) async {
      emit(RadioAlanPressedState());
      debugPrint("command was ${response.toString()}");
      switch (response["command"].toString().toLowerCase()) {
        case 'play':
          await playChannel(channel: playbarChannel!);
          break;
        case 'pause':
          await _stopAudioUsecase(NoParams());
          playPauseIcon = IconsManager.playIcon;
          break;
        case 'play_channel':
          int index = response['id'] - 1;
          await playChannel(channel: channels[index]);
          break;
        // TODO add unfavorite and play a channel from favorite
        case 'favorite':
          await toggleFav(id: playbarChannel!.id, cond: !true);
          break;
        case 'favorite_channel':
          int id = response['id'];
          await toggleFav(id: id, cond: !true);
          break;
        case 'play_favorite':
          await _playRandomFavChannel();
          break;
        case 'next':
          int index = playbarChannel!.id % channels.length;
          await playChannel(channel: channels[index]);
          break;
        case 'previous':
          int index = (playbarChannel!.id - 2) % channels.length;
          await playChannel(channel: channels[index]);
          break;
        case 'category':
          int index = response['id'] - 1;
          await playChannel(channel: channels[index]);
          break;
      }
      emit(RadioAlanExecutedState());
    }

    AlanVoice.onButtonState.add((state) async {
      if (kDebugMode) {
        print(state.name);
      }
      switch (state.name) {
        case 'LISTEN':
          await _controlVolume(volume: 0.1);
          break;
        case 'CONNECTING':
          break;
        default:
          await _controlVolume(volume: 1.0);
      }
    });
    AlanVoice.onCommand
        .add((command) async => await handleCommand(command.data));
  }

  void changeChoosenCategory({required Categories category}) {
    choosenCategory = category;

    emit(ChoosenCategoryChangedState());
  }
}
