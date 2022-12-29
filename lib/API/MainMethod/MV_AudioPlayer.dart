import 'package:audioplayers/audioplayers.dart';

class MvAudioPlayer {

  AudioPlayer player;

  initAudio() async {
    player = AudioPlayer();
  }

  disposeAudio() {
    player.stop();
    player.dispose();
  }

  PlayerState getState() {
    return player.state;
  }

  setAudio(String url) async {
    await player.setSourceUrl(url);
    playAudio();
  }

  playAudio() async {
    await player.resume();
  }

  pauseAudio() async {
    await player.pause();
  }

  setSeek(int ms) async {
    Duration seekTime = Duration(milliseconds: ms);
    await player.seek(seekTime);
  }

  setVolume(double value) async {
    await player.setVolume(value);
  }

  setSpeed(double value) async {
    await player.setPlaybackRate(value);
  }


}