import 'dart:ui';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/DesignWidget/Audio/Player/Windows/WinAudioControls.dart';
import 'package:gibbon_music/DesignWidget/Audio/Player/Windows/WinAudioInfo.dart';

import '../../../../API/MainMethod/MV_AudioPlayer.dart';
import 'AndAudioSecondControl.dart';

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
    player.initAudio();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width,
        height: 100,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                padding: const EdgeInsets.only(left: 16, right: 16),
                decoration: BoxDecoration(
                  color: FluentTheme.of(context).cardColor.withOpacity(.8),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                      color: FluentTheme.of(context)
                          .borderInputColor
                          .withOpacity(.1),
                      width: .8),
                ),
                child: Stack(
                  children: const [
                    AudioInfo(),
                    Center(
                      child: AudioControl(),
                    ),
                    AudioSecondControl(),
                  ],
                ),
              )),
        ));
  }
}
