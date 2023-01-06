import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/DesignWidget/Player/AudioInfo.dart';
import 'package:gibbon_music/main.dart';

import '../AudioMiniControls.dart';

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
        margin: const EdgeInsets.all(4),
        width: MediaQuery.of(context).size.width,
        child: Container(
          padding: const EdgeInsets.only(left: 4, right: 4),
          child: Row(
            children: const [
              AudioInfo(hasImage: false,),
              Expanded(child: SizedBox(),),
              MiniAudioControl(),
            ],
          ),
        )
        );
  }
}