import 'package:audioplayers/audioplayers.dart';
import 'package:gibbon_music/main.dart';
import 'package:yam_api/yam_api.dart';

class MvAudioPlayer {
  AudioPlayer player;

  initAudio() async {
    player = AudioPlayer();

    generalNotifyModel.trackChanged.subscribe((args) async {
      String urlTrack = await YamApi.downloadTrack(args.track.id);
      setAudio(urlTrack);
    });
    player.onPlayerComplete.listen((event) {
        generalNotifyModel.end();
    });

    print("subs count${generalNotifyModel.trackChanged.subscriberCount}");

    //TODO удалить в будущем
    // setAudio("https://s175vlx.storage.yandex.net/get-mp3/4438022348459f073e0c78d0456fc03f/0005f146e10d1f97/rmusic/U2FsdGVkX19vLLS-a9fZy_AXbCnFCf1bUcqFz22flN9P_29g2ufnPsxJO0MCrYfJXYRLurubY0tkC_BTeNvgrLUNhWA5yRBb5kp-etbba4s/7573bcea2f4ab0f63f42346e12b741cf1b3406b055ff09c5bb8ae48c71abb786/19083");
  }

  disposeAudio() {
    player.stop();
    generalNotifyModel.trackChanged.unsubscribeAll();
    player.dispose();
  }

  PlayerState getState() {
    return player.state;
  }

  setAudio(String urlTrack) async {
    if (player == null) {
      initAudio();
      setAudio(urlTrack);
    } else {
      await player.setSourceUrl(urlTrack);
      playAudio();
    }
  }

  playAudio() async {
    await player.resume();
  }

  pauseAudio() async {
    await player.pause();
  }

  nextAudio() {
    generalNotifyModel.next();
  }

  previousAudio() {
    generalNotifyModel.previous();
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
