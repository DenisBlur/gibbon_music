import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:gibbon_music/API/MainMethod/GMethod.dart';
import 'package:gibbon_music/API/Models/NewHomePage/MV_PlayContext.dart';
import 'package:transparent_image/transparent_image.dart';

class PlaylistItem extends StatefulWidget {
  const PlaylistItem({Key? key, required this.playContext}) : super(key: key);

  final MvPlayContext playContext;

  @override
  State<PlaylistItem> createState() => _PlaylistItemState();
}

class _PlaylistItemState extends State<PlaylistItem> {
  @override
  Widget build(BuildContext context) {
    return HoverButton(
      onPressed: () {},
      builder: (p0, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AnimatedContainer(
              width: 150,
              margin: EdgeInsets.only(right: 16),
              padding: EdgeInsets.all(state.isHovering ? 8 : 0),
              duration: const Duration(milliseconds: 250),
              curve: Curves.fastLinearToSlowEaseIn,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                    color: FluentTheme.of(context)
                        .borderInputColor
                        .withOpacity(state.isHovering ? .2 : 0),
                    width: .5),
                color: FluentTheme.of(context).cardColor,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: FadeInImage.memoryNetwork(
                  fit: BoxFit.cover,
                  image: linkImage(widget.playContext.coverUri, 200, 200),
                  placeholder: kTransparentImage,
                ),
              ),
            ),
            Text(widget.playContext.title),
            Text(widget.playContext.description),
            Text(widget.playContext.likesCount),
          ],
        );
      },
    );
  }
}