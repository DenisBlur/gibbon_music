import 'package:animate_do/animate_do.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/API/Models/NewHomePage/MV_PlayContext.dart';
import 'package:gibbon_music/DesignWidget/Audio/ListItems/AAPItem.dart';
import 'package:gibbon_music/DesignWidget/GListView/GInfinityListView.dart';

class PlayContextSection extends StatelessWidget {
  const PlayContextSection({Key key, @required this.playContexts})
      : super(key: key);

  final List<MvPlayContext> playContexts;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 212,
      child: GListView(
        scrollButtons: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return FadeInRight(
            duration: const Duration(milliseconds: 250),
            delay: Duration(milliseconds: 50 * index),
            child: AAPItem(
              playContext: playContexts[index],
            ),
          );
        },
        itemCount: playContexts.length,
      ),
    );
  }
}
