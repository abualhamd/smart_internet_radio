import 'package:just_audio/just_audio.dart';

abstract class AppAudioPlayer {
  void getAudio({required String url});
  void stopAudio();
}

class AppAudioPlayerImpl implements AppAudioPlayer {
  AppAudioPlayerImpl({required AudioPlayer audioPlayer})
      : _audioPlayer = audioPlayer;
  final AudioPlayer _audioPlayer;

  @override
  void getAudio({required String url}) async {
    await _audioPlayer.stop();
    await _audioPlayer.setUrl(url);
    await _audioPlayer.play();
  }

  @override
  void stopAudio() async {
    await _audioPlayer.stop();
  }
}
