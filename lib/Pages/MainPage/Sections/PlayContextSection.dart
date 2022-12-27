import 'package:animate_do/animate_do.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_telegram/API/Models/NewHomePage/MV_PlayContext.dart';
import 'package:gibbon_telegram/DesignWidget/Audio/ListItems/AlbumItem.dart';
import 'package:gibbon_telegram/DesignWidget/Audio/ListItems/ArtistItem.dart';

class PlayContextSection extends StatefulWidget {
  const PlayContextSection({Key? key, required this.playContexts})
      : super(key: key);

  final List<MvPlayContext> playContexts;

  @override
  State<PlayContextSection> createState() => _PlayContextSectionState();
}

class _PlayContextSectionState extends State<PlayContextSection> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return FadeInRight(
              duration: Duration(milliseconds: 250),
              delay: Duration(milliseconds: 50 * index),
              child: widget.playContexts[index].context == "album"
                  ? AlbumItem(
                      playContext: widget.playContexts[index],
                    )
                  : widget.playContexts[index].context == "artist"
                      ? ArtistItem(
                          playContext: widget.playContexts[index],
                        )
                      : Text("Hi"));
        },
        itemCount: widget.playContexts.length,
      ),
    );
    ;
  }
}
