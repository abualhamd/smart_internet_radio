import 'package:flutter_test/flutter_test.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_internet_radio/data/datasources/remote_data_source.dart';

class MockAudioPlayer extends Mock implements AudioPlayer {}

void main() {
  late AppAudioPlayerImpl stu;
  final mockAudioPlayer = MockAudioPlayer();

  setUp(() {
    stu = AppAudioPlayerImpl(audioPlayer: mockAudioPlayer);
  });

  tearDown(() {
    reset(mockAudioPlayer);
  });

  const tUrl = "";

  test("testing getAudio", () async {
    // arrange
    when(
      () => mockAudioPlayer.stop(),
    ).thenAnswer((invocation) async {});
    when(
      () => mockAudioPlayer.setUrl(tUrl),
    ).thenAnswer((_) async {
      return null;
    });
    when(
      () => mockAudioPlayer.play(),
    ).thenAnswer((_) async {
      return;
    });

    // act
    await stu.getAudio(url: tUrl);

    // assert
    verifyInOrder([
      () => mockAudioPlayer.stop(),
      () => mockAudioPlayer.setUrl(tUrl),
      () => mockAudioPlayer.play(),
    ]);
  });
}
