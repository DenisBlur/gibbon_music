import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/DesignWidget/Audio/Player/AudioControls.dart';
import 'package:gibbon_music/DesignWidget/Audio/Player/AudioInfo.dart';

import '../../../API/MainMethod/MV_AudioPlayer.dart';
import 'AudioSecondControl.dart';

MvAudioPlayer player = MvAudioPlayer();

class AudioPlayerWidget extends StatefulWidget {
  const AudioPlayerWidget({Key key}) : super(key: key);

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  @override
  void initState() {
    super.initState();

    player.setAudio(
        "https://cdn7.deliciouspeaches.com/get/cuts/d7/7f/d77f4f45b3541506b1d2a94886a119ef/73156409/INSTASAMKA_-_LIPSI_HA_b128f0d121.mp3");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FluentTheme.of(context).cardColor,
      padding: EdgeInsets.only(left: 16, right: 16),
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: Row(
        children: const [
          AudioInfo(),
          Expanded(
            child: AudioControl(),
          ),
          AudioSecondControl(),
        ],
      ),
    );
  }
}
