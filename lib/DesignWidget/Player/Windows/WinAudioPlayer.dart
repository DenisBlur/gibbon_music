import 'package:animate_do/animate_do.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/DesignWidget/Player/AudioInfo.dart';
import 'package:gibbon_music/main.dart';
import 'package:provider/provider.dart';

import '../../../API/NotifyModels/GeneralNotifyModel.dart';
import '../AudioControls.dart';
import '../AudioSecondControl.dart';

class AudioPlayerWidget extends StatefulWidget {
  const AudioPlayerWidget({Key key}) : super(key: key);

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.only(left: 16, right: 16),
      decoration: BoxDecoration(
        color: FluentTheme.of(context).cardColor,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(.15), blurRadius: 10, offset: const Offset(0,-4))
        ]
      ),
      child: context.watch<GeneralNotifyModel>().mTrack != null
          ? FadeInUp(
              child: Stack(
              children: const [
                AudioInfo(),
                Center(
                  child: AudioControl(),
                ),
                AudioSecondControl(),
              ],
            ))
          : const Center(child: Text("Ожидание трека")),
    );
  }
}
