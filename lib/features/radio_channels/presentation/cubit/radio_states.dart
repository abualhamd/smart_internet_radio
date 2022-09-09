part of 'radio_cubit.dart';

abstract class RadioState extends Equatable {
  const RadioState();

  @override
  List<Object> get props => [];
}

class RadioInitState extends RadioState {}

class RadioStoreChannelsSuccessState extends RadioState {}

class RadioStoreChannelsErrorState extends RadioState {}

class RadioGetChannelsSuccessState extends RadioState {}

class RadioGetChannelsErrorState extends RadioState {}

class RadioAudioSuccessState extends RadioState {}

class RadioAudioErrorState extends RadioState {}

class RadioPlayBarPressedState extends RadioState {}

class RadioChannelPressedState extends RadioState {}

class RadioToggleFavSuccessState extends RadioState {}
class RadioToggleFavErrorState extends RadioState {}

class RadioGetFavSuccessState extends RadioState {}
class RadioGetFavErrorState extends RadioState {}

