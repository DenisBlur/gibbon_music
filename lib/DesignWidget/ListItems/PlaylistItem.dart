import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/API/MainMethod/GMethod.dart';
import 'package:gibbon_music/DesignWidget/Styles/ConstValue.dart';
import 'package:gibbon_music/NewAPI/models/M_Playlist.dart';
import 'package:transparent_image/transparent_image.dart';

class PlaylistItem extends StatelessWidget {
  const PlaylistItem({Key key, @required this.playlist, @required this.index})
      : super(key: key);

  final MPlaylist playlist;
  final int index;

  @override
  Widget build(BuildContext context) {
    String lowerText = "";

    return HoverButton(
      onPressed: () {},
      builder: (p0, state) {
        return Padding(
          padding: EdgeInsets.only(right: 16, left: index == 0 && Platform.isAndroid ? 16 : 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AnimatedContainer(
                width: 150,
                padding: EdgeInsets.all(
                    state.isHovering || state.isPressing ? 8 : 0),
                duration: fastAnimation,
                curve: Curves.fastLinearToSlowEaseIn,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                      color: FluentTheme.of(context)
                          .borderInputColor
                          .withOpacity(
                              state.isHovering || state.isPressing ? .2 : 0),
                      width: .5),
                  color: FluentTheme.of(context).cardColor,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: FadeInImage.memoryNetwork(
                    fit: BoxFit.cover,
                    image: linkImage(playlist.cover.uri, 200),
                    placeholder: kTransparentImage,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(playlist.title),
              Text(
                "Playlist",
                style: TextStyle(
                    color: FluentTheme.of(context).accentColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
              Text(lowerText),
            ],
          ),
        );
      },
    );
  }
}
