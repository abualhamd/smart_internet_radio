import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'radio_channels_state.dart';

class RadioChannelsCubit extends Cubit<RadioChannelsState> {
  RadioChannelsCubit() : super(RadioChannelsInitial());
}
