import 'package:just_audio/just_audio.dart';

abstract class AppAudioPlayer {
  Future<void> getAudio({required String url});
  Future<void> stopAudio();
  Future<void> controlVolume({required double volume});
}

class AppAudioPlayerImpl implements AppAudioPlayer {
  AppAudioPlayerImpl({required AudioPlayer audioPlayer})
      : _audioPlayer = audioPlayer;
  final AudioPlayer _audioPlayer;

  @override
  Future<void> getAudio({required String url}) async {
    await _audioPlayer.stop();
    await _audioPlayer.setUrl(url);
    await _audioPlayer.play();
  }

  @override
  Future<void> stopAudio() async {
    await _audioPlayer.stop();
  }

  @override
  Future<void> controlVolume({required double volume}) async {
    await _audioPlayer.setVolume(volume);
  }
}
