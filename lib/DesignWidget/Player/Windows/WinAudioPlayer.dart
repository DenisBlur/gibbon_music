import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/API/Models/NotifyModels/GeneralNotifyModel.dart';
import 'package:gibbon_music/DesignWidget/Player/AudioInfo.dart';
import 'package:gibbon_music/main.dart';
import 'package:provider/provider.dart';

import '../AudioControls.dart';
import '../AudioSecondControl.dart';

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
        child: Container(
          padding: const EdgeInsets.only(left: 16, right: 16),
          decoration: BoxDecoration(
            color: FluentTheme.of(context).cardColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
                color: FluentTheme.of(context).borderInputColor.withOpacity(.1),
                width: .8),
          ),
          child: context.watch<GeneralNotifyModel>().mTrack != null ? FadeInUp(child: Stack(
            children: const [
              AudioInfo(),
              Center(
                child: AudioControl(),
              ),
              AudioSecondControl(),
            ],
          ) ): const Center(child: Text("Ожидание трека")),
        ),
      ),
    );
  }
}
